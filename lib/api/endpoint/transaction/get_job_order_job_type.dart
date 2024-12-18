class GetJobOrderJobType {
  final String id;
  final String name;

  GetJobOrderJobType({
    required this.id,
    required this.name,
  });

  factory GetJobOrderJobType.fromJson(Map<String, dynamic> json) => GetJobOrderJobType(
        id: json["id"],
        name: json["name"],
      );
}
