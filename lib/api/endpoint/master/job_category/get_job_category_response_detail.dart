class GetJobCategoryResponseDetail {
  final String id;
  final String vendorId;
  final String name;
  final int version;

  GetJobCategoryResponseDetail({
    required this.id,
    required this.vendorId,
    required this.name,
    required this.version,
  });

  factory GetJobCategoryResponseDetail.fromJson(Map<String, dynamic> json) => GetJobCategoryResponseDetail(
        id: json["id"].toString(),
        vendorId: json["vendorId"].toString(),
        name: json["name"],
        version: json["version"],
      );
}
