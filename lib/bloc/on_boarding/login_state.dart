import 'package:equatable/equatable.dart';
import 'package:sign_in_flutter/data/models/response/onboarding/login_response.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final String response;
  LoginSuccess({this.response});
}

class UserNameEmtpy extends LoginState {
  UserNameEmtpy();
}

class LoginFailure extends LoginState {
  final String message;
  LoginFailure({this.message});
}

class GoogleLoginSuccess extends LoginState {
  final LoginResponse response;

  GoogleLoginSuccess({this.response});
}

class FBLoginSuccess extends LoginState {}
