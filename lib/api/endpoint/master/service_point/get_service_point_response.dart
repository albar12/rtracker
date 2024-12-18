import 'package:rtracker/api/endpoint/master/service_point/get_service_point_response_detail.dart';

class GetServicePointResponse {
  final List<GetServicePointResponseDetail> data;

  GetServicePointResponse({
    required this.data,
  });

  factory GetServicePointResponse.fromJson(Map<String, dynamic> json) {
    List<GetServicePointResponseDetail> getServicePointResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getServicePointResponseDetails.add(GetServicePointResponseDetail.fromJson(v));
      });
    }

    return GetServicePointResponse(data: getServicePointResponseDetails);
  }
}
