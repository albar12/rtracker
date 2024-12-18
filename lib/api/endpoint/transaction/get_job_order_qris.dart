import 'package:rtracker/api/endpoint/transaction/get_job_order_qris_menu.dart';

class GetJobOrderQris {
  final bool exist;
  final bool testResult;
  final List<GetJobOrderQrisMenu> menus;
  final List<String> qrisReceiptImages;
  final List<String> brizziInstallmentReceiptImages;

  GetJobOrderQris({
    required this.exist,
    required this.testResult,
    required this.menus,
    required this.qrisReceiptImages,
    required this.brizziInstallmentReceiptImages,
  });

  factory GetJobOrderQris.fromJson(Map<String, dynamic> json) => GetJobOrderQris(
        exist: json["exist"] ?? false,
        testResult: json["testResult"] ?? false,
        menus: json["menus"] != null
            ? List<GetJobOrderQrisMenu>.from(
                json["menus"].map((x) => GetJobOrderQrisMenu.fromJson(x)),
              )
            : [],
        qrisReceiptImages: json["qrisReceiptImages"] != null ? List<String>.from(json["qrisReceiptImages"].map((x) => x)) : [],
        brizziInstallmentReceiptImages: json["brizziInstallmentReceiptImages"] != null
            ? List<String>.from(
                json["brizziInstallmentReceiptImages"].map((x) => x),
              )
            : [],
      );
}
