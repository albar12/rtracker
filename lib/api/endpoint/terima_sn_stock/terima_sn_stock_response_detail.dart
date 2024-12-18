class TerimaSnStockResponseDetail {
  final String id;
  final String vendorName;
  final String category;
  final String productId;
  final String servicePointId;
  final String servicePointName;
  final String productName;
  final String serialNumber;

  TerimaSnStockResponseDetail({
    required this.id,
    required this.vendorName,
    required this.category,
    required this.productId,
    required this.servicePointId,
    required this.servicePointName,
    required this.productName,
    required this.serialNumber,
  });

  factory TerimaSnStockResponseDetail.fromJson(Map<String, dynamic> json) => TerimaSnStockResponseDetail(
        id: json["id"] ?? "",
        vendorName: json["vendorName"] ?? "",
        category: json["category"] ?? "",
        productId: json["productId"] ?? "",
        servicePointId: json["servicePointId"] ?? "",
        servicePointName: json["servicePointName"] ?? "",
        productName: json["productName"] ?? "",
        serialNumber: json["serialNumber"] ?? "",
      );
}
