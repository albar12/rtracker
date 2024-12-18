class GetMmsStatusResponseDetail {
  final String id;
  final String name;
  final int version;

  GetMmsStatusResponseDetail({
    required this.id,
    required this.name,
    required this.version,
  });

  factory GetMmsStatusResponseDetail.fromJson(Map<String, dynamic> json) => GetMmsStatusResponseDetail(
        id: json["id"].toString(),
        name: json["name"],
        version: json["version"],
      );
}
