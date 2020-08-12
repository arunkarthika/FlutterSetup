import 'package:json_annotation/json_annotation.dart';
import 'package:sign_in_flutter/data/models/response/onboarding/login_response_body.dart';
part 'login_response.g.dart';

@JsonSerializable(includeIfNull: false)
class LoginResponse {
  String message;
  String status;
  LoginResponseBody body;

  LoginResponse();

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
