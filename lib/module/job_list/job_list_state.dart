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
