// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return LoginResponse()
    ..message = json['message'] as String
    ..status = json['status'] as int
    ..body = json['body'] == null
        ? null
        : LoginResponseBody.fromJson(json['body'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('message', instance.message);
  writeNotNull('status', instance.status);
  writeNotNull('body', instance.body);
  return val;
}
