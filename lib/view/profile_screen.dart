import 'package:e_voting/controller/auth_controller.dart';
import 'package:e_voting/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Layar ProfileScreen yang menampilkan data profil pengguna dan memungkinkan untuk melakukan logout.
class ProfileScreen extends StatelessWidget {
  // Menginisialisasi controller untuk mengelola state dan logika profil.
  final ProfileController profileController = Get.put(ProfileController());

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile', // Judul halaman Profile
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent, // Warna latar belakang app bar
      ),
      body: GetBuilder<ProfileController>(
        // Menggunakan GetBuilder untuk memantau perubahan state dari controller
        init: ProfileController(), // Inisialisasi controller jika belum ada
        initState: (controller) => profileController
            .initializeData(), // Memanggil fungsi untuk memulai pengambilan data profil
        builder: (controller) {
          // Jika data sedang dimuat, tampilkan loading indicator
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          // Jika data profil sudah siap, tampilkan UI profil pengguna
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Menampilkan nama pengguna
                const Text(
                  'Name:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  controller.profileModel.name ??
                      '', // Nama pengguna yang diambil dari model profil
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 20),

                // Menampilkan NIM jika pengguna bukan anggota komite
                if (!controller.profileModel.isCommittee!)
                  const Text(
                    'NIM:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                const SizedBox(height: 5),
                Text(
                  controller.profileModel.nim ?? '', // NIM pengguna
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 20),

                // Menampilkan email jika pengguna bukan anggota komite
                if (!controller.profileModel.isCommittee!)
                  const Text(
                    'Email:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                const SizedBox(height: 5),
                Text(
                  controller.profileModel.email ?? '', // Email pengguna
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 20),

                // Menampilkan fakultas jika pengguna bukan anggota komite
                if (!controller.profileModel.isCommittee!)
                  const Text(
                    'Faculty:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                const SizedBox(height: 5),
                Text(
                  controller.profileModel.faculty ?? '', // Fakultas pengguna
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                const Spacer(),
                // Tombol untuk logout
                _logoutButton(context),
              ],
            ),
          );
        },
      ),
    );
  }

  // Fungsi untuk mengonfirmasi dan melakukan logout
  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                // Jika pengguna mengonfirmasi logout, maka akan memanggil logout dari AuthController
                Get.back(); // Menutup dialog
                Get.find<AuthController>().logout(); // Logout dari aplikasi
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Get.back(); // Menutup dialog tanpa logout
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  // Widget untuk menampilkan tombol logout yang memiliki tampilan menarik
  Widget _logoutButton(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          _logout(context), // Mengaktifkan fungsi logout ketika tombol ditekan
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.redAccent, Colors.deepOrange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 2), // Posisi shadow pada tombol
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.exit_to_app, // Ikon logout
              color: Colors.white,
              size: 28,
            ),
            SizedBox(width: 10),
            Text(
              'Logout',
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
