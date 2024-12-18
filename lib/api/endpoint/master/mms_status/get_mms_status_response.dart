import 'package:rtracker/api/endpoint/master/mms_status/get_mms_status_response_detail.dart';

class GetMmsStatusResponse {
  final List<GetMmsStatusResponseDetail> data;

  GetMmsStatusResponse({
    required this.data,
  });

  factory GetMmsStatusResponse.fromJson(Map<String, dynamic> json) {
    List<GetMmsStatusResponseDetail> getMmsStatusResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getMmsStatusResponseDetails.add(GetMmsStatusResponseDetail.fromJson(v));
      });
    }

    return GetMmsStatusResponse(data: getMmsStatusResponseDetails);
  }
}
