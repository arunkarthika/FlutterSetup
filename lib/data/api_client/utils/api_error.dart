import 'package:dio/dio.dart';
import 'package:sign_in_flutter/data/models/response/error_response.dart';

class ApiError {
  static String handleError(DioError error) {
    String errorDescription = '';
    switch (error.type) {
      case DioErrorType.CANCEL:
        errorDescription = 'Request to API server was cancelled';
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        errorDescription = 'Experiencing Connection Difficulties...';
        break;
      case DioErrorType.DEFAULT:
        errorDescription = 'Check your internet connection';
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        errorDescription = 'Experiencing Connection Difficulties...';
        break;
      case DioErrorType.RESPONSE:
        ErrorResponse errorResponse;
        try {
          errorResponse = ErrorResponse.fromJson(error.response.data);
        } catch (catchError) {
          Map<String, dynamic> customizedErrorData = <String, dynamic>{
            'errorCode': error.response.statusCode.toString(),
            'errorDesc': error.response.statusMessage != null
                ? error.response.statusMessage
                : error.response.toString()
          };
          errorResponse = ErrorResponse.fromJson(customizedErrorData);
        }

        errorDescription = errorResponse.errorCode != null
            ? errorResponse.errorCode.length == 3
                ? errorResponse.errorCode + ' ' + errorResponse.errorDesc
                : errorResponse.errorCode
            : errorResponse.type != null
                ? errorResponse.type + ' ' + errorResponse.message
                : errorResponse.message;
        break;
      case DioErrorType.SEND_TIMEOUT:
        errorDescription = 'Send timeout in connection with API server';
        break;
    }
    return errorDescription;
  }
}
