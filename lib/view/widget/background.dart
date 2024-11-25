import 'package:flutter/material.dart';

// Background adalah widget stateless yang digunakan untuk membuat layout dengan gambar latar belakang di bagian atas dan bawah.
// Gambar latar belakang ini dapat disesuaikan melalui properti `topImage` dan `bottomImage`.
class Background extends StatelessWidget {
  // Properti child digunakan untuk menampilkan konten utama di atas latar belakang
  final Widget child;

  // Properti topImage dan bottomImage digunakan untuk menentukan gambar yang ditampilkan di bagian atas dan bawah layar
  // Secara default, topImage adalah "assets/images/main_top.png" dan bottomImage adalah "assets/images/login_bottom.png"
  final String topImage, bottomImage;

  // Konstruktor untuk widget Background, `child` wajib diisi, sedangkan `topImage` dan `bottomImage` bersifat opsional
  const Background({
    super.key,
    required this.child, // Widget anak yang akan ditempatkan di atas background
    this.topImage = "assets/images/main_top.png", // Gambar di bagian atas layar
    this.bottomImage =
        "assets/images/login_bottom.png", // Gambar di bagian bawah layar
  });

  @override
  Widget build(BuildContext context) {
    // Scaffold digunakan untuk membuat layout dasar, dengan pengaturan resizeToAvoidBottomInset = false
    // untuk mencegah tampilan widget terkadang bergeser saat keyboard muncul
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Agar tampilan tidak bergeser ketika keyboard muncul
      body: SizedBox(
        width: double.infinity, // Lebar widget memenuhi seluruh lebar layar
        height: MediaQuery.of(context)
            .size
            .height, // Tinggi widget sesuai dengan tinggi layar perangkat
        child: Stack(
          alignment: Alignment.center, // Menyusun widget anak di tengah
          children: <Widget>[
            // Menampilkan gambar latar belakang di bagian atas layar
            Positioned(
              top: 0, // Menempatkan gambar di bagian atas layar
              left: 0, // Menempatkan gambar di sisi kiri
              child: Image.asset(
                topImage, // Menggunakan gambar yang diberikan di properti topImage
                width: 120, // Menentukan lebar gambar
              ),
            ),
            // Gambar di bagian bawah layar bisa ditampilkan dengan menghapus komentar di bagian ini
            /*
            Positioned(
              bottom: 0, // Menempatkan gambar di bagian bawah layar
              right: 0, // Menempatkan gambar di sisi kanan
              child: Image.asset(bottomImage, width: 120), // Gambar latar belakang bagian bawah
            ),
            */
            // SafeArea digunakan untuk memastikan widget anak tidak tertutup oleh area yang terhalang (seperti status bar atau keyboard)
            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}
