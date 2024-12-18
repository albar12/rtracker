import 'package:flutter/material.dart';
import 'package:rtracker/realm/schemas.dart';

@immutable
abstract class JobFormEvent {}

class JobFormStarted extends JobFormEvent {
  final String vendorId;
  final JobOrder jobOrder;

  JobFormStarted(this.vendorId, this.jobOrder);
}

class JobFormJobStatusSelected extends JobFormEvent {
  final String jobStatusId;
  final String vendorId;
  final String jobTypeId;

  JobFormJobStatusSelected({
    required this.jobStatusId,
    required this.vendorId,
    required this.jobTypeId,
  });
}

class JobFormSubmitted extends JobFormEvent {
  final JobOrder jobOrder;

  JobFormSubmitted({
    required this.jobOrder,
  });
}
