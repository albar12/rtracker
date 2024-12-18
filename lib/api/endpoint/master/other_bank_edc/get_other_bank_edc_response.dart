import 'package:rtracker/api/endpoint/master/other_bank_edc/get_other_bank_edc_response_detail.dart';

class GetOtherBankEdcResponse {
  final List<GetOtherBankEdcResponseDetail> data;

  GetOtherBankEdcResponse({
    required this.data,
  });

  factory GetOtherBankEdcResponse.fromJson(Map<String, dynamic> json) {
    List<GetOtherBankEdcResponseDetail> getOtherBankEdcResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getOtherBankEdcResponseDetails.add(GetOtherBankEdcResponseDetail.fromJson(v));
      });
    }

    return GetOtherBankEdcResponse(data: getOtherBankEdcResponseDetails);
  }
}
