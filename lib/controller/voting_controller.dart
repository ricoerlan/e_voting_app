import 'package:e_voting/controller/profile_controller.dart';
import 'package:e_voting/data/model/candidate_model.dart';
import 'package:e_voting/data/repository/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VotingController extends GetxController {
  final _repository =
      Repository(); // Membuat instance dari Repository untuk berinteraksi dengan API atau sumber data lainnya.
  List<CandidateModel> candidates =
      []; // Menyimpan daftar kandidat yang diambil dari API.
  CandidateModel?
      selectedCandidate; // Menyimpan kandidat yang dipilih oleh pengguna untuk memberikan suara.
  bool isLoading =
      false; // Menandakan status apakah aplikasi sedang memuat data atau sedang dalam proses pemilihan suara.

  // Fungsi yang dipanggil saat controller pertama kali diinisialisasi.
  @override
  void onInit() {
    super.onInit();
    initializeData(); // Memanggil fungsi untuk menginisialisasi data kandidat.
  }

  // Fungsi untuk mengambil data kandidat dari API dan menyimpannya ke dalam variabel candidates.
  void initializeData() async {
    isLoading =
        true; // Mengatur status loading menjadi true saat data sedang diambil.
    update(); // Memperbarui UI untuk menunjukkan status loading.
    try {
      final result = await _repository
          .getCandidates(); // Memanggil API untuk mendapatkan daftar kandidat.
      candidates =
          result; // Menyimpan hasil daftar kandidat ke dalam variabel candidates.
    } catch (e) {
      // Jika terjadi kesalahan saat mengambil data, cetak error ke konsol jika dalam mode debug.
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading =
          false; // Mengubah status loading menjadi false setelah proses selesai.
      update(); // Memperbarui UI setelah data selesai diambil.
    }
  }

  // Fungsi untuk memilih kandidat. Kandidat yang dipilih disimpan dalam selectedCandidate.
  void selectCandidate(CandidateModel candidate) {
    selectedCandidate = candidate; // Menyimpan kandidat yang dipilih.
    update(); // Memperbarui UI setelah kandidat dipilih.
  }

  // Fungsi untuk memberikan suara. Jika tidak ada kandidat yang dipilih, akan menampilkan dialog error.
  void castVote() async {
    if (selectedCandidate != null) {
      isLoading =
          true; // Mengubah status loading menjadi true saat memberikan suara.
      update(); // Memperbarui UI untuk menunjukkan status loading.
      try {
        // Memanggil API untuk memberikan suara dengan menggunakan NIM pemilih dan NIM kandidat.
        final result = await _repository.castVote(
            voterNim: Get.find<ProfileController>().profileModel.nim!,
            candidateNim: selectedCandidate!.nim!);
        if (!result) {
          throw 'Something is wrong, please try again'; // Jika API gagal, lempar exception.
        }
        // Jika suara berhasil, tampilkan dialog sukses.
        Get.dialog(
          AlertDialog(
            title: const Text('Vote Cast Successfully'),
            content: Text(
              'You have successfully voted for ${selectedCandidate!.name}.', // Menampilkan nama kandidat yang dipilih.
            ),
            actions: [
              TextButton(
                onPressed: () =>
                    Get.back(), // Menutup dialog setelah tombol OK ditekan.
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } catch (e) {
        // Jika terjadi kesalahan saat memberikan suara, tampilkan dialog error dengan pesan yang sesuai.
        Get.dialog(
          AlertDialog(
            title: const Text('Error'),
            content:
                Text(e.toString()), // Menampilkan pesan error yang diterima.
            actions: [
              TextButton(
                onPressed: () =>
                    Get.back(), // Menutup dialog setelah tombol OK ditekan.
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } finally {
        isLoading =
            false; // Mengubah status loading menjadi false setelah proses selesai.
        update(); // Memperbarui UI setelah status loading diubah.
      }
    } else {
      // Jika tidak ada kandidat yang dipilih, tampilkan dialog error.
      Get.dialog(
        AlertDialog(
          title: const Text('Error'),
          content: const Text(
              'Please select a candidate before voting.'), // Pesan untuk memilih kandidat terlebih dahulu.
          actions: [
            TextButton(
              onPressed: () =>
                  Get.back(), // Menutup dialog setelah tombol OK ditekan.
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
