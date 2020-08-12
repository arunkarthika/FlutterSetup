// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) {
  return ErrorResponse(
    errorCode: json['errorCode'] as String,
    errorDesc: json['errorDesc'] as String,
    type: json['type'] as String,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$ErrorResponseToJson(ErrorResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('errorCode', instance.errorCode);
  writeNotNull('errorDesc', instance.errorDesc);
  writeNotNull('type', instance.type);
  writeNotNull('message', instance.message);
  return val;
}
