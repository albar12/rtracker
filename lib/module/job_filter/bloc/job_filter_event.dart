import 'package:flutter/material.dart';

@immutable
abstract class JobFilterEvent {}

class JobFilterStarted extends JobFilterEvent {}

class JobFilterVendorBaseOfficeSelected extends JobFilterEvent {
  final String vendorId;
  final String? baseOfficeId;

  JobFilterVendorBaseOfficeSelected(this.vendorId, this.baseOfficeId);
}
