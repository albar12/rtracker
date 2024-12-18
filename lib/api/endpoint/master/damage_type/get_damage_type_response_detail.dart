class GetDamageTypeResponseDetail {
  final String id;
  final String name;
  final int version;

  GetDamageTypeResponseDetail({
    required this.id,
    required this.name,
    required this.version,
  });

  factory GetDamageTypeResponseDetail.fromJson(Map<String, dynamic> json) => GetDamageTypeResponseDetail(
        id: json["id"].toString(),
        name: json["name"],
        version: json["version"],
      );
}
