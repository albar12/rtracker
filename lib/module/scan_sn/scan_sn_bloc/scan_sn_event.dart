part of 'scan_sn_bloc.dart';

@immutable
abstract class ScanSnEvent {}

class ChooseType extends ScanSnEvent {
  final ScanType scanType;
  ChooseType(this.scanType);
}

class DisplayBarcode extends ScanSnEvent {
  final Barcode barcode;
  final BarcodeCapture barcodeCapture;

  DisplayBarcode(this.barcode, this.barcodeCapture);
}
