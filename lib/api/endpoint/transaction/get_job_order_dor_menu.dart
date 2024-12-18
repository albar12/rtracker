class GetJobOrderDorMenu {
  final String id;
  final String name;

  GetJobOrderDorMenu({
    required this.id,
    required this.name,
  });

  factory GetJobOrderDorMenu.fromJson(Map<String, dynamic> json) => GetJobOrderDorMenu(
        id: json["id"],
        name: json["name"],
      );
}
