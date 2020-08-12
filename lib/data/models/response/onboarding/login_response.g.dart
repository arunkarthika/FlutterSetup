// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return LoginResponse()
    ..message = json['message'] as String
    ..userId = json['userId'] as String
    ..username = json['username'] as String
    ..activationCode = json['activationCode'] as String
    ..country = json['country'] as String
    ..profileName = json['profileName'] as String
    ..id = json['id'] as String
    ..isThisUserBlocked = json['isThisUserBlocked'] as String
    ..loginDomain = json['loginDomain'] as String
    ..referenceUserId = json['referenceUserId'] as String
    ..profilePic = json['profilePic'] as String
    ..profilePic1 = json['profilePic1'] as String
    ..profilePic2 = json['profilePic2'] as String
    ..level = json['level'] as String
    ..diamond = json['diamond'] as String
    ..overAllGold = json['overAllGold'] as String
    ..fans = json['fans'] as String
    ..friends = json['friends'] as String
    ..followers = json['followers'] as String;
}

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('message', instance.message);
  writeNotNull('userId', instance.userId);
  writeNotNull('username', instance.username);
  writeNotNull('activationCode', instance.activationCode);
  writeNotNull('country', instance.country);
  writeNotNull('profileName', instance.profileName);
  writeNotNull('id', instance.id);
  writeNotNull('isThisUserBlocked', instance.isThisUserBlocked);
  writeNotNull('loginDomain', instance.loginDomain);
  writeNotNull('referenceUserId', instance.referenceUserId);
  writeNotNull('profilePic', instance.profilePic);
  writeNotNull('profilePic1', instance.profilePic1);
  writeNotNull('profilePic2', instance.profilePic2);
  writeNotNull('level', instance.level);
  writeNotNull('diamond', instance.diamond);
  writeNotNull('overAllGold', instance.overAllGold);
  writeNotNull('fans', instance.fans);
  writeNotNull('friends', instance.friends);
  writeNotNull('followers', instance.followers);
  return val;
}
