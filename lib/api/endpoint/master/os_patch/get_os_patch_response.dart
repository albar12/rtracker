import 'package:rtracker/api/endpoint/master/os_patch/get_os_patch_response_detail.dart';

class GetOsPatchResponse {
  final List<GetOsPatchResponseDetail> data;
  GetOsPatchResponse({
    required this.data,
  });

  factory GetOsPatchResponse.fromJson(Map<String, dynamic> json) {
    List<GetOsPatchResponseDetail> getOsPatchResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getOsPatchResponseDetails.add(GetOsPatchResponseDetail.fromJson(v));
      });
    }

    return GetOsPatchResponse(data: getOsPatchResponseDetails);
  }
}
