import 'package:dio/dio.dart';
import 'package:e_voting/core/constant.dart';
import 'package:e_voting/data/api_service/api_service.dart';
import 'package:e_voting/data/model/candidate_model.dart';
import 'package:e_voting/data/model/chain_model.dart';
import 'package:e_voting/data/model/profile_model.dart';
import 'package:flutter/foundation.dart';

class Repository {
  final ApiService _apiService =
      ApiService(); // Membuat instance dari ApiService.

  // 1. Register Voter
  // Fungsi ini digunakan untuk mendaftarkan pemilih baru dengan mengirimkan NIM dan password.
  Future<ProfileModel> registerVoter(
      {required String nim, required String password}) async {
    try {
      final result = await _apiService.post(
        ApiEndPoints
            .registerVoter, // Menggunakan endpoint untuk mendaftarkan pemilih.
        data: FormData.fromMap(
          {"nim": nim, "password": password}, // Data yang dikirimkan ke server.
        ),
      );
      final data = result.data; // Mendapatkan respons dari server.
      if (data['status_code'] != 201) {
        throw data[
            "detail"]; // Jika status code bukan 201, anggap sebagai error.
      }
      return ProfileModel.fromJson(
          data['data']); // Mengembalikan data profil pemilih.
    } catch (e) {
      rethrow; // Mengulang error jika terjadi kesalahan.
    }
  }

  // 2. Login Voter & Committee
  // Fungsi untuk login, bisa sebagai pemilih atau komite tergantung parameter isCommittee.
  Future<ProfileModel> login(
      {required String nim,
      required String password,
      bool isCommittee = false}) async {
    try {
      final result = await _apiService.post(
        isCommittee
            ? ApiEndPoints.loginCommittee
            : ApiEndPoints.loginVoter, // Pilih endpoint sesuai role.
        data: FormData.fromMap(
          {
            isCommittee ? "username" : "nim": nim,
            "password": password
          }, // Menyesuaikan parameter untuk login.
        ),
      );
      final data = result.data; // Mendapatkan respons dari server.
      if (data['status_code'] != 200) {
        throw data[
            "detail"]; // Jika status code bukan 200, anggap sebagai error.
      }
      return ProfileModel.fromJson(data['data']); // Mengembalikan data profil.
    } catch (e) {
      rethrow; // Mengulang error jika terjadi kesalahan.
    }
  }

  // 3. Get Block Chains
  // Fungsi untuk mendapatkan data blockchain dari server.
  Future<List<ChainModel>> getBlockChains() async {
    List<ChainModel> chains = []; // Menyimpan data chains yang didapatkan.
    try {
      final response = await _apiService
          .get(ApiEndPoints.fetchChain); // Mengambil data blockchain dari API.
      final data = response.data; // Mendapatkan data respons dari server.
      if (data['status_code'] == 200) {
        chains.addAll(chainModelFromJson(
            data['data'])); // Menambahkan data chains ke list.
      }
    } catch (e) {
      if (kDebugMode) {
        print(e); // Menampilkan error di debug mode.
      }
      rethrow; // Mengulang error jika terjadi kesalahan.
    }
    return chains; // Mengembalikan data chains.
  }

  // 4. Get Candidates
  // Fungsi untuk mendapatkan daftar kandidat dari server.
  Future<List<CandidateModel>> getCandidates() async {
    List<CandidateModel> candidates = []; // Menyimpan daftar kandidat.
    try {
      final response = await _apiService.get(
          ApiEndPoints.fetchCandidates); // Mengambil data kandidat dari API.
      final data = response.data; // Mendapatkan respons dari server.
      if (data['status_code'] == 200) {
        candidates.addAll(candidateModelFromJson(
            data['data'])); // Menambahkan data kandidat ke list.
      }
    } catch (e) {
      if (kDebugMode) {
        print(e); // Menampilkan error di debug mode.
      }
      rethrow; // Mengulang error jika terjadi kesalahan.
    }
    return candidates; // Mengembalikan daftar kandidat.
  }

  // 5. Register Candidate
  // Fungsi untuk mendaftarkan kandidat baru (hanya untuk komite).
  Future<bool> addCandidate(
      {required String nim, required String photo}) async {
    try {
      final result = await _apiService.post(ApiEndPoints.registerCandidate,
          data: FormData.fromMap(
            {
              "nim": nim, // NIM kandidat.
              "photo": await MultipartFile.fromFile(photo,
                  filename:
                      '${DateTime.now().toIso8601String()}.${photo.split('.').last}')
            },
          ));
      final data = result.data; // Mendapatkan respons dari server.
      if (data["status_code"] != 201) {
        throw data[
            "detail"]; // Jika status code bukan 201, anggap sebagai error.
      }

      return true; // Mengembalikan nilai true jika pendaftaran berhasil.
    } catch (e) {
      rethrow; // Mengulang error jika terjadi kesalahan.
    }
  }

  // 6. Cast Vote
  // Fungsi untuk melakukan pemungutan suara oleh pemilih.
  Future<bool> castVote(
      {required String voterNim, required String candidateNim}) async {
    try {
      final result = await _apiService.post(ApiEndPoints.castVote,
          data: FormData.fromMap(
            {
              "voter_nim": voterNim,
              "candidate_nim": candidateNim
            }, // NIM pemilih dan kandidat.
          ));
      final data = result.data; // Mendapatkan respons dari server.
      if (data['status_code'] != 201) {
        throw data[
            "detail"]; // Jika status code bukan 201, anggap sebagai error.
      }
      return true; // Mengembalikan nilai true jika suara berhasil dikirim.
    } catch (e) {
      rethrow; // Mengulang error jika terjadi kesalahan.
    }
  }

  // 7. Change Password
  // Fungsi untuk melakukan pemungutan suara oleh pemilih.
  Future<bool> changePassword(
      {required String nim,
      required String oldPassword,
      required String newPassword,
      bool isCommittee = false}) async {
    try {
      final result = await _apiService.post(
        isCommittee
            ? ApiEndPoints.changePasswordCommittee
            : ApiEndPoints.changePasswordVoter, // Pilih endpoint sesuai role.
        data: FormData.fromMap(
          {
            "nim": nim,
            "old_password": oldPassword,
            "new_password": newPassword
          }, // Menyesuaikan parameter untuk login.
        ),
      );
      final data = result.data; // Mendapatkan respons dari server.
      if (data['status_code'] != 200) {
        throw data[
            "detail"]; // Jika status code bukan 200, anggap sebagai error.
      }
      return true;
    } catch (e) {
      rethrow; // Mengulang error jika terjadi kesalahan.
    }
  }
}
