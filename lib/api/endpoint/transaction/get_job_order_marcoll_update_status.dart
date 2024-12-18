class GetJobOrderMarcollUpdateStatus {
  final String id;
  final String name;

  GetJobOrderMarcollUpdateStatus({
    required this.id,
    required this.name,
  });

  factory GetJobOrderMarcollUpdateStatus.fromJson(Map<String, dynamic> json) => GetJobOrderMarcollUpdateStatus(
        id: json["id"],
        name: json["name"],
      );
}
