import 'package:rtracker/api/endpoint/master/replacement_type/get_replacement_type_response_detail.dart';

class GetReplacementTypeResponse {
  final List<GetReplacementTypeResponseDetail> data;

  GetReplacementTypeResponse({
    required this.data,
  });

  factory GetReplacementTypeResponse.fromJson(Map<String, dynamic> json) {
    List<GetReplacementTypeResponseDetail> getReplacementTypeResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getReplacementTypeResponseDetails.add(GetReplacementTypeResponseDetail.fromJson(v));
      });
    }

    return GetReplacementTypeResponse(data: getReplacementTypeResponseDetails);
  }
}
