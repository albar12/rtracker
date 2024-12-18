import 'package:rtracker/api/endpoint/master/dor_menu/get_dor_menu_response_detail.dart';

class GetDorMenuResponse {
  final List<GetDorMenuResponseDetail> data;

  GetDorMenuResponse({
    required this.data,
  });

  factory GetDorMenuResponse.fromJson(Map<String, dynamic> json) {
    List<GetDorMenuResponseDetail> getDorMenuResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getDorMenuResponseDetails.add(GetDorMenuResponseDetail.fromJson(v));
      });
    }

    return GetDorMenuResponse(data: getDorMenuResponseDetails);
  }
}
