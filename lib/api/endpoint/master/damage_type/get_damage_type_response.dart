import 'package:rtracker/api/endpoint/master/damage_type/get_damage_type_response_detail.dart';

class GetDamageTypeResponse {
  final List<GetDamageTypeResponseDetail> data;

  GetDamageTypeResponse({
    required this.data,
  });

  factory GetDamageTypeResponse.fromJson(Map<String, dynamic> json) {
    List<GetDamageTypeResponseDetail> getDamageTypeResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getDamageTypeResponseDetails.add(GetDamageTypeResponseDetail.fromJson(v));
      });
    }

    return GetDamageTypeResponse(data: getDamageTypeResponseDetails);
  }
}
