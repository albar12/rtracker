class GetDocumentStatusResponseDetail {
  final String id;
  final String name;
  final int version;

  GetDocumentStatusResponseDetail({
    required this.id,
    required this.name,
    required this.version,
  });

  factory GetDocumentStatusResponseDetail.fromJson(Map<String, dynamic> json) => GetDocumentStatusResponseDetail(
        id: json["id"].toString(),
        name: json["name"],
        version: json["version"],
      );
}
