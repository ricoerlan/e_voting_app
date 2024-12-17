import 'dart:async';

import 'package:e_voting/controller/auth_controller.dart';
import 'package:e_voting/data/repository/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Controller untuk logika OTP
class OTPController extends GetxController {
  final _repository =
      Repository(); // Membuat instance dari Repository yang digunakan untuk berinteraksi dengan API atau sumber data.
  final AuthController authController = Get.find<AuthController>();

  var isLoading = false.obs; // Status loading
  var isResendEnabled = false.obs; // Status tombol resend
  var resendCooldown = 60.obs; // Waktu cooldown untuk resend OTP
  Timer? timer; // Timer untuk menghitung mundur cooldown
  var isSubmitEnabled = false.obs; // Status tombol submit

  @override
  void onInit() {
    super.onInit();
    startResendCooldown();
  }

  // Memulai cooldown untuk tombol resend
  void startResendCooldown() {
    isResendEnabled.value = false; // Nonaktifkan tombol resend
    resendCooldown.value = 60; // Set ulang waktu cooldown

    timer?.cancel(); // Batalkan timer sebelumnya jika ada
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCooldown.value > 0) {
        resendCooldown.value--; // Kurangi waktu cooldown
      } else {
        isResendEnabled.value = true; // Aktifkan tombol resend
        timer.cancel(); // Hentikan timer saat selesai
      }
    });
  }

  // Fungsi untuk mengirim ulang OTP
  void resendOTP(String email) async {
    if (isResendEnabled.value) {
      // Logika untuk mengirim ulang OTP
      try {
        await _repository.sendEmailVerification(email: email);

        Get.snackbar('Success', 'OTP terkirim ulang!');
      } catch (e) {
        Get.snackbar('Error', 'OTP gagal terkirim ulang!');
      } finally {
        startResendCooldown(); // Mulai ulang cooldown
      }
    }
  }

  // Fungsi untuk verifikasi OTP
  Future<void> verifyOTP(
      List<TextEditingController> controllers, String email) async {
    isLoading.value =
        true; // Mengatur status loading menjadi true ketika proses login dimulai.
    try {
      final token = joinOTPFields(controllers);
      final data = await _repository.verifyEmailOTP(
          email: email,
          token:
              token); // Melakukan panggilan API untuk login dengan NIM dan password.
      if (data.id != null) {
        // Jika login berhasil (ID pengguna tidak null), tampilkan pesan sukses atau navigasi ke halaman lain
        if (data.id != null) {
          // Jika registrasi berhasil, simpan data profil dan status komite.
          await authController.setCurrentProfile(data: data);
          authController.isCommittee = data.isCommittee;
        }

        Get.showSnackbar(const GetSnackBar(
          title: 'Success',
          message: 'OTP berhasil diverifikasi!',
          duration: Duration(milliseconds: 1500),
        ));
      }
    } catch (e) {
      // Jika terjadi kesalahan, tampilkan Snackbar dengan pesan error.
      Get.showSnackbar(const GetSnackBar(
        title: 'error',
        message: 'Verifikasi Gagal',
        duration: Duration(milliseconds: 1500),
      ));
      if (kDebugMode) {
        print(e); // Cetak error ke konsol jika dalam mode debug.
      }
    } finally {
      isLoading.value =
          false; // Mengatur status loading menjadi false setelah proses login selesai.
    }
  }

  // Periksa apakah semua field OTP telah terisi
  void checkOTPFields(List<TextEditingController> controllers) {
    isSubmitEnabled.value =
        controllers.every((controller) => controller.text.isNotEmpty);
  }

  // Menggabungkan semua input OTP menjadi satu string
  String joinOTPFields(List<TextEditingController> controllers) {
    return controllers.map((controller) => controller.text).join();
  }
}
