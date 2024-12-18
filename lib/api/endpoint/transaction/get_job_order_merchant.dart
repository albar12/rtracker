class GetJobOrderMerchant {
  final String id;
  final String name;
  final String shortName;
  final String city;
  final String address;
  final String phoneNumber;
  final String assignedPicName;
  final String picName;
  final String picPhoneNumber;
  final int invoiceCount;
  final String note;
  final String signature;
  final List<String> images;

  GetJobOrderMerchant({
    required this.id,
    required this.name,
    required this.shortName,
    required this.city,
    required this.address,
    required this.phoneNumber,
    required this.assignedPicName,
    required this.picName,
    required this.picPhoneNumber,
    required this.invoiceCount,
    required this.note,
    required this.signature,
    required this.images,
  });

  factory GetJobOrderMerchant.fromJson(Map<String, dynamic> json) => GetJobOrderMerchant(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        shortName: json["shortName"] ?? '',
        city: json["city"] ?? '',
        address: json["address"] ?? '',
        phoneNumber: json["phoneNumber"] ?? '',
        assignedPicName: json["assignedPicName"] ?? '',
        picName: json["picName"] ?? '',
        picPhoneNumber: json["picPhoneNumber"] ?? '',
        invoiceCount: json["invoiceCount"] ?? 0,
        note: json["note"] ?? '',
        signature: json["signature"] ?? '',
        images: json["images"] != null ? List<String>.from(json["images"].map((x) => x)) : [],
      );
}
