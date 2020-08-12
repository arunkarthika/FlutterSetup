import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:async/async.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http1;
import 'package:http2_client/http2_client.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_flutter/data/utils/config.dart';

dynamic toast(text, color) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

Future<bool> check() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

dynamic saveShare(String key, dynamic value) async {
  final sharedPrefs = await SharedPreferences.getInstance();
  await sharedPrefs.setString(key, value.toString());
}

Future<String> getStringData(key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) ?? '';
}

Future makeGetRequest(String endPoint, String params, int woutauth) async {
  var http = Http2Client(maxOpenConnections: Platform.numberOfProcessors);
  if (await check()) {
    var username = await getStringData('bearer');
    var password = await getStringData('token');
    var basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var url = Config.domain + '$endPoint?$params';
    print('url');
    print(url);
    var response;
    if (woutauth == 0) {
      response = await http
          .get(Uri.encodeFull(url), headers: {'Authorization': basicAuth});
    } else {
      response = await http.get(Uri.encodeFull(url));
    }
    print('datafrom');
    log(response.body);
    if (response.statusCode == 401 && woutauth == 0) {
      var json = jsonEncode({'device': 'android'});
      final authEndpoint = 'system/auth';
      final urlData = Config.domain + '$authEndpoint';
      var session = await http.post(Uri.encodeFull(urlData),
          body: jsonDecode(json),
          headers: {'Authorization': 'Bearer $username'});
      if (session.statusCode == 406) {
        saveShare('bearer', '');
//        await Navigator.pushAndRemoveUntil(
//          context,
//          MaterialPageRoute(
//            builder: (context) => LoginPage(),
//          ),
//          (Route<dynamic> route) => false,
//        );
      } else {
        var data = jsonDecode(session.body);
        var token = data['body']['token'];
        saveShare('token', token);
        await makeGetRequest(endPoint, params, 0);
      }
    }
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 1 && jsonData['message'] != 'Session Expiry') {
      toast(jsonData['message'], Colors.red);
    }
    return response.body;
  } else {
    toast('No Internet Connection', Colors.red);
  }
}

Future makePostRequest(
    String endPoint, String params, int woutauth, context) async {
  var http = Http2Client(maxOpenConnections: Platform.numberOfProcessors);
  if (await check()) {
    var username = await getStringData('bearer');
    var password = await getStringData('token');
    var basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final url = Config.domain + '$endPoint';
    print('url');
    print(url);
    print('params');
    print(params);
    var response;
    if (woutauth == 0) {
      response = await http.post(Uri.encodeFull(url),
          body: jsonDecode(params), headers: {'Authorization': basicAuth});
    } else {
      response = await http.post(Uri.encodeFull(url), body: jsonDecode(params));
    }
    print('data');
    print(response.body);
    if (response.statusCode == 401 && woutauth == 0) {
      var json = jsonEncode({'device': 'android'});
      final authEndpoint = 'system/auth';
      final urlData = Config.domain + '$authEndpoint';
      var session = await http.post(Uri.encodeFull(urlData),
          body: jsonDecode(json),
          headers: {'Authorization': 'Bearer $username'});
      if (session.statusCode == 406) {
        saveShare('bearer', '');
//        await Navigator.pushAndRemoveUntil(
//          context,
//          MaterialPageRoute(
//            builder: (context) => LoginPage(),
//          ),
//          (Route<dynamic> route) => false,
//        );
      } else {
        var data = jsonDecode(session.body);
        var token = data['body']['token'];
        saveShare('token', token);
        await makePostRequest(endPoint, params, 0, context);
      }
    }
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 1 && jsonData['message'] != 'Session Expiry') {
      toast(jsonData['message'], Colors.red);
    }
    return response.body;
  } else {
    toast('No Internet Connection', Colors.red);
  }
}

Future uploadImage(File file, endPoint, params, woutauth, context) async {
  if (await check()) {
    var username = await getStringData('bearer');
    var password = await getStringData('token');
    var basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final url = Config.domain + '$endPoint';
    var headers = {'Authorization': basicAuth};
    var stream = http1.ByteStream(DelegatingStream(file.openRead()));
    var length = await file.length();
    final multipartRequest = http1.MultipartRequest('POST', Uri.parse(url));
    multipartRequest.headers.addAll(headers);
    multipartRequest.files.add(http1.MultipartFile(
        'profile_pic', stream, length,
        filename: basename(file.path)));
    var data = jsonDecode(params);
    for (var key in data.keys) {
      multipartRequest.fields[key] = data[key];
    }
    var response = await multipartRequest.send();
    var value = await response.stream.bytesToString();
    if (response.statusCode == 401 && woutauth == 0) {
      var json = jsonEncode({'device': 'android'});
      final authEndpoint = 'system/auth';
      final urlData = Config.domain + '$authEndpoint';
      var session = await http1.post(Uri.encodeFull(urlData),
          body: jsonDecode(json),
          headers: {'Authorization': 'Bearer $username'});
      if (session.statusCode == 406) {
        saveShare('bearer', '');
//        await Navigator.pushAndRemoveUntil(
//          context,
//          MaterialPageRoute(
//            builder: (context) => LoginPage(),
//          ),
//          (Route<dynamic> route) => false,
//        );
      } else {
        var data = jsonDecode(session.body);
        var token = data['body']['token'];
        saveShare('token', token);
        await uploadImage(file, endPoint, params, 0, context);
      }
    }
    var jsonData = jsonDecode(value);
    if (jsonData['status'] == 1 && jsonData['message'] != 'Session Expiry') {
      toast(jsonData['message'], Colors.red);
    }
    return value;
  } else {
    toast('No Internet Connection', Colors.red);
  }
}
