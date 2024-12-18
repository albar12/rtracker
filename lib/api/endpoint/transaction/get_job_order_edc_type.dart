class GetJobOrderEdcType {
  final String id;
  final String name;
  final String flag_android;

  GetJobOrderEdcType({
    required this.id,
    required this.name,
    required this.flag_android,
  });

  factory GetJobOrderEdcType.fromJson(Map<String, dynamic> json) =>
      GetJobOrderEdcType(
        id: json["id"],
        name: json["name"],
        flag_android: json["flag_android"],
      );
}
