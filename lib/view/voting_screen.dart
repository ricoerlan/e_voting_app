import 'dart:ui';

import 'package:e_voting/controller/profile_controller.dart';
import 'package:e_voting/controller/voting_controller.dart';
import 'package:e_voting/core/constant.dart';
import 'package:e_voting/data/model/candidate_model.dart';
import 'package:e_voting/view/widget/image_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({super.key});

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

// VotingScreen: Halaman untuk memilih kandidat yang akan diberikan suara.
class _VotingScreenState extends State<VotingScreen> {
  // Inisialisasi VotingController menggunakan GetX
  final VotingController votingController = Get.put(VotingController());
  final ProfileController profileController = Get.find<ProfileController>();
  String? _previewImage;

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
        body: GetBuilder<ProfileController>(
          init: ProfileController(), // Inisialisasi controller jika belum ada
          initState: (controller) => Future.delayed(
              const Duration(seconds: 1),
              () => profileController
                  .initializeData()), // Memanggil fungsi untuk memulai pengambilan data profil
          builder: (controller) {
            return SafeArea(
              child: Stack(
                children: [
                  Padding(
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
                          initState: (controller) =>
                              votingController.initializeData(),
                          builder: (votingController) {
                            // Jika data masih dalam proses loading, tampilkan indikator loading
                            if (votingController.isLoading) {
                              return SizedBox(
                                height: MediaQuery.of(context).size.height / 2,
                                child: const Center(
                                    child: CircularProgressIndicator()),
                              );
                            }

                            // Setelah data siap, tampilkan kandidat untuk dipilih
                            return Expanded(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          votingController.candidates.length,
                                      itemBuilder: (context, index) {
                                        final candidate =
                                            votingController.candidates[index];
                                        return CandidateCard(
                                          candidate: candidate,
                                          isSelected: votingController
                                                  .selectedCandidate ==
                                              candidate,
                                          onTap: () {
                                            // Panggil fungsi untuk memilih kandidat
                                            votingController
                                                .selectCandidate(candidate);
                                          },
                                          onLongPressStart: (v) {
                                            if (candidate.photo != null &&
                                                candidate.photo != "") {
                                              _previewImage =
                                                  '$baseUrl/${candidate.photo!}';
                                              setState(() {});
                                            }
                                          },
                                          onLongPressEnd: (v) {
                                            _previewImage = null;
                                            setState(() {});
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
                  if (_previewImage != null) ...[
                    BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 2.0,
                        sigmaY: 2.0,
                      ),
                      child: Container(
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: ImagePreviewWidget(
                          imageUrl: _previewImage,
                        )),
                  ],
                ],
              ),
            );
          },
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
  final Function(LongPressStartDetails) onLongPressStart;
  final Function(LongPressEndDetails) onLongPressEnd;

  const CandidateCard({
    super.key,
    required this.candidate,
    required this.isSelected,
    required this.onTap,
    required this.onLongPressStart,
    required this.onLongPressEnd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Mengaktifkan pemilihan kandidat saat card diklik
      onLongPressStart: onLongPressStart,
      onLongPressEnd: onLongPressEnd,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: Colors.blueAccent,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Menampilkan informasi nama dan fakultas kandidat
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      candidate.name ?? '',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      candidate.faculty ?? '',
                      style: TextStyle(color: Colors.grey[600], fontSize: 22),
                    ),
                  ],
                ),
              ),
              // Menampilkan foto kandidat jika ada
              if (candidate.photo != null)
                Image.network(
                  '$baseUrl/${candidate.photo!}',
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.person_outline,
                    size: 60,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
