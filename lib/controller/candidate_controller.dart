import 'package:e_voting/data/model/candidate_model.dart';
import 'package:e_voting/data/repository/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CandidateController extends GetxController {
  final _repository =
      Repository(); // Membuat instance dari Repository yang digunakan untuk berinteraksi dengan API.
  List<CandidateModel> candidates =
      []; // Menyimpan daftar kandidat yang diambil dari API.
  CandidateModel?
      selectedCandidate; // Menyimpan kandidat yang dipilih (jika ada).
  String nim =
      ""; // Menyimpan NIM pengguna yang akan digunakan saat menambahkan kandidat baru.

  bool isLoading =
      false; // Menandakan status apakah data sedang dimuat (loading) atau tidak.

  // Override onInit() dari GetxController untuk menjalankan inisialisasi data saat controller ini pertama kali dipanggil.
  @override
  void onInit() {
    super.onInit();
    initializeData(); // Memanggil fungsi untuk menginisialisasi data (mengambil daftar kandidat).
  }

  // Fungsi untuk mengambil data kandidat dari API dan mengatur nilai 'candidates' dengan hasilnya.
  void initializeData() async {
    isLoading =
        true; // Mengatur status loading menjadi true saat data sedang diambil.
    update(); // Memperbarui UI untuk refleksi status loading.
    try {
      final result = await _repository
          .getCandidates(); // Memanggil API untuk mendapatkan daftar kandidat.
      candidates =
          result; // Menyimpan hasil daftar kandidat ke dalam variabel candidates.
    } catch (e) {
      // Jika terjadi error saat mengambil data, cetak error tersebut pada debug mode.
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading =
          false; // Mengubah status loading menjadi false setelah proses selesai.
      update(); // Memperbarui UI setelah data selesai diambil.
    }
  }

  // Fungsi untuk menambahkan kandidat baru dengan mengambil foto dari parameter 'image' dan mengirimnya ke API.
  void addCandidate(XFile? image) async {
    isLoading =
        true; // Mengatur status loading menjadi true saat menambahkan kandidat.
    update(); // Memperbarui UI untuk refleksi status loading.
    try {
      final result = await _repository.addCandidate(
          nim: nim,
          photo: image!.path); // Memanggil API untuk menambahkan kandidat.
      if (!result) {
        // Jika API gagal menambahkan kandidat, lempar exception dengan pesan error.
        throw 'Something is wrong, please try again';
      }
      // Jika berhasil, tampilkan dialog sukses.
      Get.dialog(
        AlertDialog(
          title: const Text('Add Candidate Success'),
          content: const Text(
            'You have successfully added new candidate.',
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Get.back(), // Menutup dialog ketika tombol OK ditekan.
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      // Jika ada error, tampilkan dialog error dengan pesan kesalahan yang diterima.
      Get.dialog(
        AlertDialog(
          title: const Text('Error'),
          content:
              Text(e.toString()), // Menampilkan pesan error dari exception.
          actions: [
            TextButton(
              onPressed: () =>
                  Get.back(), // Menutup dialog ketika tombol OK ditekan.
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      initializeData();
      // isLoading =
      //     false; // Mengatur status loading menjadi false setelah proses menambahkan kandidat selesai.
      // update(); // Memperbarui UI untuk refleksi status loading yang berubah.
    }
  }
}
