class GetSnStockResponseDetail {
  final String category;
  final String productId;
  final String productName;
  final String serialNumber;
  final String servicePointId;
  final String servicePointName;

  GetSnStockResponseDetail({
    required this.category,
    required this.productId,
    required this.productName,
    required this.serialNumber,
    required this.servicePointId,
    required this.servicePointName,
  });

  factory GetSnStockResponseDetail.fromJson(Map<String, dynamic> json) => GetSnStockResponseDetail(
        category: json["category"],
        productId: json["productId"],
        productName: json["productName"],
        serialNumber: json["serialNumber"],
        servicePointId: json["servicePointId"],
        servicePointName: json["servicePointName"],
      );
}
