class GetJobOrderJobCategory {
  final String id;
  final String name;
  final bool value;

  GetJobOrderJobCategory({
    required this.id,
    required this.name,
    required this.value,
  });

  factory GetJobOrderJobCategory.fromJson(Map<String, dynamic> json) => GetJobOrderJobCategory(
        id: json["id"],
        name: json["name"],
        value: json["value"],
      );
}
