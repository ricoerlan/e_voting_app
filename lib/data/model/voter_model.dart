import 'dart:convert';

VoterModel voterModelFromJson(String str) =>
    VoterModel.fromJson(json.decode(str));

String voterModelToJson(VoterModel data) => json.encode(data.toJson());

class VoterModel {
  final int? id;
  final String? nim;
  final String? username;
  final String? name;
  final String? email;
  final String? faculty;
  final bool? isCommittee;

  VoterModel(
      {this.id,
      this.nim,
      this.username,
      this.name,
      this.email,
      this.faculty,
      this.isCommittee = false});

  VoterModel copyWith({
    int? id,
    String? nim,
    String? name,
    String? email,
    String? faculty,
    bool? isCommittee,
  }) =>
      VoterModel(
        id: id ?? this.id,
        nim: nim ?? this.nim,
        name: name ?? this.name,
        email: email ?? this.email,
        faculty: faculty ?? this.faculty,
        isCommittee: isCommittee ?? this.isCommittee,
      );

  factory VoterModel.fromJson(Map<String, dynamic> json) => VoterModel(
        id: json["id"],
        nim: json["nim"],
        name: json["name"],
        email: json["email"],
        faculty: json["faculty"],
        isCommittee: json["is_committee"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nim": nim,
        "name": name,
        "email": email,
        "faculty": faculty,
        "is_committee": isCommittee,
      };
}
