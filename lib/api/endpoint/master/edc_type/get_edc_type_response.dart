import 'package:rtracker/api/endpoint/master/edc_type/get_edc_type_response_detail.dart';

class GetEdcTypeResponse {
  final List<GetEdcTypeResponseDetail> data;

  GetEdcTypeResponse({
    required this.data,
  });

  factory GetEdcTypeResponse.fromJson(Map<String, dynamic> json) {
    List<GetEdcTypeResponseDetail> getEdcTypeResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getEdcTypeResponseDetails.add(GetEdcTypeResponseDetail.fromJson(v));
      });
    }

    return GetEdcTypeResponse(data: getEdcTypeResponseDetails);
  }
}
