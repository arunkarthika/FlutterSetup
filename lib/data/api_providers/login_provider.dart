import 'package:flutter/foundation.dart';
import 'package:sign_in_flutter/data/api/apiService.dart';
import 'package:sign_in_flutter/data/models/response/onboarding/login_response.dart';
import 'package:sign_in_flutter/data/utils/config.dart';

ApiService _apiService = ApiService();

class LoginProvider {
  Future<LoginResponse> login(
      String name,
      String email,
      mobile,
      String profilePic,
      String domain,
      String uid,
      String deviceid,
      String gcmregistrationid) {
    var params = '?login_domain=' +
        domain +
        '&email=' +
        email +
        '&mobile=' +
        mobile +
        '&profilePic=' +
        profilePic +
        '&device_id=' +
        deviceid +
        '&gcm_registration_id=' +
        gcmregistrationid +
        '&firebaseUID=' +
        uid;
    return _apiService.post(url: Config.SYSTEM_CHECK + params).then((onValue) {
      return LoginResponse.fromJson(onValue.data);
    });
  }
}
