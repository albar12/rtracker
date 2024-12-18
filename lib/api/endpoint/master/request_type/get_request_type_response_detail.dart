class GetRequestTypeResponseDetail {
  final String id;
  final String name;
  final int version;

  GetRequestTypeResponseDetail({
    required this.id,
    required this.name,
    required this.version,
  });

  factory GetRequestTypeResponseDetail.fromJson(Map<String, dynamic> json) => GetRequestTypeResponseDetail(
        id: json["id"].toString(),
        name: json["name"],
        version: json["version"],
      );
}
