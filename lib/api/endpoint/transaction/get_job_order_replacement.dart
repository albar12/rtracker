import 'package:rtracker/api/endpoint/transaction/get_job_order_replacement_type.dart';

class GetJobOrderReplacement {
  final GetJobOrderReplacementType? type;
  final String category;
  final String productId;
  final String name;
  final String oldSerialNumber;
  final String newSerialNumber;
  final int quantity;
  final String reason;

  GetJobOrderReplacement({
    required this.type,
    required this.category,
    required this.productId,
    required this.name,
    required this.oldSerialNumber,
    required this.newSerialNumber,
    required this.quantity,
    required this.reason,
  });

  factory GetJobOrderReplacement.fromJson(Map<String, dynamic> json) => GetJobOrderReplacement(
        type: json["type"] != null ? GetJobOrderReplacementType.fromJson(json["type"]) : null,
        category: json["category"],
        productId: json["productId"],
        name: json["name"],
        oldSerialNumber: json["oldSerialNumber"],
        newSerialNumber: json["newSerialNumber"],
        quantity: json["quantity"],
        reason: json["reason"],
      );
}
