part of 'start_job_bloc.dart';

@immutable
abstract class StartJobState {}

class StartJobInitial extends StartJobState {
  final bool readOnly;
  StartJobInitial({required this.readOnly});
}
