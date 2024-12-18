import 'package:rtracker/api/endpoint/master/vendor/get_vendor_response_detail.dart';

class GetVendorResponse {
  final List<GetVendorResponseDetail> data;

  GetVendorResponse({
    required this.data,
  });

  factory GetVendorResponse.fromJson(Map<String, dynamic> json) {
    List<GetVendorResponseDetail> getVendorResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getVendorResponseDetails.add(GetVendorResponseDetail.fromJson(v));
      });
    }

    return GetVendorResponse(data: getVendorResponseDetails);
  }
}
