import 'dart:convert';

// Fungsi untuk mengonversi string JSON menjadi objek VoterModel.
// Fungsi ini mengharapkan string yang berisi JSON dan mengonversinya menjadi Map,
// kemudian membuat objek VoterModel dengan data dari Map tersebut.
VoterModel voterModelFromJson(String str) =>
    VoterModel.fromJson(json.decode(str));

// Fungsi untuk mengonversi objek VoterModel menjadi string JSON.
// Fungsi ini mengonversi objek VoterModel menjadi Map, lalu mengubahnya menjadi JSON.
String voterModelToJson(VoterModel data) => json.encode(data.toJson());

// Kelas VoterModel untuk merepresentasikan data pemilih
class VoterModel {
  final int? id; // ID pemilih (nullable)
  final String? nim; // NIM (Nomor Induk Mahasiswa) pemilih (nullable)
  final String? username; // Username pemilih (nullable)
  final String? name; // Nama pemilih (nullable)
  final String? email; // Email pemilih (nullable)
  final String? faculty; // Fakultas pemilih (nullable)
  final bool?
      isCommittee; // Status apakah pemilih adalah anggota komite (nullable)

  // Konstruktor untuk membuat objek VoterModel dengan parameter opsional (nullable).
  // isCommittee memiliki nilai default false.
  VoterModel({
    this.id,
    this.nim,
    this.username,
    this.name,
    this.email,
    this.faculty,
    this.isCommittee = false, // Default value untuk isCommittee adalah false
  });

  // Metode copyWith untuk membuat salinan objek dengan perubahan properti tertentu.
  // Jika parameter tidak diberikan, nilai asli objek yang ada akan digunakan.
  VoterModel copyWith({
    int? id,
    String? nim,
    String? name,
    String? email,
    String? faculty,
    bool? isCommittee,
  }) =>
      VoterModel(
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

  // Factory constructor untuk membuat objek VoterModel dari Map JSON.
  // Fungsi ini mengonversi data JSON yang diterima dari API menjadi objek VoterModel.
  factory VoterModel.fromJson(Map<String, dynamic> json) => VoterModel(
        id: json["id"], // Mengambil nilai "id" dari JSON
        nim: json["nim"], // Mengambil nilai "nim" dari JSON
        name: json["name"], // Mengambil nilai "name" dari JSON
        email: json["email"], // Mengambil nilai "email" dari JSON
        faculty: json["faculty"], // Mengambil nilai "faculty" dari JSON
        isCommittee:
            json["is_committee"], // Mengambil nilai "is_committee" dari JSON
      );

  // Metode toJson untuk mengonversi objek VoterModel ke dalam Map JSON.
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
