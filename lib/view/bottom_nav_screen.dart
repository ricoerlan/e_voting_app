import 'package:e_voting/controller/profile_controller.dart';
import 'package:e_voting/view/candidate_screen.dart';
import 'package:e_voting/view/home_screen.dart';
import 'package:e_voting/view/voting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/bottom_navbar_controller.dart';
import 'profile_screen.dart';

class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      // Menggunakan GetBuilder untuk mendengarkan perubahan pada ProfileController
      builder: (profileController) {
        return Scaffold(
          // Body menggunakan GetBuilder lagi untuk mendengarkan perubahan pada BottomNavController
          body: GetBuilder<BottomNavController>(
            init: BottomNavController(), // Inisialisasi BottomNavController
            builder: (controller) {
              // Berdasarkan nilai controller.selectedIndex, menampilkan screen yang sesuai
              return [
                const HomeScreen(), // Halaman Home
                profileController.profileModel.isCommittee
                    ? const CandidateScreen() // Jika pengguna adalah Committee, tampilkan CandidateScreen
                    : const VotingScreen(), // Jika bukan Committee, tampilkan VotingScreen
                ProfileScreen(), // Halaman Profile
              ][controller
                  .selectedIndex]; // Menampilkan layar sesuai dengan selectedIndex
            },
          ),
          // BottomNavigationBar untuk navigasi antara tab
          bottomNavigationBar: GetBuilder<BottomNavController>(
            builder: (controller) {
              return BottomNavigationBar(
                currentIndex: controller
                    .selectedIndex, // Menentukan index tab yang dipilih
                onTap: controller.changeTabIndex, // Fungsi untuk mengganti tab
                items: [
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined), // Ikon untuk tab Home
                    label: 'Home', // Label untuk tab Home
                  ),
                  profileController.profileModel.isCommittee
                      ? const BottomNavigationBarItem(
                          icon: Icon(Icons
                              .groups_3_outlined), // Ikon untuk tab Candidate (untuk Committee)
                          label: 'Candidate', // Label untuk tab Candidate
                        )
                      : const BottomNavigationBarItem(
                          icon: Icon(Icons
                              .how_to_vote_outlined), // Ikon untuk tab Voting (untuk Voter)
                          label: 'Voting', // Label untuk tab Voting
                        ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline), // Ikon untuk tab Profile
                    label: 'Profile', // Label untuk tab Profile
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
