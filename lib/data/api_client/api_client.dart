import 'package:dio/dio.dart';
import 'package:sign_in_flutter/data/repositories/repositories.dart';

import '../utils/config.dart';

class ApiClient {
  // next three lines makes this class a Singleton
  static ApiClient _instance = ApiClient.internal();
  ApiClient.internal();
  factory ApiClient() => _instance;

  Dio dio;
  Future<Dio> getApiClient() async {
    dio = Dio(_getBaseOptions());
    // interceptors
    dio.interceptors.clear();
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      // Do something before request is sent
      return options;
    }, onResponse: (Response response) {
      // Do something with response data
      return response; // continue
    }, onError: (DioError error) async {
      // Do something with response error
      if (error != null &&
          error.response != null &&
          error.response?.statusCode == Config.UN_AUTHORIZED) {
        // If expired token, request token firstly and lock this interceptor
        // to prevent other request enter this interceptor.
        dio.interceptors.requestLock.lock();

        RequestOptions options = error.response.request;

        final LoginRepository _loginRepository = LoginRepository();

        try {
          // dio.interceptors.requestLock.unlock();
          // return dio.request(options.path,
          //     queryParameters: options.queryParameters,
          //     data: options.data,
          //     options: options);

          if (options.path == Config.SYSTEM_CHECK) {
            dio.clear();
          } else {
            dio.interceptors.requestLock.unlock();
            return dio.request(options.path,
                queryParameters: options.queryParameters,
                data: options.data,
                options: options);
          }
        } catch (_error) {
          if (_error is DioError) {
            if (_error != null &&
                _error.response != null &&
                _error.response?.statusCode == Config.UN_AUTHORIZED) {}
            //String errorStr = ApiError.handleError(error);
          } else {
            //String errorStr = error.toString();
          }
        }
      }
      return error;
    }));
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    return dio;
  }

  BaseOptions _getBaseOptions() {
    return BaseOptions(
        baseUrl: Config.domain,
        connectTimeout: 20000,
        receiveTimeout: 20000,
        sendTimeout: 20000);
  }
}
