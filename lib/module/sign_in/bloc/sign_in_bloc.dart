import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtracker/api/api_manager.dart';
import 'package:rtracker/api/endpoint/login/login_request.dart';
import 'package:rtracker/api/endpoint/login/login_response.dart';
import 'package:rtracker/helper/cloud_messagings.dart';
import 'package:rtracker/helper/exceptions.dart';
import 'package:rtracker/helper/generals.dart';
import 'package:rtracker/helper/locations.dart';
import 'package:rtracker/module/sign_in/bloc/sign_in_event.dart';
import 'package:rtracker/module/sign_in/bloc/sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInClicked>(signInClicked);
  }
  FutureOr<void> signInClicked(
    SignInClicked event,
    Emitter<SignInState> emit,
  ) async {
    emit(SignInLoading());
    try {
      // Mendapatkan Device ID
      String deviceId = await Generals.getDeviceId();

      // Mendapatkan posisi terakhir
      LongLat? longLat = await Locations.lastPosition();

      if (longLat == null) {
        throw GeneralException(
          message: "Gagal mendapatkan lokasi, silahkan coba kembali.",
        );
      }

      // Mendapatkan FCM Token
      String? fcmToken = await CloudMessagings.token();

      if (fcmToken == null) {
        throw GeneralException(
          message: "Gagal mendapatkan token notifikasi, silahkan coba kembali.",
        );
      }

      // Membuat LoginRequest untuk dikirim ke API
      LoginRequest loginRequest = LoginRequest(
        username: event.username,
        password: event.password,
        imei: deviceId,
        token: fcmToken,
        latitude: longLat.latitude.toString(),
        longitude: longLat.longitude.toString(),
      );

      // Mengirim permintaan login ke API
      Response response = await ApiManager().login(
        loginRequest: loginRequest,
      );

      if (response.statusCode == 200) {
        // Jika sukses, proses data login
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);

        // Menyimpan status login
        Generals.signIn(loginResponse: loginResponse);

        // Memulai background service
        final service = FlutterBackgroundService();
        service.startService();

        // Emit successR
        emit(SignInSuccess(loginResponse: loginResponse));
        emit(SignInFinished());
      } else {
        // Jika status code bukan 200
        emit(
          SignInFailed(
            message:
                "Ada sesuatu yang salah, mohon coba kembali beberapa saat kemudian.",
          ),
        );
      }
    } catch (e) {
      String message =
          "Ada sesuatu yang salah, mohon coba kembali beberapa saat kemudian.";

      // Menangani GeneralException
      if (e is GeneralException) {
        message = e.message;
      }
      // Menangani DioError
      else if (e is DioError) {
        // Cek apakah response ada dan data bisa diakses
        message = e.response?.data?.toString() ??
            "Terjadi kesalahan pada koneksi, coba lagi nanti.";
      }

      // Emit error message
      emit(SignInFailed(message: message));
    } finally {
      // Emit finished setelah selesai
      emit(SignInFinished());
    }
  }

  // FutureOr<void> signInClicked(
  //   SignInClicked event,
  //   Emitter<SignInState> emit,
  // ) async {
  //   emit(SignInLoading());
  //   try {
  //     String deviceId = await Generals.getDeviceId();

  //     LongLat? longLat = await Locations.lastPosition();

  //     if (longLat == null) {
  //       throw GeneralException(
  //         message: "Gagal mendapatkan lokasi, silahkan coba kembali.",
  //       );
  //     }

  //     String? fcmToken = await CloudMessagings.token();

  //     if (fcmToken == null) {
  //       throw GeneralException(
  //         message: "Gagal mendapatkan token notifikasi, silahkan coba kembali.",
  //       );
  //     }

  //     LoginRequest loginRequest = LoginRequest(
  //       username: event.username,
  //       password: event.password,
  //       imei: deviceId,
  //       token: fcmToken,
  //       latitude: longLat.latitude.toString(),
  //       longitude: longLat.longitude.toString(),
  //     );

  //     Response response = await ApiManager().login(
  //       loginRequest: loginRequest,
  //     );

  //     if (response.statusCode == 200) {
  //       LoginResponse loginResponse = LoginResponse.fromJson(response.data);

  //       Generals.signIn(loginResponse: loginResponse);

  //       final service = FlutterBackgroundService();

  //       service.startService();

  //       emit(SignInSuccess(loginResponse: loginResponse));
  //       emit(SignInFinished());
  //     } else {
  //       emit(
  //         SignInFailed(
  //           message:
  //               "Ada sesuatu yang salah, mohon coba kembali beberapa saat kemudian.",
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     String message =
  //         "Ada sesuatu yang salah, mohon coba kembali beberapa saat kemudian.";

  //     if (e is GeneralException) {
  //       message = e.message;
  //     } else if (e is DioError) {
  //       message = e.response?.data;
  //     }

  //     emit(SignInFailed(message: message));
  //   } finally {
  //     emit(SignInFinished());
  //   }
  // }
}
