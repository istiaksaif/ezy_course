// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final String? type;
  final String? token;
  final String? msg;

  LoginModel({
    this.type,
    this.token,
    this.msg,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    type: json["type"],
    token: json["token"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "token": token,
    "msg": msg,
  };
}
