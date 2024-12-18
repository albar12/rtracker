class GetNoteResponseDetail {
  final String id;
  final String name;
  final int version;

  GetNoteResponseDetail({
    required this.id,
    required this.name,
    required this.version,
  });

  factory GetNoteResponseDetail.fromJson(Map<String, dynamic> json) => GetNoteResponseDetail(
        id: json["id"].toString(),
        name: json["name"],
        version: json["version"],
      );
}
