import 'package:flutter/material.dart';

// Base URL untuk API yang digunakan dalam aplikasi
const baseUrl = 'http://192.168.1.10:8000';
// URL endpoint untuk login pengguna (voter)
const loginUrl =
    '$baseUrl/login_voter'; // Menggabungkan base URL dengan endpoint login untuk pemilih (voter)

// Warna utama yang digunakan dalam aplikasi
const kPrimaryColor = Color(0xFF6F35A5); // Warna utama aplikasi (ungu)
const kPrimaryLightColor =
    Color(0xFFF1E6FF); // Warna terang utama aplikasi (ungu muda)

// Padding default yang digunakan dalam aplikasi untuk memberi jarak antar elemen UI
const double defaultPadding = 16.0; // Padding standar 16.0 unit

// Kelas ApiEndPoints yang menyimpan semua URL endpoint API yang digunakan dalam aplikasi.
class ApiEndPoints {
  // Endpoint untuk mengambil daftar blockchain (mungkin untuk melihat riwayat transaksi atau data terkait voting)
  static const fetchChain = "/chain/";

  // Endpoint untuk mengambil daftar kandidat
  static const fetchCandidates = "/candidates/";

  // Endpoint untuk registrasi pemilih (voter)
  static const registerVoter = "/register_voter/";
  static const sendEmailVerification = "/send-email-verification/";
  static const verifyEmailOTP = "/verify-email-otp";

  // Endpoint untuk login pemilih (voter)
  static const loginVoter = "/login_voter/";

  // Endpoint untuk mencatatkan suara (casting vote)
  static const castVote = "/vote/";

  // Endpoint untuk login panitia (committee)
  static const loginCommittee = "/login_committee/";

  // Endpoint untuk registrasi kandidat
  static const registerCandidate = "/register_candidate/";

  //Endpoint untuk ganti password pemilih (voter)
  static const changePasswordVoter = "/change_password_voter/";

  //Endpoint untuk ganti password pemilih (voter)
  static const changePasswordCommittee = "/change_password_committee/";
}
