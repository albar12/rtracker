class GetJobOrderEdcFeatureTestCase {
  final String id;
  final String name;
  final String type;
  final bool value;

  GetJobOrderEdcFeatureTestCase({
    required this.id,
    required this.name,
    required this.type,
    required this.value,
  });

  factory GetJobOrderEdcFeatureTestCase.fromJson(Map<String, dynamic> json) => GetJobOrderEdcFeatureTestCase(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        value: json["value"],
      );
}
