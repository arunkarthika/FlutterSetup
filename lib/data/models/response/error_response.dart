import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

@JsonSerializable(includeIfNull: false)
class ErrorResponse {
  String errorCode;
  String errorDesc;
  String type;
  String message;
  ErrorResponse({this.errorCode, this.errorDesc, this.type, this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}
