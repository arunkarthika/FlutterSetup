import 'package:sign_in_flutter/data/api_providers/api_providers.dart';
import 'package:sign_in_flutter/data/models/response/onboarding/login_response.dart';

class LoginRepository {
  LoginProvider _loginProvider = LoginProvider();

  Future<LoginResponse> login(
      String name,
      String email,
      mobile,
      String profilePic,
      String domain,
      String uid,
      String deviceid,
      String gcmregistrationid) {
    return _loginProvider.login(name, email, mobile, profilePic, domain, uid,
        deviceid, gcmregistrationid);
  }

  Future<void> forgotPassword(String email) {
    return null;
  }

  Future<void> logout() {
    return null;
  }
}
