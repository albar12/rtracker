import 'package:rtracker/api/endpoint/master/app_version/get_app_version_response_detail.dart';

class GetAppVersionResponse {
  final List<GetAppVersionResponseDetail> data;
  GetAppVersionResponse({required this.data});

  factory GetAppVersionResponse.fromJson(Map<String, dynamic> json) {
    List<GetAppVersionResponseDetail> getAppVersionResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getAppVersionResponseDetails
            .add(GetAppVersionResponseDetail.fromJson(v));
      });
    }

    return GetAppVersionResponse(data: getAppVersionResponseDetails);
  }
}
