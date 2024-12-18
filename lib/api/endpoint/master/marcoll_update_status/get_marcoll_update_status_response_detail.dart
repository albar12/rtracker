class GetMarcollUpdateStatusResponseDetail {
  final String id;
  final String name;
  final int version;

  GetMarcollUpdateStatusResponseDetail({
    required this.id,
    required this.name,
    required this.version,
  });

  factory GetMarcollUpdateStatusResponseDetail.fromJson(
    Map<String, dynamic> json,
  ) =>
      GetMarcollUpdateStatusResponseDetail(
        id: json["id"].toString(),
        name: json["name"],
        version: json["version"],
      );
}
