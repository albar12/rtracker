class GetProviderResponseDetail {
  final String id;
  final String vendorId;
  final String name;
  final int version;

  GetProviderResponseDetail({
    required this.id,
    required this.vendorId,
    required this.name,
    required this.version,
  });

  factory GetProviderResponseDetail.fromJson(Map<String, dynamic> json) => GetProviderResponseDetail(
        id: json["id"].toString(),
        vendorId: json["vendorId"].toString(),
        name: json["name"],
        version: json["version"],
      );
}
