import 'package:e_voting/data/model/profile_model.dart';
import 'package:e_voting/data/repository/repository.dart';
import 'package:e_voting/view/auth/login/login_screen.dart';
import 'package:e_voting/view/auth/otp/otp_screen.dart';
import 'package:e_voting/view/bottom_nav_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthController extends GetxController {
  final _repository =
      Repository(); // Membuat instance dari Repository untuk melakukan panggilan API.
// Membuat instance dari SharedPrefRepository untuk mengelola data SharedPreferences.
  bool isLoading =
      false; // Variabel status untuk menandakan apakah aplikasi sedang dalam proses loading.
  String nim = ""; // Menyimpan NIM (Nomor Induk Mahasiswa) atau ID pengguna.
  String password = ""; // Menyimpan kata sandi pengguna.
  bool isCommittee =
      false; // Menyimpan status apakah pengguna adalah bagian dari komite.

  // Fungsi untuk menangani proses login
  void login(bool value) async {
    isLoading =
        true; // Mengatur status loading menjadi true ketika proses login dimulai.
    update(); // Memperbarui UI untuk menyesuaikan status loading yang berubah.
    try {
      final data = await _repository.login(
          nim: nim,
          password: password,
          isCommittee:
              value); // Melakukan panggilan API untuk login dengan NIM dan password.
      if (data.id != null) {
        // Jika login berhasil (ID pengguna tidak null), lanjutkan dengan menyimpan data profil.
        await setCurrentProfile(
            data: data); // Menyimpan profil pengguna di SharedPreferences.
        isCommittee = data
            .isCommittee; // Menyimpan status komite (jika ada) dari data yang diterima.
      }
    } catch (e) {
      // Jika terjadi kesalahan, tampilkan Snackbar dengan pesan error.
      Get.showSnackbar(GetSnackBar(
        title: 'error',
        message: e.toString(),
        duration: const Duration(milliseconds: 1500),
      ));
      if (kDebugMode) {
        print(e); // Cetak error ke konsol jika dalam mode debug.
      }
    } finally {
      isLoading =
          false; // Mengatur status loading menjadi false setelah proses login selesai.
      update(); // Memperbarui UI untuk refleksi status loading yang berubah.
    }
  }

  // Fungsi untuk menyimpan data profil pengguna saat ini di SharedPreferences
  Future<void> setCurrentProfile({required ProfileModel data}) async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Mendapatkan instance SharedPreferences.
    final result = await prefs.setString('profile',
        json.encode(data.toJson())); // Menyimpan data profil dalam format JSON.

    if (result) {
      // Jika penyimpanan berhasil, arahkan pengguna ke halaman BottomNavScreen.
      Get.offAll(() => const BottomNavScreen());
    } else {
      // Jika penyimpanan gagal, tampilkan Snackbar dengan pesan error.
      Get.showSnackbar(const GetSnackBar(
        title: 'error',
        message: 'error saving profile data',
        duration: Duration(milliseconds: 1500),
      ));
    }
  }

  // Fungsi untuk menangani proses registrasi pengguna
  void register() async {
    isLoading =
        true; // Mengatur status loading menjadi true saat registrasi dimulai.
    update(); // Memperbarui UI untuk menyesuaikan status loading yang berubah.
    try {
      final data = await _repository.registerVoter(
          nim: nim,
          password:
              password); // Melakukan panggilan API untuk registrasi pengguna.
      Get.to(() => OTPScreen(
            email: data,
          ));
    } catch (e) {
      // Jika terjadi kesalahan, tampilkan Snackbar dengan pesan error.
      Get.showSnackbar(GetSnackBar(
        title: 'error',
        message: e.toString(),
        duration: const Duration(milliseconds: 1500),
      ));
      if (kDebugMode) {
        print(e); // Cetak error ke konsol jika dalam mode debug.
      }
    } finally {
      isLoading =
          false; // Mengatur status loading menjadi false setelah proses registrasi selesai.
      update(); // Memperbarui UI untuk refleksi status loading yang berubah.
    }
  }

  // Fungsi untuk menangani proses logout dan membersihkan data pengguna
  void logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences
          .getInstance(); // Mendapatkan instance SharedPreferences.
      await prefs
          .clear(); // Menghapus seluruh data yang disimpan di SharedPreferences.
      isCommittee =
          false; // Mengatur status komite menjadi false setelah logout.
      Get.dialog(
        AlertDialog(
          title: const Text(
              'Success'), // Menampilkan dialog sukses setelah logout berhasil.
          content: const Text(
            'Logged out successfully',
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Get.back(), // Menutup dialog jika tombol OK ditekan.
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      // Jika logout gagal, tampilkan dialog dengan pesan gagal.
      Get.dialog(
        AlertDialog(
          title: const Text('Failed'),
          content: const Text(
            'Logged out failed',
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Get.back(), // Menutup dialog jika tombol OK ditekan.
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      update(); // Memperbarui UI setelah proses logout selesai.
      Get.offAll(() =>
          const LoginScreen()); // Arahkan pengguna ke halaman login setelah logout.
    }
  }
}
