class GetJobTypeResponseDetail {
  final String id;
  final String vendorId;
  final String name;
  final String description;
  final int version;

  GetJobTypeResponseDetail({
    required this.id,
    required this.vendorId,
    required this.name,
    required this.description,
    required this.version,
  });

  factory GetJobTypeResponseDetail.fromJson(Map<String, dynamic> json) => GetJobTypeResponseDetail(
        id: json["id"].toString(),
        vendorId: json["vendorId"].toString(),
        name: json["name"],
        description: json["description"] ?? "",
        version: json["version"],
      );
}
