import 'package:rtracker/api/endpoint/master/transaction_test_case/get_transaction_test_case_response_detail.dart';

class GetTransactionTestCaseResponse {
  final List<GetTransactionTestCaseResponseDetail> data;

  GetTransactionTestCaseResponse({
    required this.data,
  });

  factory GetTransactionTestCaseResponse.fromJson(Map<String, dynamic> json) {
    List<GetTransactionTestCaseResponseDetail> getTransactionTestCaseResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getTransactionTestCaseResponseDetails.add(GetTransactionTestCaseResponseDetail.fromJson(v));
      });
    }

    return GetTransactionTestCaseResponse(
      data: getTransactionTestCaseResponseDetails,
    );
  }
}
