// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.status,
    this.message,
    this.body,
  });

  int status;
  String message;
  Body body;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    message: json["message"],
    body: Body.fromJson(json["body"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "body": body.toJson(),
  };
}

class Body {
  Body({
    this.message,
    this.userId,
    this.username,
    this.activationCode,
    this.country,
    this.profileName,
    this.id,
    this.isThisUserBlocked,
    this.loginDomain,
    this.referenceUserId,
    this.profilePic,
    this.profilePic1,
    this.profilePic2,
    this.level,
    this.diamond,
    this.overAllGold,
    this.fans,
    this.friends,
    this.followers,
  });

  String message;
  String userId;
  String username;
  String activationCode;
  String country;
  String profileName;
  String id;
  String isThisUserBlocked;
  String loginDomain;
  String referenceUserId;
  String profilePic;
  String profilePic1;
  String profilePic2;
  String level;
  String diamond;
  String overAllGold;
  String fans;
  String friends;
  String followers;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    message: json["message"],
    userId: json["user_id"],
    username: json["username"],
    activationCode: json["activation_code"],
    country: json["country"],
    profileName: json["profileName"],
    id: json["id"],
    isThisUserBlocked: json["is_this_user_blocked"],
    loginDomain: json["login_domain"],
    referenceUserId: json["reference_user_id"],
    profilePic: json["profile_pic"],
    profilePic1: json["profile_pic1"],
    profilePic2: json["profile_pic2"],
    level: json["level"],
    diamond: json["diamond"],
    overAllGold: json["over_all_gold"],
    fans: json["fans"],
    friends: json["friends"],
    followers: json["followers"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user_id": userId,
    "username": username,
    "activation_code": activationCode,
    "country": country,
    "profileName": profileName,
    "id": id,
    "is_this_user_blocked": isThisUserBlocked,
    "login_domain": loginDomain,
    "reference_user_id": referenceUserId,
    "profile_pic": profilePic,
    "profile_pic1": profilePic1,
    "profile_pic2": profilePic2,
    "level": level,
    "diamond": diamond,
    "over_all_gold": overAllGold,
    "fans": fans,
    "friends": friends,
    "followers": followers,
  };
}
