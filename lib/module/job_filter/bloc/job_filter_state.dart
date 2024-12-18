import 'package:flutter/material.dart';
import 'package:rtracker/realm/schemas.dart';

@immutable
abstract class JobFilterState {}

class JobFilterInitial extends JobFilterState {}

class JobFilterLoading extends JobFilterState {}

class JobFilterError extends JobFilterState {
  final String errorMsg;

  JobFilterError(this.errorMsg);
}

class JobFilterLoaded extends JobFilterState {
  final List<Vendor> vendors;
  final List<BaseOffice> office;
  final List<DocumentStatus> status;

  JobFilterLoaded(this.vendors, this.office, this.status);
}

class JobFilterOthersLoaded extends JobFilterState {
  final List<ServicePoint> servicePoints;
  final List<JobType> jobType;

  JobFilterOthersLoaded(this.servicePoints, this.jobType);
}
