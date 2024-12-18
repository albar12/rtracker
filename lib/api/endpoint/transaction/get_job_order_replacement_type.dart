class GetJobOrderReplacementType {
  final String id;
  final String name;

  GetJobOrderReplacementType({
    required this.id,
    required this.name,
  });

  factory GetJobOrderReplacementType.fromJson(Map<String, dynamic> json) => GetJobOrderReplacementType(
        id: json["id"],
        name: json["name"],
      );
}
