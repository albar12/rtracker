class GetEdcFeatureTestCaseResponseDetail {
  final String id;
  final String name;
  final String type;
  final int version;

  GetEdcFeatureTestCaseResponseDetail({
    required this.id,
    required this.name,
    required this.type,
    required this.version,
  });

  factory GetEdcFeatureTestCaseResponseDetail.fromJson(
    Map<String, dynamic> json,
  ) =>
      GetEdcFeatureTestCaseResponseDetail(
        id: json["id"].toString(),
        name: json["name"],
        type: json["type"] ?? "",
        version: json["version"],
      );
}
