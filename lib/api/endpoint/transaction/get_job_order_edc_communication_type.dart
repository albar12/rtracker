class GetJobOrderEdcCommunicationType {
  final String id;
  final String name;

  GetJobOrderEdcCommunicationType({
    required this.id,
    required this.name,
  });

  factory GetJobOrderEdcCommunicationType.fromJson(Map<String, dynamic> json) => GetJobOrderEdcCommunicationType(
        id: json["id"],
        name: json["name"],
      );
}
