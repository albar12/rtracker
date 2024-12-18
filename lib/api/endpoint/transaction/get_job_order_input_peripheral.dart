class GetJobOrderInputPeripheral {
  final String id;
  final String servicePoint;
  final String category;
  final String productName;
  final int quantity;

  GetJobOrderInputPeripheral({
    required this.id,
    required this.servicePoint,
    required this.category,
    required this.productName,
    required this.quantity,
  });

  factory GetJobOrderInputPeripheral.fromJson(Map<String, dynamic> json) => GetJobOrderInputPeripheral(
        id: json["id"],
        servicePoint: json["servicePoint"],
        category: json["category"],
        productName: json["productName"],
        quantity: json["quantity"],
      );
}
