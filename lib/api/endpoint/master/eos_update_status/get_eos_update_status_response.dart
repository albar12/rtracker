import 'package:rtracker/api/endpoint/master/eos_update_status/get_eos_update_status_response_detail.dart';

class GetEosUpdateStatusResponse {
  final List<GetEosUpdateStatusResponseDetail> data;

  GetEosUpdateStatusResponse({
    required this.data,
  });

  factory GetEosUpdateStatusResponse.fromJson(Map<String, dynamic> json) {
    List<GetEosUpdateStatusResponseDetail> getEosUpdateStatusResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getEosUpdateStatusResponseDetails.add(GetEosUpdateStatusResponseDetail.fromJson(v));
      });
    }

    return GetEosUpdateStatusResponse(data: getEosUpdateStatusResponseDetails);
  }
}
