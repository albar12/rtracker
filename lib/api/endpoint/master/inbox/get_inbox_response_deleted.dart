class GetInboxResponseDeleted {
  final String id;
  final int version;

  GetInboxResponseDeleted({
    required this.id,
    required this.version,
  });

  factory GetInboxResponseDeleted.fromJson(Map<String, dynamic> json) => GetInboxResponseDeleted(
        id: json["id"] ?? '',
        version: json["version"] ?? 0,
      );
}
