import 'package:flutter/material.dart';
import 'package:rtracker/api/endpoint/forgot_password/forgot_password_response.dart';

@immutable
abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final ForgotPasswordResponse forgotPasswordResponse;

  ForgotPasswordSuccess({
    required this.forgotPasswordResponse,
  });
}

class ForgotPasswordFailed extends ForgotPasswordState {
  final String message;

  ForgotPasswordFailed({
    required this.message,
  });
}

class ForgotPasswordFinished extends ForgotPasswordState {}
