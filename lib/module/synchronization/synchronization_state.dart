import 'package:rtracker/api/endpoint/login/login_response.dart';

abstract class SynchronizationState {}

class SynchronizationInitial extends SynchronizationState {}

class SynchronizationMessageChanged extends SynchronizationState {
  final String message;

  SynchronizationMessageChanged({
    required this.message,
  });
}

class SynchronizationProgressChanged extends SynchronizationState {
  final int progress;
  final int total;

  SynchronizationProgressChanged({
    required this.progress,
    required this.total,
  });
}

class SynchronizationSuccess extends SynchronizationState {
  final LoginResponse loginResponse;
  final Map<String, bool> syncStatuses;

  SynchronizationSuccess({
    required this.loginResponse,
    required this.syncStatuses,
  });
}

class SynchronizationFailed extends SynchronizationState {
  final String message;

  SynchronizationFailed({
    required this.message,
  });
}
