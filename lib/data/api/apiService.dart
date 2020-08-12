import 'package:dio/dio.dart';
import 'package:sign_in_flutter/data/api_client/api_client.dart';
import 'package:sign_in_flutter/data/utils/config.dart';
import 'package:sign_in_flutter/utils/shared_preference/app_shared_preferences.dart';

class ApiService {
  static final ApiService _genericApiService = ApiService._internal();
  factory ApiService() {
    return _genericApiService;
  }
  ApiService._internal();
  var deviceId;

  // get method service call
  Future<Response> get({url, Map<String, dynamic> queryParameters}) async {
    deviceId = await AppSharedPreferences.getDeviceId();
    Dio _apiClient = await ApiClient().getApiClient();
    _apiClient.options.headers = getHeaders();

    if (queryParameters == null) {
      queryParameters = <String, dynamic>{};
    }
    // for url indicate next call
    queryParameters['t'] = DateTime.now().millisecondsSinceEpoch.toString();

    return _apiClient.get(url, queryParameters: queryParameters);
  }

  // post method service call
  Future<Response> post(
      {url, Map<String, dynamic> queryParameters, data}) async {
    deviceId = await AppSharedPreferences.getDeviceId();
    Dio _apiClient = await ApiClient().getApiClient();
    _apiClient.options.headers = getHeaders();

    return _apiClient.post(url, queryParameters: queryParameters, data: data);
  }

  // put method service call
  Future<Response> put(
      {url, Map<String, dynamic> queryParameters, data}) async {
    deviceId = await AppSharedPreferences.getDeviceId();
    Dio _apiClient = await ApiClient().getApiClient();
    _apiClient.options.headers = getHeaders();

    return _apiClient.put(url, queryParameters: queryParameters, data: data);
  }

  // put method service call
  Future<Response> delete(
      {url, Map<String, dynamic> queryParameters, data}) async {
    deviceId = await AppSharedPreferences.getDeviceId();
    Dio _apiClient = await ApiClient().getApiClient();
    _apiClient.options.headers = getHeaders();

    return _apiClient.delete(url, queryParameters: queryParameters, data: data);
  }

  // Add Headers
  Map<String, dynamic> getHeaders() {
    var header = Map<String, dynamic>();
    header[Config.CONTENT_TYPE_KEY] = Config.CONTENT_TYPE_JSON;
    if (deviceId != null) header[Config.DEVICE_ID_KEY] = deviceId;

    return header;
  }
}
