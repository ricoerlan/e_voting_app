import 'package:e_voting/controller/auth_controller.dart';
import 'package:e_voting/core/constant.dart';
import 'package:e_voting/view/auth/login/login_screen.dart';
import 'package:e_voting/view/widget/already_have_an_account_check.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;

// SignUpForm adalah widget Stateful yang digunakan untuk menampilkan form pendaftaran pengguna.
// Stateful karena memerlukan pengelolaan status seperti validasi form dan pengisian input.
class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

// _SignUpFormState adalah kelas yang mengelola status dari SignUpForm.
// Di sini kita akan menangani logika form, validasi input, dan interaksi dengan controller.
class _SignUpFormState extends State<SignUpForm> {
  // Membuat instance dari AuthController menggunakan Get.find() untuk mengakses controller.
  final authController = Get.find<AuthController>();

  // Membuat TextEditingController untuk NIM dan password.
  final TextEditingController nimController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // GlobalKey digunakan untuk mengelola status dari Form widget, khususnya untuk validasi.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // Mengaitkan form dengan _formKey untuk validasi
      child: Column(
        children: [
          // Input untuk NIM
          TextFormField(
            controller:
                nimController, // Menghubungkan dengan controller nimController
            keyboardType: TextInputType.number, // Hanya menerima input angka
            textInputAction: TextInputAction
                .next, // Setelah mengetik, pindah ke field berikutnya
            cursorColor: kPrimaryColor, // Menentukan warna kursor
            validator: (value) {
              // Validasi untuk memastikan NIM tidak kosong
              if (value == null || value.isEmpty) {
                return 'NIM harus diisi'; // Pesan error jika kosong
              }
              return null; // Jika valid, tidak ada error
            },
            onChanged: (value) {
              // Menyimpan nilai yang dimasukkan dalam controller
              if (value.isEmpty) {
                return;
              }
              authController.nim = value; // Menyimpan NIM ke controller
            },
            decoration: const InputDecoration(
              hintText: "NIM", // Menampilkan placeholder di dalam input
              prefixIcon: Icon(Icons.person), // Ikon di sebelah kiri input
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller:
                  passwordController, // Menghubungkan dengan controller passwordController
              textInputAction: TextInputAction
                  .done, // Setelah mengetik, tombol selesai muncul
              obscureText: true, // Menyembunyikan karakter password
              cursorColor: kPrimaryColor, // Menentukan warna kursor
              validator: (value) {
                // Validasi untuk memastikan password tidak kosong
                if (value == null || value.isEmpty) {
                  return 'Password harus diisi'; // Pesan error jika kosong
                }
                return null; // Jika valid, tidak ada error
              },
              onChanged: (value) {
                // Menyimpan nilai yang dimasukkan dalam controller
                if (value.isEmpty) {
                  return;
                }
                authController.password =
                    value; // Menyimpan password ke controller
              },
              decoration: const InputDecoration(
                hintText: "Password", // Menampilkan placeholder di dalam input
                prefixIcon: Icon(Icons.lock), // Ikon di sebelah kiri input
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () async {
              // Validasi form ketika tombol "Sign Up" ditekan
              final validated = _formKey.currentState!.validate();
              if (!validated) {
                return; // Jika form tidak valid, tidak lanjut ke proses pendaftaran
              }
              authController
                  .register(); // Memanggil metode register di AuthController
            },
            child: Text("Sign Up".toUpperCase()), // Teks tombol Sign Up
          ),
          const SizedBox(height: defaultPadding),
          // AlreadyHaveAnAccountCheck menampilkan tautan untuk pindah ke halaman login
          AlreadyHaveAnAccountCheck(
            login:
                false, // Menentukan bahwa ini adalah layar SignUp, bukan login
            press: () {
              // Menavigasi ke halaman LoginScreen ketika tombol ditekan
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen(); // Halaman Login
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
