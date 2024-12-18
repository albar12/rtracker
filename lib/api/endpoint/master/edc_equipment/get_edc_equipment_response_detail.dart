class GetEdcEquipmentResponseDetail {
  final String name;
  final String vendorId;

  GetEdcEquipmentResponseDetail({
    required this.name,
    required this.vendorId,
  });

  factory GetEdcEquipmentResponseDetail.fromJson(Map<String, dynamic> json) => GetEdcEquipmentResponseDetail(
        name: json["name"],
        vendorId: json["vendorId"],
      );
}
