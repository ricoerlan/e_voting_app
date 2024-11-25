import 'package:e_voting/data/model/profile_model.dart';
import 'package:e_voting/data/repository/shared_pref_repository.dart';
import 'package:e_voting/view/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final _repository =
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
      final result = await _repository
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
}
