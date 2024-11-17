import 'package:e_voting/view/home_screen.dart';
import 'package:e_voting/view/voting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/bottom_navbar_controller.dart';
import 'profile_screen.dart';

class BottomNavScreen extends StatelessWidget {
  BottomNavScreen({super.key});

  // final BottomNavController _controller = Get.put(BottomNavController());
  // final AuthController _authController = Get.find<AuthController>();

  final List<Widget> _pages = [
    const HomeScreen(),
    VotingScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Welcome, ${_authController.currentUserNim.value}!'),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.logout),
      //       onPressed: () async {
      //         // Logout the user and go back to the login screen
      //         await _authController.logout();
      //         Get.offAll(() => LoginScreen());
      //       },
      //     ),
      //   ],
      // ),
      body: GetBuilder<BottomNavController>(
        init: BottomNavController(),
        builder: (controller) {
          return _pages[controller.selectedIndex];
        },
      ),
      bottomNavigationBar: GetBuilder<BottomNavController>(
        builder: (controller) {
          return BottomNavigationBar(
            currentIndex: controller.selectedIndex,
            onTap: controller.changeTabIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.how_to_vote_outlined),
                label: 'Voting',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}
