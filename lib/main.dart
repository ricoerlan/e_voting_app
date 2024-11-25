import 'package:e_voting/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  // aplikasi Flutter dimulai.
  runApp(
    // Menggunakan GetMaterialApp menggantikan MaterialApp untuk memanfaatkan fitur-fitur dari Library GetX.
    GetMaterialApp(
      // Konfigurasi tema untuk aplikasi secara keseluruhan.
      theme: ThemeData(
        // Warna utama yang digunakan di seluruh aplikasi (untuk AppBar, tombol, dll).
        primarySwatch: Colors.blue,

        // Kepadatan visual yang adaptif, memastikan aplikasi terlihat baik di berbagai platform (Android, iOS, dll).
        visualDensity: VisualDensity.adaptivePlatformDensity,

        // Gaya teks yang dikustomisasi untuk aplikasi.
        textTheme: const TextTheme(
          // Gaya untuk teks tubuh besar (digunakan untuk teks umum di aplikasi).
          bodyLarge: TextStyle(color: Colors.black),

          // Gaya untuk teks tubuh medium (lebih ringan).
          bodyMedium: TextStyle(color: Colors.black54),

          // Gaya untuk judul besar (biasanya digunakan untuk heading atau judul).
          titleLarge: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      // Layar pertama yang akan ditampilkan saat aplikasi dijalankan.
      home: const SplashScreen(),
    ),
  );
}
