class GetServicePointResponseDetail {
  final String id;
  final String vendorId;
  final String baseOfficeId;
  final String name;
  final int version;

  GetServicePointResponseDetail({
    required this.id,
    required this.vendorId,
    required this.baseOfficeId,
    required this.name,
    required this.version,
  });

  factory GetServicePointResponseDetail.fromJson(Map<String, dynamic> json) => GetServicePointResponseDetail(
        id: json["id"].toString(),
        vendorId: json["vendorId"].toString(),
        baseOfficeId: json["baseOfficeId"].toString(),
        name: json["name"],
        version: json["version"],
      );
}
