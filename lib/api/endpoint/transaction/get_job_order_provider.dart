class GetJobOrderProvider {
  final String id;
  final String name;

  GetJobOrderProvider({
    required this.id,
    required this.name,
  });

  factory GetJobOrderProvider.fromJson(Map<String, dynamic> json) => GetJobOrderProvider(
        id: json["id"],
        name: json["name"],
      );
}
