abstract class TerimaBarangEvent {}

class TerimaBarangSendSnStock extends TerimaBarangEvent {
  final String serialNumber;

  TerimaBarangSendSnStock({
    required this.serialNumber,
  });
}

class TerimaBarangGetSnStock extends TerimaBarangEvent {}

class TerimaBarangSendNonSnStock extends TerimaBarangEvent {
  final String id;
  final String productId;
  final String quantity;

  TerimaBarangSendNonSnStock({
    required this.id,
    required this.productId,
    required this.quantity,
  });
}

class TerimaBarangGetNonSnStock extends TerimaBarangEvent {}
