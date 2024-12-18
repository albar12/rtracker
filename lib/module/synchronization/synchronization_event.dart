abstract class SynchronizationEvent {}

class SynchronizationLoad extends SynchronizationEvent {}

class SynchronizationUpdateMessage extends SynchronizationEvent {
  final String message;

  SynchronizationUpdateMessage({
    required this.message,
  });
}

class SynchronizationUpdateProgress extends SynchronizationEvent {
  final int progress;
  final int total;
  final Map<String, bool> versionStatus;

  SynchronizationUpdateProgress({
    required this.progress,
    required this.total,
    required this.versionStatus,
  });
}
