import 'package:rtracker/api/endpoint/transaction/get_job_order_transaction_test_case.dart';

class GetJobOrderTransactionTest {
  final DateTime? date;
  final List<GetJobOrderTransactionTestCase> cases;
  final List<String> images;

  GetJobOrderTransactionTest({
    required this.date,
    required this.cases,
    required this.images,
  });

  factory GetJobOrderTransactionTest.fromJson(Map<String, dynamic> json) => GetJobOrderTransactionTest(
        date: DateTime.tryParse(json["date"] ?? ''),
        cases: json["cases"] != null
            ? List<GetJobOrderTransactionTestCase>.from(
                json["cases"].map((x) => GetJobOrderTransactionTestCase.fromJson(x)),
              )
            : [],
        images: json["images"] != null ? List<String>.from(json["images"].map((x) => x)) : [],
      );
}
