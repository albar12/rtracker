class GetJobOrderDocumentStatus {
  final String id;
  final String name;

  GetJobOrderDocumentStatus({
    required this.id,
    required this.name,
  });

  factory GetJobOrderDocumentStatus.fromJson(Map<String, dynamic> json) => GetJobOrderDocumentStatus(
        id: json["id"],
        name: json["name"],
      );
}
