import 'dart:convert';

// Fungsi untuk mengonversi List<dynamic> (data JSON) menjadi List<CandidateModel>
// Menggunakan metode .map() untuk mengonversi setiap elemen dalam list menjadi objek CandidateModel.
List<CandidateModel> candidateModelFromJson(List<dynamic> data) =>
    List<CandidateModel>.from(data.map((x) => CandidateModel.fromJson(x)));

// Fungsi untuk mengonversi List<CandidateModel> menjadi string JSON.
// Menggunakan .map() untuk mengonversi setiap objek CandidateModel menjadi Map, kemudian mengubahnya menjadi JSON.
String candidateModelToJson(List<CandidateModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// Kelas CandidateModel untuk merepresentasikan data kandidat dengan beberapa atribut.
class CandidateModel {
  final String? name; // Nama kandidat (nullable)
  final int? id; // ID kandidat (nullable)
  final String? faculty; // Fakultas kandidat (nullable)
  final int? studentId; // ID mahasiswa kandidat (nullable)
  final String? nim; // Nomor Induk Mahasiswa kandidat (nullable)
  final String? photo; // Foto kandidat (nullable)

  // Konstruktor untuk membuat objek CandidateModel dengan parameter opsional (nullable).
  CandidateModel({
    this.name,
    this.id,
    this.faculty,
    this.studentId,
    this.nim,
    this.photo,
  });

  // Metode copyWith untuk membuat salinan objek dengan perubahan properti tertentu.
  CandidateModel copyWith({
    String? name,
    int? id,
    String? faculty,
    int? studentId,
    String? nim,
    String? photo,
  }) =>
      CandidateModel(
        name: name ??
            this.name, // Jika parameter name tidak diberikan, gunakan nilai yang ada.
        id: id ??
            this.id, // Jika parameter id tidak diberikan, gunakan nilai yang ada.
        faculty: faculty ??
            this.faculty, // Jika parameter faculty tidak diberikan, gunakan nilai yang ada.
        studentId: studentId ??
            this.studentId, // Jika parameter studentId tidak diberikan, gunakan nilai yang ada.
        nim: nim ??
            this.nim, // Jika parameter nim tidak diberikan, gunakan nilai yang ada.
        photo: photo ??
            this.photo, // Jika parameter photo tidak diberikan, gunakan nilai yang ada.
      );

  // Factory constructor untuk membuat objek CandidateModel dari Map JSON.
  // Map JSON ini biasanya diterima dari API atau sumber data lainnya.
  factory CandidateModel.fromJson(Map<String, dynamic> json) => CandidateModel(
        name: json["name"], // Mengambil nilai "name" dari JSON
        id: json["id"], // Mengambil nilai "id" dari JSON
        faculty: json["faculty"], // Mengambil nilai "faculty" dari JSON
        studentId: json["student_id"], // Mengambil nilai "student_id" dari JSON
        nim: json["nim"], // Mengambil nilai "nim" dari JSON
        photo: json["photo"], // Mengambil nilai "photo" dari JSON
      );

  // Metode toJson untuk mengonversi objek CandidateModel ke dalam Map JSON.
  // Map ini nantinya dapat digunakan untuk dikirim ke server atau disimpan dalam format JSON.
  Map<String, dynamic> toJson() => {
        "name": name, // Mengonversi nilai "name" ke Map
        "id": id, // Mengonversi nilai "id" ke Map
        "faculty": faculty, // Mengonversi nilai "faculty" ke Map
        "student_id": studentId, // Mengonversi nilai "student_id" ke Map
        "nim": nim, // Mengonversi nilai "nim" ke Map
        "photo": photo, // Mengonversi nilai "photo" ke Map
      };
}
