class GetJobOrderBaseOffice {
  final String id;
  final String name;

  GetJobOrderBaseOffice({
    required this.id,
    required this.name,
  });

  factory GetJobOrderBaseOffice.fromJson(Map<String, dynamic> json) => GetJobOrderBaseOffice(
        id: json["id"],
        name: json["name"],
      );
}
