import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  final int? id;
  final String? nim;
  final String? name;
  final String? email;
  final String? faculty;
  final bool? isCommittee;

  ProfileModel({
    this.id,
    this.nim,
    this.name,
    this.email,
    this.faculty,
    this.isCommittee,
  });

  ProfileModel copyWith({
    int? id,
    String? nim,
    String? name,
    String? email,
    String? faculty,
    bool? isCommittee,
  }) =>
      ProfileModel(
        id: id ?? this.id,
        nim: nim ?? this.nim,
        name: name ?? this.name,
        email: email ?? this.email,
        faculty: faculty ?? this.faculty,
        isCommittee: isCommittee ?? this.isCommittee,
      );

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
