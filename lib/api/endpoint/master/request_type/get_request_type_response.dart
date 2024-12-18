import 'package:rtracker/api/endpoint/master/request_type/get_request_type_response_detail.dart';

class GetRequestTypeResponse {
  final List<GetRequestTypeResponseDetail> data;

  GetRequestTypeResponse({
    required this.data,
  });

  factory GetRequestTypeResponse.fromJson(Map<String, dynamic> json) {
    List<GetRequestTypeResponseDetail> getRequestTypeResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getRequestTypeResponseDetails.add(GetRequestTypeResponseDetail.fromJson(v));
      });
    }

    return GetRequestTypeResponse(data: getRequestTypeResponseDetails);
  }
}
