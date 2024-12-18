import 'package:rtracker/api/endpoint/master/edc_equipment/get_edc_equipment_response_detail.dart';

class GetEdcEquipmentResponse {
  final int version;
  final List<GetEdcEquipmentResponseDetail> data;

  GetEdcEquipmentResponse({
    required this.version,
    required this.data,
  });

  factory GetEdcEquipmentResponse.fromJson(Map<String, dynamic> json) {
    List<GetEdcEquipmentResponseDetail> getEdcEquipmentResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getEdcEquipmentResponseDetails.add(GetEdcEquipmentResponseDetail.fromJson(v));
      });
    }

    return GetEdcEquipmentResponse(
      version: json["version"],
      data: getEdcEquipmentResponseDetails,
    );
  }
}
