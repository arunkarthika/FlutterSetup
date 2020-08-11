import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

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

class GoogleLoginSuccess extends LoginState{

  final String response;



     GoogleLoginSuccess({this.response});

}

class FBLoginSuccess extends LoginState{
  
}