import 'package:rtracker/api/endpoint/master/edc_communication_type/get_edc_communication_type_response_detail.dart';

class GetEdcCommunicationTypeResponse {
  final List<GetEdcCommunicationTypeResponseDetail> data;

  GetEdcCommunicationTypeResponse({
    required this.data,
  });

  factory GetEdcCommunicationTypeResponse.fromJson(Map<String, dynamic> json) {
    List<GetEdcCommunicationTypeResponseDetail> getEdcCommunicationTypeResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getEdcCommunicationTypeResponseDetails.add(GetEdcCommunicationTypeResponseDetail.fromJson(v));
      });
    }

    return GetEdcCommunicationTypeResponse(
      data: getEdcCommunicationTypeResponseDetails,
    );
  }
}
