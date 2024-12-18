abstract class StokBarangEvent {}

class StokBarangGetSn extends StokBarangEvent {}

class StokBarangReturSn extends StokBarangEvent {
  final String id;
  final String condition;
  final String serialNumber;
  final String note;

  StokBarangReturSn({
    required this.id,
    required this.condition,
    required this.serialNumber,
    required this.note,
  });
}

class StokBarangGetNonSn extends StokBarangEvent {}

class StokBarangReturNonSn extends StokBarangEvent {
  final String id;
  final String condition;
  final String productId;
  final String quantity;
  final String note;

  StokBarangReturNonSn({
    required this.id,
    required this.condition,
    required this.productId,
    required this.quantity,
    required this.note,
  });
}
