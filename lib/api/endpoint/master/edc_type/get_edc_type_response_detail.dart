class GetEdcTypeResponseDetail {
  final String id;
  final String vendorId;
  final String name;
  final int version;
  final int flag_android;

  GetEdcTypeResponseDetail({
    required this.id,
    required this.vendorId,
    required this.name,
    required this.version,
    required this.flag_android,
  });

  factory GetEdcTypeResponseDetail.fromJson(Map<String, dynamic> json) =>
      GetEdcTypeResponseDetail(
        id: json["id"].toString(),
        vendorId: json["vendorId"].toString(),
        name: json["name"],
        version: json["version"],
        flag_android: json["flag_android"],
      );
}
