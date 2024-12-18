import 'package:flutter/material.dart';
import 'package:rtracker/helper/job_order_filter.dart';

@immutable
abstract class JobListEvent {}

class JobListLoad extends JobListEvent {
  final bool finished;
  final JobOrderFilter jobOrderFilter;

  JobListLoad({
    required this.finished,
    required this.jobOrderFilter,
  });
}
