import 'package:e_voting/controller/profile_controller.dart';
import 'package:e_voting/view/auth/login/login_screen.dart';
import 'package:e_voting/view/bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// SplashScreen: Halaman pembuka yang akan ditampilkan sementara
// sebelum memeriksa status login pengguna.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Menginisialisasi ProfileController yang dikelola menggunakan GetX
  final profileController = Get.put(ProfileController());

  // Fungsi untuk memeriksa apakah pengguna sudah login atau belum
  void _checkIsLoggedIn() async {
    // Memanggil metode untuk memeriksa status login
    final isLoggedIn = await profileController.checkIsLoggedIn();

    // Berdasarkan status login, arahkan pengguna ke halaman yang sesuai
    if (isLoggedIn) {
      // Jika sudah login, arahkan ke halaman BottomNavScreen
      Get.offAll(() => const BottomNavScreen());
    } else {
      // Jika belum login, arahkan ke halaman LoginScreen
      Get.offAll(() => const LoginScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    // Memanggil metode untuk memeriksa status login saat halaman dimuat
    _checkIsLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menampilkan logo aplikasi di tengah layar
      body: Center(
        child: Image.asset('assets/logo/logo_sadhar.png'),
      ),
    );
  }
}
