class GetJobOrderQrisMenu {
  final String id;
  final String name;
  final bool value;

  GetJobOrderQrisMenu({
    required this.id,
    required this.name,
    required this.value,
  });

  factory GetJobOrderQrisMenu.fromJson(Map<String, dynamic> json) => GetJobOrderQrisMenu(
        id: json["id"],
        name: json["name"],
        value: json["value"],
      );
}
