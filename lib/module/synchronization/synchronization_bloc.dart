import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:rtracker/api/endpoint/login/login_response.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/helper/preferences.dart';
import 'package:rtracker/module/synchronization/synchronization_event.dart';
import 'package:rtracker/module/synchronization/synchronization_state.dart';
import 'package:rtracker/service/background_service.dart';

class SynchronizationBloc
    extends Bloc<SynchronizationEvent, SynchronizationState> {
  SynchronizationBloc() : super(SynchronizationInitial()) {
    on<SynchronizationLoad>(load);
    on<SynchronizationUpdateMessage>(updateMessage);
    on<SynchronizationUpdateProgress>(updateProgress);
  }

  Map<String, bool> syncStatuses = {};

  FutureOr<void> load(
    SynchronizationLoad event,
    Emitter<SynchronizationState> emit,
  ) async {
    syncStatuses.clear();

    await BackgroundService.checkVersion(this);
    await BackgroundService.markAsReadInbox();

    String rawLoginResponse = Preferences.getInstance()
            .getString(SharedPreferenceKey.LOGIN_RESPONSE) ??
        '{}';

    LoginResponse loginResponse =
        LoginResponse.fromJson(jsonDecode(rawLoginResponse));

    emit(
      SynchronizationSuccess(
        loginResponse: loginResponse,
        syncStatuses: syncStatuses,
      ),
    );
  }

  FutureOr<void> updateMessage(
    SynchronizationUpdateMessage event,
    Emitter<SynchronizationState> emit,
  ) async {
    emit(
      SynchronizationMessageChanged(
        message: event.message,
      ),
    );
  }

  FutureOr<void> updateProgress(
    SynchronizationUpdateProgress event,
    Emitter<SynchronizationState> emit,
  ) async {
    syncStatuses.addAll(event.versionStatus);

    emit(
      SynchronizationProgressChanged(
        progress: event.progress,
        total: event.total,
      ),
    );
  }
}
