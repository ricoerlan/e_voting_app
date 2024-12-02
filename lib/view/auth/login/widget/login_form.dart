import 'package:e_voting/controller/auth_controller.dart';
import 'package:e_voting/core/constant.dart';
import 'package:e_voting/view/auth/signup/signup_screen.dart';
import 'package:e_voting/view/widget/already_have_an_account_check.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;

// Kelas LoginForm adalah widget form login yang dinamis untuk role voter atau committee.
class LoginForm extends StatefulWidget {
  final String role; // Peran pengguna, bisa 'voter' atau 'committee'
  final int
      currentIndex; // Indeks halaman, menentukan apakah pengguna adalah voter atau committee

  // Konstruktor LoginForm yang menerima role dan currentIndex sebagai parameter.
  const LoginForm({super.key, required this.role, required this.currentIndex});

  @override
  State<LoginForm> createState() =>
      _LoginFormState(); // Membuat state untuk LoginForm
}

class _LoginFormState extends State<LoginForm> {
  // Mengambil instance AuthController menggunakan Get.find(), agar dapat mengakses fungsi login
  final authController = Get.put(AuthController());

  // Mengontrol input NIM atau Username
  final TextEditingController nimController = TextEditingController();

  // Mengontrol input password
  final TextEditingController passwordController = TextEditingController();

  // Global key untuk form, digunakan untuk validasi form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Menggunakan GetBuilder untuk merender UI berdasarkan status dari controller (misal: isLoading)
    return GetBuilder<AuthController>(
      builder: (controller) {
        // Jika authController isLoading true, tampilkan CircularProgressIndicator
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Jika tidak loading, tampilkan form login
        return Form(
          key: _formKey, // Menghubungkan form dengan global key untuk validasi
          child: Column(
            children: [
              // TextFormField untuk input NIM atau Username
              TextFormField(
                controller: nimController, // Controller untuk mengontrol input
                keyboardType: TextInputType
                    .number, // Input berupa angka (untuk NIM atau Username)
                textInputAction: TextInputAction
                    .next, // Aksi 'next' ketika menekan tombol di keyboard
                cursorColor: kPrimaryColor, // Warna kursor
                validator: (value) {
                  // Validator untuk memastikan NIM atau Username tidak kosong
                  if (value == null || value.isEmpty) {
                    return widget.currentIndex == 0
                        ? "Username harus diisi" // Pesan error jika role voter
                        : "NIM harus diisi"; // Pesan error jika role committee
                  }
                  return null; // Validasi berhasil jika tidak ada error
                },
                onChanged: (value) {
                  // Memperbarui nilai nim di authController jika ada perubahan
                  if (value.isEmpty) {
                    return;
                  }
                  authController.nim =
                      value; // Menyimpan NIM/Username pada controller
                },
                decoration: InputDecoration(
                  hintText: widget.currentIndex == 0
                      ? "Username"
                      : "NIM", // Menyesuaikan placeholder
                  prefixIcon: const Icon(Icons.person), // Ikon pada awal input
                ),
              ),

              // Padding untuk memberi jarak antar elemen
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: TextFormField(
                  controller: passwordController, // Controller untuk password
                  textInputAction: TextInputAction
                      .done, // Aksi 'done' ketika menekan tombol di keyboard
                  obscureText: true, // Menyembunyikan input password
                  cursorColor: kPrimaryColor, // Warna kursor
                  validator: (value) {
                    // Validasi untuk memastikan password tidak kosong
                    if (value == null || value.isEmpty) {
                      return "Password harus diisi"; // Pesan error jika kosong
                    }
                    return null; // Validasi berhasil
                  },
                  onChanged: (value) {
                    // Memperbarui nilai password pada controller jika ada perubahan
                    if (value.isEmpty) {
                      return;
                    }
                    authController.password =
                        value; // Menyimpan password pada controller
                  },
                  decoration: const InputDecoration(
                    hintText: "Password", // Placeholder untuk password
                    prefixIcon: Icon(Icons.lock), // Ikon kunci di awal input
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
                  authController.login(widget.currentIndex == 0);
                },
                child: Text("Login"
                    .toUpperCase()), // Menampilkan teks "Login" dalam huruf kapital
              ),

              // Memberikan jarak antara tombol login dan link ke halaman signup
              const SizedBox(height: defaultPadding),

              // Widget untuk menampilkan link menuju halaman signup jika pengguna belum punya akun
              AlreadyHaveAnAccountCheck(
                press: () {
                  // Jika ditekan, pindah ke halaman signup
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const SignUpScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
