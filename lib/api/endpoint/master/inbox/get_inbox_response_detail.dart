class GetInboxResponseDetail {
  final String id;
  final String title;
  final String body;
  final DateTime date;
  final bool read;
  final int version;

  GetInboxResponseDetail({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    required this.read,
    required this.version,
  });

  factory GetInboxResponseDetail.fromJson(Map<String, dynamic> json) => GetInboxResponseDetail(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        date: DateTime.parse(json["date"]),
        read: json["read"],
        version: json["version"],
      );
}
