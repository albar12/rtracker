class GetReplacementTypeResponseDetail {
  final String id;
  final String name;
  final int version;

  GetReplacementTypeResponseDetail({
    required this.id,
    required this.name,
    required this.version,
  });

  factory GetReplacementTypeResponseDetail.fromJson(
    Map<String, dynamic> json,
  ) =>
      GetReplacementTypeResponseDetail(
        id: json["id"].toString(),
        name: json["name"],
        version: json["version"],
      );
}
