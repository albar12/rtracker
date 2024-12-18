import 'package:rtracker/api/endpoint/login/login_response.dart';

abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {
  final LoginResponse loginResponse;

  SignInSuccess({
    required this.loginResponse,
  });
}

class SignInFailed extends SignInState {
  final String message;

  SignInFailed({
    required this.message,
  });
}

class SignInFinished extends SignInState {}
