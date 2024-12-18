class GetJobStatusCategoryResponseDetail {
  final String id;
  final String jobStatusId;
  final String jobStatusAliasId;
  final String vendorId;
  final String? jobTypeId;
  final String name;
  final int version;

  GetJobStatusCategoryResponseDetail({
    required this.id,
    required this.jobStatusId,
    required this.jobStatusAliasId,
    required this.vendorId,
    this.jobTypeId,
    required this.name,
    required this.version,
  });

  factory GetJobStatusCategoryResponseDetail.fromJson(
    Map<String, dynamic> json,
  ) =>
      GetJobStatusCategoryResponseDetail(
        id: json["id"].toString(),
        jobStatusId: json["jobStatusId"].toString(),
        jobStatusAliasId: json["jobStatusAliasId"].toString(),
        vendorId: json["vendorId"].toString(),
        jobTypeId: json["jobTypeId"],
        name: json["name"],
        version: json["version"],
      );
}
