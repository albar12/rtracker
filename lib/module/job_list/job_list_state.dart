import 'package:flutter/material.dart';
import 'package:rtracker/realm/schemas.dart';

@immutable
abstract class JobListState {}

class JobListInitial extends JobListState {}

class JobListLoaded extends JobListState {
  final List<JobOrder> jobOrders;

  JobListLoaded({
    required this.jobOrders,
  });
}

class LoadingSync extends JobListState {}

class FinishedSync extends JobListState {
  final List<String> data;
  FinishedSync(this.data);
}

class FailedSync extends JobListState {
  final String error;
  FailedSync(this.error);
}