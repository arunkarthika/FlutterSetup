import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:device_id/device_id.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http2_client/http2_client.dart';
import 'package:sign_in_flutter/Model/LoginModel.dart';
import 'package:sign_in_flutter/bloc/bloc.dart';
import 'package:sign_in_flutter/data/models/response/onboarding/login_response.dart';
import 'package:sign_in_flutter/data/repositories/repositories.dart';
import 'package:sign_in_flutter/sign_in.dart';
import 'package:sign_in_flutter/utils/http.dart';
import '../bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository = LoginRepository();

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is DoLogin) {
      try {
        // api call
        await Future.delayed(Duration(milliseconds: 3000));
        if ('userNameEmpty || null'.isEmpty) {
          yield UserNameEmtpy();
        } else {
          yield LoginSuccess(response: '');
        }
      } catch (e) {
        // error handle
        yield LoginFailure(message: 'Login Failure');
      }
    } else if (event is GoogleLogin) {
      try {
        FirebaseUser authdetails = await signInWithGoogle();
        var deviceid = await DeviceId.getID;
        if (authdetails != null) {
          final firebaseMessaging = FirebaseMessaging();
          var gcmregistrationid = '';
          await firebaseMessaging.getToken().then((token) {
            gcmregistrationid = token.toString();
          });

          // api call
          LoginResponse loginResponse = await _loginRepository.login(
              authdetails.displayName,
              authdetails.email,
              '',
              authdetails.photoUrl,
              'google',
              authdetails.uid,
              deviceid,
              gcmregistrationid);
          print('siginsuccess' + loginResponse.message);
          yield GoogleLoginSuccess(response: loginResponse);
        } else {
          yield LoginFailure(message: 'Login Failure');
        }
      } catch (e) {
        // error handle
        yield LoginFailure(message: 'Login Failure');
      }
    } else if (event is FBLogin) {
      try {
        // api call
        final facebookLogin = FacebookLogin();
        final result = await facebookLogin.logIn(['email']);
        switch (result.status) {
          case FacebookLoginStatus.loggedIn:
            final token = result.accessToken.token;
            var http =
                Http2Client(maxOpenConnections: Platform.numberOfProcessors);
            final graphResponse = await http.get(
                'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
            final profile = jsonDecode(graphResponse.body);
            break;
          case FacebookLoginStatus.cancelledByUser:
            yield LoginFailure(message: 'cancelled');
            break;
          case FacebookLoginStatus.error:
            yield LoginFailure(message: result.errorMessage);
            break;
        }

        yield FBLoginSuccess();
      } catch (e) {
        print('exception' + e.toString());
        // error handle
        yield LoginFailure(message: 'Login Failure');
      }
    }
  }
}
