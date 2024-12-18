class GetJobOrderResponseDeleted {
  final String id;
  final int version;

  GetJobOrderResponseDeleted({
    required this.id,
    required this.version,
  });

  factory GetJobOrderResponseDeleted.fromJson(Map<String, dynamic> json) => GetJobOrderResponseDeleted(
        id: json["id"] ?? '',
        version: json["version"] ?? 0,
      );
}
