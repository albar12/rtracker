class GetNonSnStockResponseDetail {
  final String id;
  final String servicePointId;
  final String servicePointName;
  final String category;
  final String productName;
  final int quantity;

  GetNonSnStockResponseDetail({
    required this.id,
    required this.servicePointId,
    required this.servicePointName,
    required this.category,
    required this.productName,
    required this.quantity,
  });

  factory GetNonSnStockResponseDetail.fromJson(Map<String, dynamic> json) => GetNonSnStockResponseDetail(
        id: json["id"].toString(),
        servicePointId: json["servicePointId"],
        servicePointName: json["servicePointName"],
        category: json["category"],
        productName: json["productName"],
        quantity: json["quantity"],
      );
}
