import 'package:rtracker/helper/formats.dart';

class SendJobOrderStatus {
  final String? id;
  final String? categoryId;
  final DateTime? newVisitDate;

  SendJobOrderStatus({
    this.id,
    this.categoryId,
    this.newVisitDate,
  });

  Map<String, dynamic> toJson() => {"id": id, "categoryId": categoryId, "newVisitDate": Formats.isoDate(newVisitDate)};
}
