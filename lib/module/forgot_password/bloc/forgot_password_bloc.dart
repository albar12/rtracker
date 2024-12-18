import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:rtracker/api/api_manager.dart';
import 'package:rtracker/api/endpoint/forgot_password/forgot_password_request.dart';
import 'package:rtracker/api/endpoint/forgot_password/forgot_password_response.dart';
import 'package:rtracker/helper/exceptions.dart';
import 'package:rtracker/module/forgot_password/bloc/forgot_password_event.dart';
import 'package:rtracker/module/forgot_password/bloc/forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotPasswordClicked>(forgotPasswordClicked);
  }

  FutureOr<void> forgotPasswordClicked(
    ForgotPasswordClicked event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(ForgotPasswordLoading());

    try {
      Response response = await ApiManager().forgotPassword(
        forgotPasswordRequest: ForgotPasswordRequest(
          username: event.username,
        ),
      );

      if (response.statusCode == 200) {
        ForgotPasswordResponse forgotPasswordResponse = ForgotPasswordResponse.fromJson(response.data);

        emit(
          ForgotPasswordSuccess(
            forgotPasswordResponse: forgotPasswordResponse,
          ),
        );
      } else {
        emit(
          ForgotPasswordFailed(
            message: "Ada sesuatu yang salah, mohon coba kembali beberapa saat kemudian.",
          ),
        );
      }
    } catch (e) {
      String message = "Ada sesuatu yang salah, mohon coba kembali beberapa saat kemudian.";

      if (e is GeneralException) {
        message = e.message;
      } else if (e is DioError) {
        message = e.response!.data;
      }

      emit(ForgotPasswordFailed(message: message));
    } finally {
      emit(ForgotPasswordFinished());
    }
  }
}
