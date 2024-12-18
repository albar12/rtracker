class GetJobStatusResponseDetail {
  final String id;
  final String aliasId;
  final String vendorId;
  final String name;
  final int version;

  GetJobStatusResponseDetail({
    required this.id,
    required this.aliasId,
    required this.vendorId,
    required this.name,
    required this.version,
  });

  factory GetJobStatusResponseDetail.fromJson(Map<String, dynamic> json) => GetJobStatusResponseDetail(
        id: json["id"].toString(),
        aliasId: json["aliasId"].toString(),
        vendorId: json["vendorId"].toString(),
        name: json["name"],
        version: json["version"],
      );
}
