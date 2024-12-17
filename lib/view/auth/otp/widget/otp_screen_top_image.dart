import 'package:e_voting/core/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// OTPScreenTopImage adalah widget stateless yang digunakan untuk menampilkan gambar
// dan judul "OTP Screen" di bagian atas halaman input OTP.
class OTPScreenTopImage extends StatelessWidget {
  const OTPScreenTopImage({
    super.key, // Konstruktor untuk OTPScreenTopImage
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Row ini digunakan untuk menampilkan gambar SVG di bagian atas layar
        Row(
          children: [
            const Spacer(), // Spacer untuk memberi jarak dari sisi kiri
            Expanded(
              flex:
                  8, // Memberikan lebar gambar SVG 8 bagian dari total 10 (di sisi kiri dan kanan)
              child: SvgPicture.asset(
                  "assets/icons/signup.svg"), // Menampilkan gambar SVG dari assets
            ),
            const Spacer(), // Spacer untuk memberi jarak dari sisi kanan
          ],
        ),
        const SizedBox(
            height: defaultPadding *
                2), // Memberikan ruang vertikal antara gambar dan teks
        Text(
          "OTP Screen"
              .toUpperCase(), // Menampilkan teks "OTP Screen" dalam huruf kapital
          style: const TextStyle(
            fontWeight:
                FontWeight.bold, // Menetapkan teks untuk memiliki font tebal
            fontSize: 20, // Menentukan ukuran font menjadi 20
          ),
        ),
        const SizedBox(
            height: defaultPadding), // Memberikan ruang vertikal di bawah teks
      ],
    );
  }
}
