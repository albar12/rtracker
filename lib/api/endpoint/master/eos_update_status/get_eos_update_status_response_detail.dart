class GetEosUpdateStatusResponseDetail {
  final String id;
  final String name;
  final int version;

  GetEosUpdateStatusResponseDetail({
    required this.id,
    required this.name,
    required this.version,
  });

  factory GetEosUpdateStatusResponseDetail.fromJson(
    Map<String, dynamic> json,
  ) =>
      GetEosUpdateStatusResponseDetail(
        id: json["id"].toString(),
        name: json["name"],
        version: json["version"],
      );
}
