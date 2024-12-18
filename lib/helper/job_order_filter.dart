import 'package:basic_utils/basic_utils.dart';
import 'package:rtracker/helper/formats.dart';

class JobOrderFilter {
  String? vendorId;
  String? baseOfficeId;
  String? servicePointId;
  String? jobTypeId;
  String? caseId;
  String? mid;
  String? tid;
  String? merchantName;
  DateTime? receivedDate;
  String? documentStatusId;
  String? sortBy;

  JobOrderFilter({
    this.vendorId,
    this.baseOfficeId,
    this.servicePointId,
    this.jobTypeId,
    this.caseId,
    this.mid,
    this.tid,
    this.merchantName,
    this.receivedDate,
    this.documentStatusId,
    this.sortBy,
  });

  void clear() {
    vendorId = null;
    baseOfficeId = null;
    servicePointId = null;
    jobTypeId = null;
    caseId = null;
    mid = null;
    tid = null;
    merchantName = null;
    receivedDate = null;
    documentStatusId = null;
  }

  int count() {
    List<dynamic> values = [
      vendorId,
      baseOfficeId,
      servicePointId,
      jobTypeId,
      caseId,
      mid,
      tid,
      merchantName,
      receivedDate,
      documentStatusId
    ];

    int count = 0;

    for (var value in values) {
      if (value != null) {
        if (value is String) {
          if (StringUtils.isNotNullOrEmpty(value)) {
            count++;
          }
        } else {
          if (value != null) {
            count++;
          }
        }
      }
    }

    return count;
  }

  factory JobOrderFilter.fromJson(Map<String, dynamic> json) => JobOrderFilter(
        vendorId: json["vendorId"],
        baseOfficeId: json["baseOfficeId"],
        servicePointId: json["servicePointId"],
        jobTypeId: json["jobTypeId"],
        caseId: json["caseId"],
        mid: json["mid"],
        tid: json["tid"],
        merchantName: json["merchantName"],
        receivedDate: DateTime.tryParse(json["receivedDate"] ?? ""),
        documentStatusId: json["documentStatusId"],
        sortBy: json["sortBy"],
      );

  Map<String, dynamic> toJson() => {
        "vendorId": vendorId,
        "baseOfficeId": baseOfficeId,
        "servicePointId": servicePointId,
        "jobTypeId": jobTypeId,
        "caseId": caseId,
        "mid": mid,
        "tid": tid,
        "merchantName": merchantName,
        "receivedDate": Formats.isoDate(receivedDate),
        "documentStatusId": documentStatusId,
        "sortBy": sortBy
      };
}
