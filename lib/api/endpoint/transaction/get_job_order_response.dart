import 'package:rtracker/api/endpoint/transaction/get_job_order_response_deleted.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_response_detail.dart';

class GetJobOrderResponse {
  final List<GetJobOrderResponseDetail> data;
  final List<GetJobOrderResponseDeleted> deleted;

  GetJobOrderResponse({
    required this.data,
    required this.deleted,
  });

  factory GetJobOrderResponse.fromJson(Map<String, dynamic> json) {
    List<GetJobOrderResponseDetail> getJobOrderResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getJobOrderResponseDetails.add(GetJobOrderResponseDetail.fromJson(v));
      });
    }

    List<GetJobOrderResponseDeleted> getJobOrderResponseDeleteds = [];

    if (json["deleted"] != null) {
      json["deleted"].forEach((v) {
        getJobOrderResponseDeleteds.add(GetJobOrderResponseDeleted.fromJson(v));
      });
    }

    return GetJobOrderResponse(
      data: getJobOrderResponseDetails,
      deleted: getJobOrderResponseDeleteds,
    );
  }
}
