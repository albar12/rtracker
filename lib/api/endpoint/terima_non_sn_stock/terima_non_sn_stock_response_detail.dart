class TerimaNonSnStockResponseDetail {
  final String id;
  final String vendorId;
  final String vendorName;
  final String servicePointName;
  final String category;
  final String productId;
  final String productName;
  final int quantity;

  TerimaNonSnStockResponseDetail({
    required this.id,
    required this.vendorId,
    required this.vendorName,
    required this.servicePointName,
    required this.productId,
    required this.productName,
    required this.category,
    required this.quantity,
  });

  factory TerimaNonSnStockResponseDetail.fromJson(Map<String, dynamic> json) => TerimaNonSnStockResponseDetail(
        id: json["id"] ?? "",
        vendorId: json["vendorId"] ?? "",
        vendorName: json["vendorName"] ?? "",
        servicePointName: json["servicePointName"] ?? "",
        productId: json["productId"] ?? "",
        productName: json["productName"] ?? "",
        category: json["category"] ?? "",
        quantity: json["quantity"],
      );
}
