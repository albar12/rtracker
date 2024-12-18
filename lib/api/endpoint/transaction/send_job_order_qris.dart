import 'package:rtracker/api/endpoint/transaction/send_job_order_qris_menu.dart';

class SendJobOrderQris {
  final bool exist;
  final bool testResult;
  final List<SendJobOrderQrisMenu> menus;

  SendJobOrderQris({
    required this.exist,
    required this.testResult,
    required this.menus,
  });

  Map<String, dynamic> toJson() => {"exist": exist, "testResult": testResult, "menus": List<dynamic>.from(menus.map((x) => x.toJson()))};
}
