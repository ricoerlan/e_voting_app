import 'dart:convert';

List<CandidateModel> candidateModelFromJson(List<dynamic> data) =>
    List<CandidateModel>.from(data.map((x) => CandidateModel.fromJson(x)));

String candidateModelToJson(List<CandidateModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CandidateModel {
  final String? name;
  final int? id;
  final String? faculty;
  final int? studentId;
  final String? nim;

  CandidateModel({
    this.name,
    this.id,
    this.faculty,
    this.studentId,
    this.nim,
  });

  CandidateModel copyWith({
    String? name,
    int? id,
    String? faculty,
    int? studentId,
    String? nim,
  }) =>
      CandidateModel(
        name: name ?? this.name,
        id: id ?? this.id,
        faculty: faculty ?? this.faculty,
        studentId: studentId ?? this.studentId,
        nim: nim ?? this.nim,
      );

  factory CandidateModel.fromJson(Map<String, dynamic> json) => CandidateModel(
        name: json["name"],
        id: json["id"],
        faculty: json["faculty"],
        studentId: json["student_id"],
        nim: json["nim"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "faculty": faculty,
        "student_id": studentId,
        "nim": nim,
      };
}
