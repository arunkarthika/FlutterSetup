import 'package:json_annotation/json_annotation.dart';
part 'login_response.g.dart';

@JsonSerializable(includeIfNull: false)
class LoginResponse {
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

  LoginResponse();

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
