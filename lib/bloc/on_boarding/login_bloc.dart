import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_id/device_id.dart';
import 'package:firebase_auth_ui/firebase_auth_ui.dart';
import 'package:firebase_auth_ui/providers.dart';
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
      final firebaseMessaging = FirebaseMessaging();
      var gcmregistrationid = '';
      var deviceid = await DeviceId.getID;

      await firebaseMessaging.getToken().then((token) {
        gcmregistrationid = token.toString();
      });
      FirebaseUser firebaseUser= await FirebaseAuthUi.instance().launchAuth([
        AuthProvider.google(),
      ]);
      LoginResponse loginResponse = await _loginRepository.login(
          firebaseUser.displayName,
          firebaseUser.email,
          '',
          firebaseUser.photoUri,
          'google',
          firebaseUser.uid,
          deviceid,
          gcmregistrationid);
      print(loginResponse);

     yield GoogleLoginSuccess(response: loginResponse);
      print('firebaseUser' + firebaseUser.email);
    } else if (event is FBLogin) {
      try {
        // api call
        final firebaseMessaging = FirebaseMessaging();
        var gcmregistrationid = '';
        var deviceid = await DeviceId.getID;

        await firebaseMessaging.getToken().then((token) {
          gcmregistrationid = token.toString();
        });
        FirebaseUser firebaseUser= await FirebaseAuthUi.instance().launchAuth([
          AuthProvider.facebook(),
        ]);
        LoginResponse loginResponse = await _loginRepository.login(
            firebaseUser.displayName,
            firebaseUser.email,
            '',
            firebaseUser.photoUri,
            'Facebook',
            firebaseUser.uid + '@facebook.com',
            deviceid,
            gcmregistrationid);
        print(loginResponse);

        yield FBLoginSuccess();
      } catch (e) {
        print('exception' + e.toString());
        // error handle
        yield LoginFailure(message: 'Login Failure');
      }
    } else if (event is MobilenumberLogin) {
      try{
        final firebaseMessaging = FirebaseMessaging();
        var gcmregistrationid = '';
        var deviceid = await DeviceId.getID;

        await firebaseMessaging.getToken().then((token) {
          gcmregistrationid = token.toString();
        });
        FirebaseUser firebaseUser= await FirebaseAuthUi.instance().launchAuth([
          AuthProvider.phone(),
        ]);
        LoginResponse loginResponse = await _loginRepository.login(
            firebaseUser.displayName,
            firebaseUser.email,
            firebaseUser.phoneNumber,
            firebaseUser.photoUri,
            'mobile',
            firebaseUser.uid,
            deviceid,
            gcmregistrationid);
        print(loginResponse);

      }catch(e){

      }
    }else if (event is TwitterLogin) {
      try{
        final firebaseMessaging = FirebaseMessaging();
        var gcmregistrationid = '';
        var deviceid = await DeviceId.getID;

        await firebaseMessaging.getToken().then((token) {
          gcmregistrationid = token.toString();
        });
        FirebaseUser firebaseUser= await FirebaseAuthUi.instance().launchAuth([
          AuthProvider.twitter(),
        ]);
        LoginResponse loginResponse = await _loginRepository.login(
            firebaseUser.displayName,
            firebaseUser.email,
            '',
            firebaseUser.photoUri,
            'Twitter',
            firebaseUser.uid + '@twitter.com',
            deviceid,
            gcmregistrationid);
        print(loginResponse);

      }catch(e){

      }
    }
  }

  Future<LoginModel> loginapicall(String name, String email, mobile,
      String profilePic, String domain, String uid, String deviceid) async {
    print('apicall');
    final firebaseMessaging = FirebaseMessaging();
    firebaseMessaging.getToken().then((token) {
      var gcmregistrationid = token.toString();
      var endPoint = 'system/check';
      var params = 'login_domain=' +
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
      makeGetRequest(endPoint, params, 1).then((response) {
        var data = (response).trim();
        var d2 = jsonDecode(data);
        print(data);
        return LoginModel.fromJson(d2);
        if (d2['status'] == 0) {
          if (d2['message'] == 'New user') {
            String newuser = d2['body']['message'];
            return newuser;

//            callNewUser(name, profilePic, domain, email, mobile, uid);
          } else {
            var listData = d2['body']['message'];
            if (listData == 'Already exsits') {
              var body = d2['body'];
              var entryList = body.entries.toList();

              for (var j = 0; j < entryList.length; j++) {
                saveShare(entryList[j].key, entryList[j].value.toString());
              }
              saveShare('bearer', d2['body']['activation_code']);
//              callOldUser();
              String newuser = d2['body']['message'];
              return newuser;
            } else if (listData == 'Admin_BlocKEd') {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => AdminBlock(),
              //     ),
              // ),
            }
          }
        } else {
          return 'failed';
        }
      });
    });
  }
}
