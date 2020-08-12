import 'package:json_annotation/json_annotation.dart';
part 'login_response_body.g.dart';

@JsonSerializable(includeIfNull: false)
class LoginResponseBody {
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

  LoginResponseBody();

  factory LoginResponseBody.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseBodyToJson(this);
}
