import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User{
  int id;
  String name;
  String username;
  String email;
  Map<String, dynamic> address;
  String phone;
  String website;
  Map<String, String> company;

  User(this.id, this.name, this.username, this.email, this.address, this.phone,
      this.website, this.company);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}