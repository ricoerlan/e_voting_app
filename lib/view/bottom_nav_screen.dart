import 'package:e_voting/controller/auth_controller.dart';
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
    return GetBuilder<AuthController>(builder: (authController) {
      return Scaffold(
        body: GetBuilder<BottomNavController>(
          init: BottomNavController(),
          builder: (controller) {
            return [
              const HomeScreen(),
              authController.isCommittee ? CandidateScreen() : VotingScreen(),
              ProfileScreen(),
            ][controller.selectedIndex];
          },
        ),
        bottomNavigationBar: GetBuilder<BottomNavController>(
          builder: (controller) {
            print("authController.isCommittee ${authController.isCommittee}");
            return BottomNavigationBar(
              currentIndex: controller.selectedIndex,
              onTap: controller.changeTabIndex,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                authController.isCommittee
                    ? const BottomNavigationBarItem(
                        icon: Icon(Icons.groups_3_outlined),
                        label: 'Candidate',
                      )
                    : const BottomNavigationBarItem(
                        icon: Icon(Icons.how_to_vote_outlined),
                        label: 'Voting',
                      ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: 'Profile',
                ),
              ],
            );
          },
        ),
      );
    });
  }
}
