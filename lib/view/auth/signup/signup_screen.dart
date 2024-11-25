import 'package:e_voting/view/auth/signup/widget/sign_up_form.dart';
import 'package:e_voting/view/auth/signup/widget/sign_up_top_image.dart';
import 'package:e_voting/view/widget/background.dart';
import 'package:flutter/material.dart';

// SignUpScreen adalah widget stateless yang merupakan layar utama untuk pendaftaran pengguna.
// Menggunakan widget Background untuk memberikan latar belakang dan membuat tampilan lebih menarik.
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Membungkus tampilan dengan Background dan menggunakan SingleChildScrollView
    // untuk memungkinkan pengguna menggulir halaman jika diperlukan
    return const Background(
      child: SingleChildScrollView(
        // Konten utama adalah MobileSignupScreen
        child: MobileSignupScreen(),
      ),
    );
  }
}

// MobileSignupScreen adalah widget stateless yang menampilkan tampilan pendaftaran di layar mobile.
// Di sini kita menggunakan layout Column untuk menyusun elemen secara vertikal.
class MobileSignupScreen extends StatelessWidget {
  const MobileSignupScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment
          .center, // Menyusun elemen secara vertikal di tengah layar
      children: <Widget>[
        // Tampilan gambar pada bagian atas layar signup
        SignUpScreenTopImage(),
        Row(
          children: [
            Spacer(), // Menyediakan ruang kosong di kiri
            Expanded(
              flex:
                  8, // Menggunakan 8 bagian ruang dari 10 (mengisi lebih banyak ruang)
              child: SignUpForm(), // Form pendaftaran pengguna
            ),
            Spacer(), // Menyediakan ruang kosong di kanan
          ],
        ),
      ],
    );
  }
}
