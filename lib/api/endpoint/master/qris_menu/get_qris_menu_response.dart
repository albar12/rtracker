import 'package:rtracker/api/endpoint/master/qris_menu/get_qris_menu_response_detail.dart';

class GetQrisMenuResponse {
  final List<GetQrisMenuResponseDetail> data;

  GetQrisMenuResponse({
    required this.data,
  });

  factory GetQrisMenuResponse.fromJson(Map<String, dynamic> json) {
    List<GetQrisMenuResponseDetail> getQrisMenuResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getQrisMenuResponseDetails.add(GetQrisMenuResponseDetail.fromJson(v));
      });
    }

    return GetQrisMenuResponse(data: getQrisMenuResponseDetails);
  }
}
