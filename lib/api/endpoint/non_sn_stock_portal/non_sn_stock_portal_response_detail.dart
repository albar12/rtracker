class NonSnStockPortalResponseDetail {
  final String id;
  final String vendorId;
  final String vendorName;
  final String servicePointName;
  final String category;
  final String productId;
  final String productName;
  final int quantity;
  final String status;

  NonSnStockPortalResponseDetail({
    required this.id,
    required this.vendorId,
    required this.vendorName,
    required this.servicePointName,
    required this.category,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.status,
  });

  factory NonSnStockPortalResponseDetail.fromJson(Map<String, dynamic> json) => NonSnStockPortalResponseDetail(
        id: json["id"] ?? "",
        vendorId: json["vendorId"] ?? "",
        vendorName: json["vendorName"] ?? "",
        servicePointName: json["servicePointName"] ?? "",
        category: json["category"] ?? "",
        productId: json["productId"] ?? "",
        productName: json["productName"] ?? "",
        quantity: json["quantity"],
        status: json["status"],
      );
}
