import 'dart:convert';
import 'package:one_app_delivery/src/models/rol.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? id;
  String? name;
  String? lastname;
  String? email;
  String? phone;
  String? image;
  String? password;
  String? sessionToken;
  List<Rol>? roles = [];

  User({
    this.id,
    this.name,
    this.lastname,
    this.email,
    this.phone,
    this.image,
    this.password,
    this.sessionToken,
    this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] is int ? json["id"].toString() : json['id'],
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        sessionToken: json["sessionToken"],
        image: json["image"],
        roles: json["roles"] == null
            ? []
            : List<Rol>.from(json['roles'].map((model) => Rol.fromJson(model))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "image": image,
        "password": password,
        "sessionToken": sessionToken,
        "roles": roles,
      };
}
