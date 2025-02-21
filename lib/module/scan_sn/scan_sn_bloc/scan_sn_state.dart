part of 'scan_sn_bloc.dart';

@immutable
abstract class ScanSnState {}

class ScanSnInitial extends ScanSnState {}

class ScanSelected extends ScanSnState {
  final ScanType scanType;
  ScanSelected(this.scanType);
}

class BarcodeCaptured extends ScanSnState {
  final Barcode barcode;
  final BarcodeCapture barcodeCapture;

  BarcodeCaptured(this.barcode, this.barcodeCapture);
}
