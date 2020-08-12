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
import 'package:sign_in_flutter/sign_in.dart';
import 'package:sign_in_flutter/utils/http.dart';
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
        FirebaseUser authdetails = await signInWithGoogle();
        print('siginsuccess' + authdetails.uid);
        var deviceid = await DeviceId.getID;
        print('siginsuccess' + deviceid);

        if (authdetails != null) {
          LoginModel loginModel=new LoginModel();
          loginModel=await  loginapicall(
              authdetails.displayName,
              authdetails.email,
              '',
              authdetails.photoUrl,
              'google',
              authdetails.uid,
              deviceid);
          print('siginsuccess'+loginModel.message);
          yield GoogleLoginSuccess(response: loginModel);
        } else {
          yield LoginFailure(message: 'Login Failure');
        }
      } catch (e) { // error handle
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
