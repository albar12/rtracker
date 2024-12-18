class GetJobOrderServicePoint {
  final String id;
  final String name;

  GetJobOrderServicePoint({
    required this.id,
    required this.name,
  });

  factory GetJobOrderServicePoint.fromJson(Map<String, dynamic> json) => GetJobOrderServicePoint(
        id: json["id"],
        name: json["name"],
      );
}
