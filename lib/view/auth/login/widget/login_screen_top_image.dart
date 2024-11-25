import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constant.dart';

// LoginScreenTopImage adalah widget Stateless yang menampilkan gambar di bagian atas layar login.
class LoginScreenTopImage extends StatelessWidget {
  // Konstruktor LoginScreenTopImage
  const LoginScreenTopImage({
    super.key, // key untuk widget
  });

  @override
  Widget build(BuildContext context) {
    // Membangun UI untuk LoginScreenTopImage
    return Column(
      children: [
        // Memberikan jarak vertikal di atas gambar (2x ukuran defaultPadding)
        const SizedBox(height: defaultPadding * 2),

        // Row digunakan untuk memposisikan gambar secara horizontal di tengah layar
        Row(
          children: [
            // Spacer di kiri untuk memberikan jarak antara gambar dan tepi kiri layar
            const Spacer(),

            // Expanded digunakan agar gambar mengambil 8 bagian dari total 10 unit ruang di layar
            Expanded(
              flex:
                  8, // Menggunakan flex 8, yang berarti gambar akan mengisi sebagian besar ruang
              child: SvgPicture.asset(
                  "assets/icons/login.svg"), // Memuat gambar SVG dari aset
            ),

            // Spacer di kanan untuk memberikan jarak antara gambar dan tepi kanan layar
            const Spacer(),
          ],
        ),

        // Memberikan jarak vertikal di bawah gambar (2x ukuran defaultPadding)
        const SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
