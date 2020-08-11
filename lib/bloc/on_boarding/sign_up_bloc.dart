import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sign_in_flutter/bloc/bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }

  @override
  SignUpState get initialState => SignUpInitial();
}
