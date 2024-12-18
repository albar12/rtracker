class GetQrisMenuResponseDetail {
  final String id;
  final String name;
  final int version;

  GetQrisMenuResponseDetail({
    required this.id,
    required this.name,
    required this.version,
  });

  factory GetQrisMenuResponseDetail.fromJson(Map<String, dynamic> json) => GetQrisMenuResponseDetail(
        id: json["id"].toString(),
        name: json["name"],
        version: json["version"],
      );
}
