class GetTrainingMaterialResponseDetail {
  final String id;
  final String name;
  final int version;

  GetTrainingMaterialResponseDetail({
    required this.id,
    required this.name,
    required this.version,
  });

  factory GetTrainingMaterialResponseDetail.fromJson(
    Map<String, dynamic> json,
  ) =>
      GetTrainingMaterialResponseDetail(
        id: json["id"].toString(),
        name: json["name"],
        version: json["version"],
      );
}
