import 'package:rtracker/api/endpoint/master/base_office/get_base_office_response_detail.dart';

class GetBaseOfficeResponse {
  final List<GetBaseOfficeResponseDetail> data;

  GetBaseOfficeResponse({
    required this.data,
  });

  factory GetBaseOfficeResponse.fromJson(Map<String, dynamic> json) {
    List<GetBaseOfficeResponseDetail> getBaseOfficeResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getBaseOfficeResponseDetails.add(GetBaseOfficeResponseDetail.fromJson(v));
      });
    }

    return GetBaseOfficeResponse(data: getBaseOfficeResponseDetails);
  }
}
