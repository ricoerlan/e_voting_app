import 'package:e_voting/controller/auth_controller.dart';
import 'package:e_voting/view/auth/login/login_screen.dart';
import 'package:e_voting/view/bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authController = Get.put(AuthController());
  _SplashScreenState();

  void _checkIsLoggedIn() async {
    final isLoggedIn = await authController.checkIsLoggedIn();
    if (isLoggedIn) {
      Get.offAll(() => BottomNavScreen());
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIsLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/logo/logo_sadhar.png'),
      ),
    );
  }
}
