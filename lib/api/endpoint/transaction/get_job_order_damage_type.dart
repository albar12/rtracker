class GetJobOrderDamageType {
  final String id;
  final String name;

  GetJobOrderDamageType({
    required this.id,
    required this.name,
  });

  factory GetJobOrderDamageType.fromJson(Map<String, dynamic> json) => GetJobOrderDamageType(
        id: json["id"],
        name: json["name"],
      );
}
