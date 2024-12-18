class GetJobOrderRequestType {
  final String id;
  final String name;

  GetJobOrderRequestType({
    required this.id,
    required this.name,
  });

  factory GetJobOrderRequestType.fromJson(Map<String, dynamic> json) => GetJobOrderRequestType(
        id: json["id"],
        name: json["name"],
      );
}
