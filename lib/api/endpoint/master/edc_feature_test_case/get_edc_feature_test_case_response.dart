import 'package:rtracker/api/endpoint/master/edc_feature_test_case/get_edc_feature_test_case_response_detail.dart';

class GetEdcFeatureTestCaseResponse {
  final List<GetEdcFeatureTestCaseResponseDetail> data;

  GetEdcFeatureTestCaseResponse({
    required this.data,
  });

  factory GetEdcFeatureTestCaseResponse.fromJson(Map<String, dynamic> json) {
    List<GetEdcFeatureTestCaseResponseDetail> getEdcFeatureTestCaseResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getEdcFeatureTestCaseResponseDetails.add(GetEdcFeatureTestCaseResponseDetail.fromJson(v));
      });
    }

    return GetEdcFeatureTestCaseResponse(
      data: getEdcFeatureTestCaseResponseDetails,
    );
  }
}
