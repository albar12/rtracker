class GetVendorResponseDetail {
  final String id;
  final String name;
  final int version;

  GetVendorResponseDetail({
    required this.id,
    required this.name,
    required this.version,
  });

  factory GetVendorResponseDetail.fromJson(Map<String, dynamic> json) => GetVendorResponseDetail(
        id: json["id"].toString(),
        name: json["name"],
        version: json["version"],
      );
}
