part of 'start_job_bloc.dart';

@immutable
abstract class StartJobEvent {}

class ChangeStatus extends StartJobEvent {
  final bool readOnly;
  final String status;
  ChangeStatus({required this.readOnly, required this.status});
}
