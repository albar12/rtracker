import 'package:rtracker/api/endpoint/transaction/send_job_order_transaction_test_case.dart';
import 'package:rtracker/helper/formats.dart';

class SendJobOrderTransactionTest {
  final DateTime? date;
  final List<SendJobOrderTransactionTestCase> cases;

  SendJobOrderTransactionTest({
    this.date,
    required this.cases,
  });

  Map<String, dynamic> toJson() => {"date": Formats.isoDateTime(date), "cases": List<dynamic>.from(cases.map((x) => x.toJson()))};
}
