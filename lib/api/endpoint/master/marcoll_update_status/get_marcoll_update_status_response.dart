import 'package:rtracker/api/endpoint/master/marcoll_update_status/get_marcoll_update_status_response_detail.dart';

class GetMarcollUpdateStatusResponse {
  final List<GetMarcollUpdateStatusResponseDetail> data;

  GetMarcollUpdateStatusResponse({
    required this.data,
  });

  factory GetMarcollUpdateStatusResponse.fromJson(Map<String, dynamic> json) {
    List<GetMarcollUpdateStatusResponseDetail> getMarcollUpdateStatusResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getMarcollUpdateStatusResponseDetails.add(GetMarcollUpdateStatusResponseDetail.fromJson(v));
      });
    }

    return GetMarcollUpdateStatusResponse(
      data: getMarcollUpdateStatusResponseDetails,
    );
  }
}
