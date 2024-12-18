class SnStockPortalResponseDetail {
  final String id;
  final String vendorId;
  final String vendorName;
  final String servicePointId;
  final String servicePointName;
  final String productId;
  final String productName;
  final String category;
  final String serialNumber;
  final String status;

  SnStockPortalResponseDetail({
    required this.id,
    required this.vendorId,
    required this.vendorName,
    required this.servicePointId,
    required this.servicePointName,
    required this.productId,
    required this.productName,
    required this.category,
    required this.serialNumber,
    required this.status,
  });

  factory SnStockPortalResponseDetail.fromJson(Map<String, dynamic> json) => SnStockPortalResponseDetail(
        id: json["id"] ?? "",
        vendorId: json["vendorId"] ?? "",
        vendorName: json["vendorName"] ?? "",
        servicePointId: json["servicePointId"] ?? "",
        servicePointName: json["servicePointName"] ?? "",
        productId: json["productId"] ?? "",
        productName: json["productName"] ?? "",
        category: json["category"] ?? "",
        serialNumber: json["serialNumber"] ?? "",
        status: json["status"] ?? "",
      );
}
