import 'dart:convert';

// Fungsi untuk mengonversi string JSON menjadi objek ProfileModel.
// Fungsi ini mengharapkan string yang berisi JSON dan mengonversinya menjadi Map,
// kemudian membuat objek ProfileModel dengan data dari Map tersebut.
ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

// Fungsi untuk mengonversi objek ProfileModel menjadi string JSON.
// Fungsi ini mengonversi objek ProfileModel menjadi Map, lalu mengubahnya menjadi JSON.
String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

// Kelas ProfileModel untuk merepresentasikan data profil pengguna
class ProfileModel {
  final int? id; // ID pengguna (nullable)
  final String? nim; // NIM (Nomor Induk Mahasiswa) pengguna (nullable)
  final String? name; // Nama pengguna (nullable)
  final String? email; // Email pengguna (nullable)
  final String? faculty; // Fakultas pengguna (nullable)
  final bool?
      isCommittee; // Status apakah pengguna adalah anggota komite (nullable)

  // Konstruktor untuk membuat objek ProfileModel dengan parameter opsional (nullable).
  ProfileModel({
    this.id,
    this.nim,
    this.name,
    this.email,
    this.faculty,
    this.isCommittee,
  });

  // Metode copyWith untuk membuat salinan objek dengan perubahan properti tertentu.
  // Jika parameter tidak diberikan, nilai asli objek yang ada akan digunakan.
  ProfileModel copyWith({
    int? id,
    String? nim,
    String? name,
    String? email,
    String? faculty,
    bool? isCommittee,
  }) =>
      ProfileModel(
        id: id ?? this.id, // Jika id tidak diberikan, gunakan nilai yang ada.
        nim: nim ??
            this.nim, // Jika nim tidak diberikan, gunakan nilai yang ada.
        name: name ??
            this.name, // Jika name tidak diberikan, gunakan nilai yang ada.
        email: email ??
            this.email, // Jika email tidak diberikan, gunakan nilai yang ada.
        faculty: faculty ??
            this.faculty, // Jika faculty tidak diberikan, gunakan nilai yang ada.
        isCommittee: isCommittee ??
            this.isCommittee, // Jika isCommittee tidak diberikan, gunakan nilai yang ada.
      );

  // Factory constructor untuk membuat objek ProfileModel dari Map JSON.
  // Fungsi ini mengonversi data JSON yang diterima dari API menjadi objek ProfileModel.
  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"], // Mengambil nilai "id" dari JSON
        nim: json["nim"], // Mengambil nilai "nim" dari JSON
        name: json["name"], // Mengambil nilai "name" dari JSON
        email: json["email"], // Mengambil nilai "email" dari JSON
        faculty: json["faculty"], // Mengambil nilai "faculty" dari JSON
        isCommittee:
            json["is_committee"], // Mengambil nilai "is_committee" dari JSON
      );

  // Metode toJson untuk mengonversi objek ProfileModel ke dalam Map JSON.
  // Map ini nantinya dapat diserialisasi menjadi string JSON untuk dikirim ke server atau disimpan.
  Map<String, dynamic> toJson() => {
        "id": id, // Mengonversi nilai "id" ke Map
        "nim": nim, // Mengonversi nilai "nim" ke Map
        "name": name, // Mengonversi nilai "name" ke Map
        "email": email, // Mengonversi nilai "email" ke Map
        "faculty": faculty, // Mengonversi nilai "faculty" ke Map
        "is_committee": isCommittee, // Mengonversi nilai "is_committee" ke Map
      };
}
