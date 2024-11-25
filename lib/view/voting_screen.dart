import 'package:e_voting/controller/voting_controller.dart';
import 'package:e_voting/data/model/candidate_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// VotingScreen: Halaman untuk memilih kandidat yang akan diberikan suara.
class VotingScreen extends StatelessWidget {
  VotingScreen({super.key});

  // Inisialisasi VotingController menggunakan GetX
  final VotingController votingController = Get.put(VotingController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        // Memanggil fungsi untuk menginisialisasi data ulang saat refresh
        votingController.initializeData();
        return Future.value();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Voting',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select a candidate to vote for:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 20),
              // GetBuilder untuk manajemen status dan pembaruan UI menggunakan VotingController
              GetBuilder<VotingController>(
                init: VotingController(),
                initState: (controller) => votingController.initializeData(),
                builder: (controller) {
                  // Jika data masih dalam proses loading, tampilkan indikator loading
                  if (controller.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Setelah data siap, tampilkan kandidat untuk dipilih
                  return Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.candidates.length,
                            itemBuilder: (context, index) {
                              final candidate = controller.candidates[index];
                              return CandidateCard(
                                candidate: candidate,
                                isSelected:
                                    controller.selectedCandidate == candidate,
                                onTap: () {
                                  // Panggil fungsi untuk memilih kandidat
                                  controller.selectCandidate(candidate);
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Tombol untuk memberikan suara
                        _voteButton(),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk tombol memberikan suara
  Widget _voteButton() {
    return GestureDetector(
      onTap: () => votingController.castVote(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 2), // perubahan posisi bayangan
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.exit_to_app,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(width: 10),
            Text(
              'Cast Vote',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Card untuk menampilkan kandidat yang bisa dipilih
class CandidateCard extends StatelessWidget {
  final CandidateModel candidate;
  final bool isSelected;
  final VoidCallback onTap;

  const CandidateCard({
    super.key,
    required this.candidate,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Mengaktifkan pemilihan kandidat saat card diklik
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isSelected
                ? Colors.blueAccent
                : Colors
                    .transparent, // Menambahkan border jika kandidat dipilih
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                color: isSelected
                    ? Colors.blueAccent
                    : Colors.grey, // Ikon berubah sesuai status terpilih
                size: 30,
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    candidate.name ?? '',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.blueAccent : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    candidate.faculty ?? '',
                    style: TextStyle(
                        color:
                            Colors.grey[600]), // Menampilkan fakultas kandidat
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
