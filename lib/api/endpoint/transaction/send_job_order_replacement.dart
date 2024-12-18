class SendJobOrderReplacement {
  final String? typeId;
  final String category;
  final String productId;
  final String name;
  final String oldSerialNumber;
  final String newSerialNumber;
  final int quantity;
  final String reason;

  SendJobOrderReplacement({
    this.typeId,
    required this.category,
    required this.productId,
    required this.name,
    required this.oldSerialNumber,
    required this.newSerialNumber,
    required this.quantity,
    required this.reason,
  });

  Map<String, dynamic> toJson() =>
      {"typeId": typeId, "category": category, "productId": productId, "name": name, "oldSerialNumber": oldSerialNumber, "newSerialNumber": newSerialNumber, "quantity": quantity, "reason": reason};
}
