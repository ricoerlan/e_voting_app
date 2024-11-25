import 'package:e_voting/core/constant.dart';
import 'package:flutter/material.dart';

// AlreadyHaveAnAccountCheck adalah widget stateless yang menampilkan teks yang memberi tahu pengguna
// apakah mereka sudah memiliki akun atau belum, dan memungkinkan pengguna untuk menavigasi ke halaman login
// atau halaman pendaftaran tergantung pada status saat ini.
class AlreadyHaveAnAccountCheck extends StatelessWidget {
  // Properti login menentukan apakah tampilan ini menunjukkan pesan "Don’t have an Account?"
  // atau "Already have an Account?". Jika login bernilai true, berarti menampilkan "Don't have an account?"
  final bool login;

  // Properti press adalah fungsi callback yang dipanggil ketika teks di-tap (biasanya untuk navigasi ke halaman lain)
  final Function? press;

  // Konstruktor untuk widget ini, dengan login default bernilai true dan press sebagai fungsi yang diperlukan
  const AlreadyHaveAnAccountCheck({
    super.key,
    this.login =
        true, // Default ke 'true', yang berarti menampilkan opsi untuk sign up jika login = true
    required this.press, // Fungsi press harus diberikan
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, // Menyusun teks secara horizontal di tengah
      children: <Widget>[
        // Teks pertama: jika login true, maka menampilkan pesan untuk pengguna yang belum punya akun.
        // Jika login false, menampilkan pesan untuk pengguna yang sudah punya akun.
        Text(
          login ? "Don’t have an Account ? " : "Already have an Account ? ",
          style: const TextStyle(
              color:
                  kPrimaryColor), // Teks berwarna sesuai dengan kPrimaryColor
        ),
        // GestureDetector digunakan untuk mendeteksi tap pada teks.
        GestureDetector(
          onTap: press as void
              Function()?, // Fungsi press dipanggil ketika teks di-tap
          child: Text(
            login
                ? "Sign Up"
                : "Sign In", // Menampilkan teks "Sign Up" jika login true, "Sign In" jika login false
            style: const TextStyle(
              color: kPrimaryColor, // Warna teks mengikuti kPrimaryColor
              fontWeight: FontWeight.bold, // Teks dicetak tebal
            ),
          ),
        )
      ],
    );
  }
}
