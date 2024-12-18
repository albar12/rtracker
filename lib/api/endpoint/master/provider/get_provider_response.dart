import 'package:rtracker/api/endpoint/master/provider/get_provider_response_detail.dart';

class GetProviderResponse {
  final List<GetProviderResponseDetail> data;

  GetProviderResponse({
    required this.data,
  });

  factory GetProviderResponse.fromJson(Map<String, dynamic> json) {
    List<GetProviderResponseDetail> getProviderResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getProviderResponseDetails.add(GetProviderResponseDetail.fromJson(v));
      });
    }

    return GetProviderResponse(data: getProviderResponseDetails);
  }
}
