import 'package:e_voting/data/repository/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:e_voting/data/model/chain_model.dart';

class HomeController extends GetxController {
  final _repository =
      Repository(); // Membuat instance dari Repository yang digunakan untuk berinteraksi dengan API atau sumber data.
  List<ChainModel> transactions =
      []; // Menyimpan daftar transaksi yang didapat dari API atau blockchain.
  Map<String, int> candidateVoteCount =
      {}; // Menyimpan jumlah suara untuk setiap kandidat yang terhitung dari transaksi.
  bool isLoading =
      false; // Variabel untuk menandakan apakah data sedang dimuat (loading).

  // Fungsi untuk mengambil dan menginisialisasi data transaksi blockchain
  void initializeData() async {
    isLoading =
        true; // Mengatur status loading menjadi true saat data sedang diambil.
    update(); // Memperbarui UI untuk refleksi status loading yang berubah.
    try {
      final result = await _repository
          .getBlockChains(); // Memanggil API untuk mendapatkan data transaksi blockchain.
      transactions =
          result; // Menyimpan hasil transaksi ke dalam variabel transactions.
      updateVoteCounts(); // Memperbarui jumlah suara kandidat berdasarkan transaksi yang diterima.
    } catch (e) {
      // Jika terjadi kesalahan saat mengambil data, cetak error ke konsol jika dalam mode debug.
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading =
          false; // Mengubah status loading menjadi false setelah proses selesai.
      update(); // Memperbarui UI untuk refleksi status loading yang berubah.
    }
  }

  // Fungsi untuk menghitung jumlah suara untuk setiap kandidat berdasarkan transaksi
  void updateVoteCounts() {
    candidateVoteCount
        .clear(); // Menghapus data jumlah suara yang lama sebelum menghitung ulang.

    // Iterasi melalui setiap transaksi untuk menghitung suara kandidat
    for (var tx in transactions) {
      if (tx.status?.toUpperCase() == 'CONFIRMED') {
        // Hanya transaksi yang berstatus 'CONFIRMED' yang dihitung.
        for (var transaction in tx.transactions ?? []) {
          final candidate = transaction.candidate ??
              ''; // Mendapatkan nama kandidat dari transaksi.
          if (candidate.isNotEmpty) {
            // Jika nama kandidat tidak kosong, hitung suaranya.
            candidateVoteCount[candidate] =
                (candidateVoteCount[candidate] ?? 0) +
                    1; // Tambahkan 1 suara untuk kandidat ini.
          }
        }
      }
    }
    update(); // Memperbarui UI setelah jumlah suara dihitung.
  }
}
