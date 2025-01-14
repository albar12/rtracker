import 'dart:convert';

SubmitResponse submitResponseFromJson(String str) => SubmitResponse.fromJson(json.decode(str));

String submitResponseToJson(SubmitResponse data) => json.encode(data.toJson());

class SubmitResponse {
  final String status;
  final String keteranganStatus;
  final String keterangan;

  SubmitResponse({
    required this.status,
    required this.keteranganStatus,
    required this.keterangan,
  });

  factory SubmitResponse.fromJson(Map<String, dynamic> json) => SubmitResponse(
    status: json["status"] ?? "",
    keteranganStatus: json["keterangan_status"] ?? "",
    keterangan: json["keterangan"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "keterangan_status": keteranganStatus,
    "keterangan": keterangan,
  };
}
