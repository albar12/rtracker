part of 'required_job_bloc.dart';

@immutable
abstract class RequiredJobState {}

class RequiredJobInitial extends RequiredJobState {}

class RequiredJobLoading extends RequiredJobState {}

class RequiredJobLoaded extends RequiredJobState {
  final Map<String, List<JobOrder>> data;
  RequiredJobLoaded({required this.data});
}
