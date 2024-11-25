import 'package:e_voting/view/auth/login/widget/mobile_login_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final PageController _pageController =
      PageController(); // PageController untuk mengontrol perpindahan halaman.
  int currentIndex =
      1; // Menyimpan indeks halaman yang aktif, default adalah halaman committee.

  // Mengambil role berdasarkan indeks halaman yang sedang aktif.
  String get selectedRole => currentIndex == 0 ? 'voter' : 'committee';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Membuat body meluas di belakang AppBar.
      extendBody: true, // Membuat body meluas di seluruh layar.
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
            top:
                120), // Menambahkan padding atas agar tidak tertutup oleh AppBar.
        child: MobileLoginScreen(
          pageController: _pageController, // Memberikan kontrol untuk halaman.
          currentIndex: currentIndex, // Memberikan nilai indeks halaman aktif.
        ),
      ),
    );
  }
}
