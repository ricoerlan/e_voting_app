import 'package:e_voting/controller/profile_controller.dart';
import 'package:e_voting/core/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: const Text(
            'Change Password',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: GetBuilder<ProfileController>(
          builder: (controller) {
            // Jika authController isLoading true, tampilkan CircularProgressIndicator
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // Jika tidak loading, tampilkan form login
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key:
                    _formKey, // Menghubungkan form dengan global key untuk validasi
                child: Column(
                  children: [
                    // TextFormField untuk input password lama
                    TextFormField(
                      controller:
                          oldPasswordController, // Controller untuk mengontrol input
                      obscureText: true, // Menyembunyikan input password
                      textInputAction: TextInputAction
                          .next, // Aksi 'next' ketika menekan tombol di keyboard
                      cursorColor: kPrimaryColor, // Warna kursor
                      validator: (value) {
                        // Validator untuk memastikan password lama tidak kosong
                        if (value == null || value.isEmpty) {
                          return "Old Password cannot be empty"; // Pesan error
                        }
                        return null; // Validasi berhasil jika tidak ada error
                      },
                      decoration: const InputDecoration(
                        hintText: "Old Password", // Menyesuaikan placeholder
                        prefixIcon: Icon(Icons.lock), // Ikon pada awal input
                      ),
                    ),

                    // Padding untuk memberi jarak antar elemen
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: defaultPadding),
                      child: TextFormField(
                        controller:
                            newPasswordController, // Controller untuk password
                        textInputAction: TextInputAction
                            .done, // Aksi 'done' ketika menekan tombol di keyboard
                        obscureText: true, // Menyembunyikan input password
                        cursorColor: kPrimaryColor, // Warna kursor
                        validator: (value) {
                          // Validator untuk memastikan password lama tidak kosong
                          if (value == null || value.isEmpty) {
                            return "New Password cannot be empty"; // Pesan error
                          }
                          return null; // Validasi berhasil jika tidak ada error
                        },
                        decoration: const InputDecoration(
                          hintText: "New Password", // Menyesuaikan placeholder
                          prefixIcon: Icon(Icons.lock), // Ikon pada awal input
                        ),
                      ),
                    ),

                    // Memberikan jarak antara form dan tombol login
                    const SizedBox(height: defaultPadding),

                    // Tombol login
                    ElevatedButton(
                      onPressed: () async {
                        // Memvalidasi form sebelum login
                        final validated = _formKey.currentState!.validate();
                        if (!validated) {
                          return; // Tidak lanjut jika form tidak valid
                        }
                        // Menjalankan proses login menggunakan controller, berdasarkan role
                        controller.changePasswordVoter(
                            oldPassword: oldPasswordController.text,
                            newPassword: newPasswordController.text);
                      },
                      child: Text("Submit"
                          .toUpperCase()), // Menampilkan teks "Submit" dalam huruf kapital
                    ),

                    // Memberikan jarak antara tombol login dan link ke halaman signup
                    const SizedBox(height: defaultPadding),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
