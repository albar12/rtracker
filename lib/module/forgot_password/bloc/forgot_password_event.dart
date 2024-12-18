import 'package:flutter/material.dart';

@immutable
abstract class ForgotPasswordEvent {}

class ForgotPasswordClicked extends ForgotPasswordEvent {
  final String username;

  ForgotPasswordClicked({
    required this.username,
  });
}
