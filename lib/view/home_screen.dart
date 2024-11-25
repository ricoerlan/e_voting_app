import 'package:e_voting/controller/home_controller.dart';
import 'package:e_voting/data/model/chain_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

// HomeScreen adalah layar utama yang menampilkan informasi umum seperti transaksi terbaru dan vote count.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi controller yang akan menangani data dan logika pada layar ini
    final homeController = Get.put(HomeController());

    return RefreshIndicator(
      onRefresh: () {
        // Memanggil fungsi untuk memuat ulang data saat refresh
        homeController.initializeData();
        return Future.value();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menampilkan quick vote count section
              GetBuilder<HomeController>(
                init: homeController, // Pastikan controller diinisialisasi
                initState: (controller) => homeController
                    .initializeData(), // Inisialisasi data saat layar pertama kali dimuat
                builder: (controller) {
                  if (controller.isLoading) {
                    // Menampilkan loading indicator saat data sedang dimuat
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    // Menampilkan bagian quick count jika data telah dimuat
                    return _buildQuickCountSection(controller);
                  }
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GetBuilder<HomeController>(
                  builder: (controller) {
                    if (controller.isLoading) {
                      // Menampilkan loading indicator saat data sedang dimuat
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    // Menampilkan daftar transaksi dengan ListView
                    return ListView.builder(
                      itemCount: controller.transactions.length,
                      itemBuilder: (context, index) {
                        final tx = controller.transactions[index];
                        // Menampilkan setiap transaksi sebagai card dan memberikan interaksi tap untuk melihat detail
                        return GestureDetector(
                          onTap: () =>
                              _showTransactionDetailsDialog(context, tx),
                          child: TransactionCard(transaction: tx),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membangun bagian Quick Count
  Widget _buildQuickCountSection(HomeController homeController) {
    Set<String> candidateNames = {};

    // Mengumpulkan nama kandidat yang ada dari semua transaksi
    for (var tx in homeController.transactions) {
      if (tx.transactions != null) {
        for (var transaction in tx.transactions!) {
          final candidate = transaction.candidate ?? '';
          if (candidate.isNotEmpty) {
            candidateNames.add(candidate);
          }
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Vote Count:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        const SizedBox(height: 10),
        // Menampilkan jumlah vote untuk setiap kandidat
        ...candidateNames.map((candidate) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  candidate,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  '${homeController.candidateVoteCount[candidate] ?? 0} Votes',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  // Fungsi untuk menampilkan dialog detail transaksi
  void _showTransactionDetailsDialog(BuildContext context, ChainModel tx) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'Transaction Details',
            style: TextStyle(color: Colors.blueAccent),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Transaction Hash:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SelectableText(
                  tx.hash ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text('Block Number: ${tx.blockNumber}'),
                // Menampilkan status dan waktu transaksi
                const SizedBox(height: 10),
                Text('Status: ${tx.status}'),
                const SizedBox(height: 10),
                Text(
                  'Timestamp: ${_formatTimestamp(tx.timestamp!)}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          actions: [
            // Tombol OK untuk menutup dialog
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Format timestamp menjadi format yang lebih mudah dibaca
  String _formatTimestamp(DateTime timestamp) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp);
  }
}

// Widget untuk menampilkan informasi transaksi dalam bentuk card
class TransactionCard extends StatelessWidget {
  final ChainModel transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menampilkan Hash dari transaksi
            Text(
              'Transaction Hash',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            SelectableText(
              transaction.hash ?? '',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Menampilkan detail block number dan status transaksi
                _TransactionDetail(
                  label: 'Block Number',
                  value: '${transaction.blockNumber}',
                ),
                _TransactionDetail(
                  label: 'Status',
                  value: transaction.status ?? 'Unknown',
                  statusColor: transaction.status == 'Confirmed'
                      ? Colors.green
                      : Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Timestamp: ${_formatTimestamp(transaction.timestamp!)}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Format timestamp menjadi format yang lebih mudah dibaca
  String _formatTimestamp(DateTime timestamp) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp);
  }
}

// Widget untuk menampilkan detail transaksi seperti block number dan status
class _TransactionDetail extends StatelessWidget {
  final String label;
  final String value;
  final Color? statusColor;

  const _TransactionDetail({
    required this.label,
    required this.value,
    this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: statusColor ?? Colors.black,
          ),
        ),
      ],
    );
  }
}
