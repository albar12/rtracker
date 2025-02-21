import 'package:rtracker/api/endpoint/master/fitur_edc_bni_mti/get_fitur_edc_bni_mti_response_detail.dart';

class GetFiturEdcBniMtiResponse {
  final List<GetFiturEdcBniMtiResponseDetail> data;

  GetFiturEdcBniMtiResponse({
    required this.data,
  });

  factory GetFiturEdcBniMtiResponse.fromJson(Map<String, dynamic> json) {
    List<GetFiturEdcBniMtiResponseDetail> getFiturEdcBniMtiResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getFiturEdcBniMtiResponseDetails.add(GetFiturEdcBniMtiResponseDetail.fromJson(v));
      });
    }

    return GetFiturEdcBniMtiResponse(data: getFiturEdcBniMtiResponseDetails);
  }
}
