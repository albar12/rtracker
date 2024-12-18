class GetDorMenuResponseDetail {
  final String id;
  final String name;
  final int version;

  GetDorMenuResponseDetail({
    required this.id,
    required this.name,
    required this.version,
  });

  factory GetDorMenuResponseDetail.fromJson(Map<String, dynamic> json) =>
      GetDorMenuResponseDetail(
        id: json["id"].toString(),
        name: json["name"],
        version: json["version"],
      );
}
