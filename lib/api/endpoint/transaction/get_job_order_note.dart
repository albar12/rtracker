class GetJobOrderNote {
  final String id;
  final String name;
  final bool value;

  GetJobOrderNote({
    required this.id,
    required this.name,
    required this.value,
  });

  factory GetJobOrderNote.fromJson(Map<String, dynamic> json) => GetJobOrderNote(
        id: json["id"],
        name: json["name"],
        value: json["value"],
      );
}
