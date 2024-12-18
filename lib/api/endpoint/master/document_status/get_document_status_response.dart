import 'package:rtracker/api/endpoint/master/document_status/get_document_status_response_detail.dart';

class GetDocumentStatusResponse {
  final List<GetDocumentStatusResponseDetail> data;

  GetDocumentStatusResponse({
    required this.data,
  });

  factory GetDocumentStatusResponse.fromJson(Map<String, dynamic> json) {
    List<GetDocumentStatusResponseDetail> getDocumentStatusResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getDocumentStatusResponseDetails.add(GetDocumentStatusResponseDetail.fromJson(v));
      });
    }

    return GetDocumentStatusResponse(data: getDocumentStatusResponseDetails);
  }
}
