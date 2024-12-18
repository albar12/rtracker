class GetBaseOfficeResponseDetail {
  final String id;
  final String name;
  final int version;

  GetBaseOfficeResponseDetail({
    required this.id,
    required this.name,
    required this.version,
  });

  factory GetBaseOfficeResponseDetail.fromJson(Map<String, dynamic> json) => GetBaseOfficeResponseDetail(
        id: json["id"].toString(),
        name: json["name"],
        version: json["version"],
      );
}
