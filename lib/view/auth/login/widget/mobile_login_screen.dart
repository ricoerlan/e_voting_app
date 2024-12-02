import 'package:e_voting/view/auth/login/widget/login_form.dart';
import 'package:e_voting/view/auth/login/widget/login_screen_top_image.dart';
import 'package:flutter/material.dart';

// MobileLoginScreen adalah widget Stateful yang menampilkan tampilan login mobile dengan pilihan login sebagai Voter atau Committee.
class MobileLoginScreen extends StatefulWidget {
  final PageController
      pageController; // PageController untuk mengendalikan PageView
  final int currentIndex; // Indeks halaman saat ini (Voter atau Committee)

  const MobileLoginScreen({
    super.key,
    required this.pageController, // Diperlukan untuk mengendalikan PageView
    required this.currentIndex, // Indeks halaman yang sedang aktif
  });

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  late PageController pageController; // Variabel untuk controller halaman
  late int
      currentIndex; // Menyimpan status indeks halaman (0 untuk Voter, 1 untuk Committee)

  @override
  void initState() {
    super.initState();
    pageController =
        widget.pageController; // Mendapatkan controller dari widget parent
    currentIndex =
        widget.currentIndex; // Menyimpan currentIndex dari parent widget
  }

  @override
  Widget build(BuildContext context) {
    // Membuat tampilan layout untuk layar login
    return Column(
      mainAxisAlignment:
          MainAxisAlignment.center, // Menyusun elemen secara vertikal di tengah
      children: <Widget>[
        const LoginScreenTopImage(), // Gambar header pada layar login
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 20), // Padding untuk memberi ruang di sekitar indicator
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, // Menyusun indikator di tengah layar
                children: [
                  _buildPageIndicator(0), // Indikator untuk login sebagai Voter
                  _buildPageIndicator(
                      1), // Indikator untuk login sebagai Committee
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 500, // Menentukan tinggi container untuk PageView
          margin:
              const EdgeInsets.symmetric(horizontal: 20), // Margin horizontal
          child: PageView(
            controller:
                pageController, // Menghubungkan dengan PageController untuk kontrol halaman
            onPageChanged: (index) {
              setState(() {
                currentIndex =
                    index; // Memperbarui currentIndex saat halaman berubah
              });
            },
            children: [
              // Menampilkan form login sesuai dengan pilihan role
              LoginForm(role: 'voter', currentIndex: currentIndex),
              LoginForm(role: 'committee', currentIndex: currentIndex),
            ],
          ),
        ),
      ],
    );
  }

  // Fungsi untuk membangun indikator halaman (Voter/Committee) di bawah gambar
  Widget _buildPageIndicator(int index) {
    return GestureDetector(
      onTap: () {
        // Mengubah currentIndex saat indikator ditekan
        if (index == 1) {
          currentIndex = 0; // Jika indikator kedua (Committee), set ke Voter
          setState(() {});
        } else {
          currentIndex = 1; // Jika indikator pertama (Voter), set ke Committee
          setState(() {});
        }
      },
      child: AnimatedContainer(
        duration: const Duration(
            milliseconds: 300), // Durasi animasi perubahan tampilan
        curve: Curves.easeInOut, // Efek animasi saat transisi
        margin: const EdgeInsets.symmetric(
            horizontal: 10), // Memberi jarak antar indikator
        padding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 12), // Padding dalam indikator
        decoration: BoxDecoration(
          color: currentIndex == index
              ? Colors.grey.shade300
              : Colors.blueAccent, // Warna indikator aktif dan tidak aktif
          borderRadius: BorderRadius.circular(
              20), // Menambahkan border radius agar indikator melengkung
          boxShadow: [
            BoxShadow(
              color: currentIndex == index
                  ? Colors.transparent
                  : Colors.blue.withOpacity(
                      0.3), // Memberikan efek bayangan jika tidak aktif
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .center, // Menyusun elemen secara horizontal di tengah
          children: [
            // Ikon untuk Voter atau Committee
            Icon(
              index == 0 ? Icons.how_to_vote : Icons.group_add,
              color: currentIndex == index
                  ? Colors.grey
                  : Colors.white, // Warna ikon tergantung status aktif
              size: 18,
            ),
            const SizedBox(width: 8), // Spasi antara ikon dan teks
            // Teks untuk label Voter atau Committee
            Text(
              index == 0 ? 'Login as Voter' : 'Login as Committee',
              style: TextStyle(
                color: currentIndex == index
                    ? Colors.grey.shade600
                    : Colors.white, // Warna teks sesuai status aktif
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
