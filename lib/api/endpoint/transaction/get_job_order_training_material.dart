class GetJobOrderTrainingMaterial {
  final String id;
  final String name;
  final bool value;

  GetJobOrderTrainingMaterial({
    required this.id,
    required this.name,
    required this.value,
  });

  factory GetJobOrderTrainingMaterial.fromJson(Map<String, dynamic> json) => GetJobOrderTrainingMaterial(
        id: json["id"],
        name: json["name"],
        value: json["value"],
      );
}
