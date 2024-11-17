import 'package:e_voting/view/auth/login/widget/mobile_login_screen.dart';
import 'package:e_voting/view/widget/background.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  // Get role based on current page index
  String get selectedRole => currentIndex == 0 ? 'voter' : 'committee';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 120),
        child: MobileLoginScreen(
          pageController: _pageController,
          currentIndex: currentIndex,
        ),
      ),
    );
  }
}
