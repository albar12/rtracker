class SendJobOrderInputPeripheral {
  final String id;
  final String servicePoint;
  final String category;
  final String productName;
  final int quantity;

  SendJobOrderInputPeripheral({
    required this.id,
    required this.servicePoint,
    required this.category,
    required this.productName,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {"id": id, "servicePoint": servicePoint, "category": category, "productName": productName, "quantity": quantity};
}
