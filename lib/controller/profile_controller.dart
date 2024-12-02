import 'package:e_voting/data/model/profile_model.dart';
import 'package:e_voting/data/repository/repository.dart';
import 'package:e_voting/data/repository/shared_pref_repository.dart';
import 'package:e_voting/view/auth/login/login_screen.dart';
import 'package:e_voting/view/bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final _repository =
      Repository(); // Membuat instance dari Repository untuk melakukan panggilan API.
  final _sharedPrefRepository =
      SharedPrefRepository(); // Membuat instance dari SharedPrefRepository yang digunakan untuk mengambil data profil dari SharedPreferences.
  bool isLoading =
      false; // Menandakan apakah data profil sedang dimuat (loading) atau tidak.
  ProfileModel profileModel =
      ProfileModel(); // Menyimpan model profil yang akan diambil dan ditampilkan pada UI.

  // Fungsi untuk menginisialisasi data profil
  void initializeData() async {
    isLoading =
        true; // Mengatur status loading menjadi true saat data profil sedang diambil.
    update(); // Memperbarui UI agar menampilkan status loading.
    try {
      final result = await _sharedPrefRepository
          .getProfileData(); // Memanggil repository untuk mendapatkan data profil dari SharedPreferences.
      profileModel =
          result; // Menyimpan hasil data profil ke dalam variabel profileModel.
    } catch (e) {
      // Jika terjadi error saat mengambil data profil, tampilkan dialog error.
      Get.dialog(
        AlertDialog(
          title: const Text('Error'), // Menampilkan judul dialog "Error".
          content: Text(e.toString()), // Menampilkan pesan error yang terjadi.
          actions: [
            // Tombol OK untuk menutup dialog dan kembali ke LoginScreen.
            TextButton(
              onPressed: () => Get.offAll(() =>
                  const LoginScreen()), // Menutup dialog dan menavigasi ke LoginScreen.
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      isLoading =
          false; // Mengubah status loading menjadi false setelah proses selesai (baik berhasil atau gagal).
      update(); // Memperbarui UI untuk refleksi status loading yang berubah.
    }
  }

  // Fungsi untuk memeriksa apakah pengguna sudah login sebelumnya
  Future<bool> checkIsLoggedIn() async {
    if (!await _sharedPrefRepository.checkIsLoggedIn()) {
      // Memeriksa apakah data profil ada di SharedPreferences.
      return false; // Jika tidak ada data profil, kembalikan false, artinya pengguna belum login.
    }
    profileModel = await _sharedPrefRepository
        .getProfileData(); // Mengambil data profil pengguna dari SharedPreferences.
    return true; // Jika data profil ada, artinya pengguna sudah login, kembalikan true.
  }

  void changePasswordVoter({
    required String oldPassword,
    required String newPassword,
  }) async {
    isLoading =
        true; // Mengatur status loading menjadi true saat data profil sedang diambil.
    update(); // Memperbarui UI agar menampilkan status loading.
    try {
      final result = await _repository.changePassword(
          nim: profileModel.nim!,
          oldPassword: oldPassword,
          newPassword: newPassword,
          isCommittee: profileModel.isCommittee);
      if (!result) {
        throw 'Something is wrong, please try again'; // Jika API gagal, lempar exception.
      }
      Get.dialog(
        AlertDialog(
          title: const Text('Password Changed Successfully'),
          content: const Text(
            'You have successfully change password for this account', // Menampilkan nama kandidat yang dipilih.
          ),
          actions: [
            TextButton(
              onPressed: () => Get.offAll(() =>
                  const BottomNavScreen()), // Menutup dialog setelah tombol OK ditekan.
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      Get.dialog(
        AlertDialog(
          title: const Text(
              'Change Password Failed'), // Menampilkan judul dialog "Error".
          content: Text(e.toString()), // Menampilkan pesan error yang terjadi.
          actions: [
            // Tombol OK untuk menutup dialog dan kembali ke LoginScreen.
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      isLoading =
          false; // Mengubah status loading menjadi false setelah proses selesai (baik berhasil atau gagal).
      update(); // Memperbarui UI untuk refleksi status loading yang berubah.
    }
  }
}
