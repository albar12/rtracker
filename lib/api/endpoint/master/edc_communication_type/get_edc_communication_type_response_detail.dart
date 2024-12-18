class GetEdcCommunicationTypeResponseDetail {
  final String id;
  final String name;
  final int version;

  GetEdcCommunicationTypeResponseDetail({
    required this.id,
    required this.name,
    required this.version,
  });

  factory GetEdcCommunicationTypeResponseDetail.fromJson(
    Map<String, dynamic> json,
  ) =>
      GetEdcCommunicationTypeResponseDetail(
        id: json["id"].toString(),
        name: json["name"],
        version: json["version"],
      );
}
