// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GithubUserModel {
  final String name;
  final String powerstats;
  final String heroImage;

  GithubUserModel(
      {required this.name,
      required this.powerstats,
      required this.heroImage});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'powerstats': powerstats,
      'heroImage': heroImage
    };
  }

  factory GithubUserModel.fromMap(Map<String, dynamic> map) {
    return GithubUserModel(
      name: map['name'] as String,
      powerstats: map['powerstats'] as String,
      heroImage: map['heroImage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GithubUserModel.fromJson(String source) => GithubUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Null get details => null;
}
