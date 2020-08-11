import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:device_id/device_id.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sign_in_flutter/bloc/bloc.dart';
import 'package:sign_in_flutter/utils/http.dart';

import '../../sign_in.dart';
import '../bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
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
        // api call
        print('siginsuccess');
//        await signInWithGoogle();
//        var deviceid=     await DeviceId.getID;

        await loginapicall('sjhinfotech','sjhinfotech@gmail.com','','','google','','deviceid');

        yield GoogleLoginSuccess('goo');
      } catch (e) {
        // error handle
        yield LoginFailure(message: 'Login Failure');
      }
    } else if (event is FBLogin) {
      try {
        // api call

        yield FBLoginSuccess();
        yield FBLoginSuccess();
      } catch (e) {
        // error handle
        yield LoginFailure(message: 'Login Failure');
      }
    }
  }

  void loginapicall(String name, String email, mobile, String profilePic,
      String domain, String uid,String deviceid) {

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
        if (d2['status'] == 0) {
          if (d2['message'] == 'New user') {
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
            } else if (listData == 'Admin_BlocKEd') {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => AdminBlock(),
              //     ),
              // ),
            }
          }
        } else {}
      });
    });
  }
}
