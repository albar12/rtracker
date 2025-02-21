class GetFiturEdcBniMtiResponseDetail {
  final String id;
  final String name;
  final int version;

  GetFiturEdcBniMtiResponseDetail({
    required this.id,
    required this.name,
    required this.version,
  });

  factory GetFiturEdcBniMtiResponseDetail.fromJson(Map<String, dynamic> json) => GetFiturEdcBniMtiResponseDetail(
    id: json["id"].toString(),
    name: json["name"],
    version: json["version"],
  );
}
