part of 'start_job_bloc.dart';

@immutable
abstract class StartJobState {}

class StartJobInitial extends StartJobState {
  final bool readOnly;
  StartJobInitial({required this.readOnly});
}

class CopyingImage extends StartJobState {}

class CopyFinished extends StartJobState {
  final JobOrder? jobOrder;
  CopyFinished(this.jobOrder);
}

class ReloadCopyLayout extends StartJobState {}
