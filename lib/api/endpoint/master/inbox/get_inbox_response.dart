import 'package:rtracker/api/endpoint/master/inbox/get_inbox_response_deleted.dart';

import 'get_inbox_response_detail.dart';

class GetInboxResponse {
  final List<GetInboxResponseDetail> data;
  final List<GetInboxResponseDeleted> deleted;

  GetInboxResponse({
    required this.data,
    required this.deleted,
  });

  factory GetInboxResponse.fromJson(Map<String, dynamic> json) {
    List<GetInboxResponseDetail> getInboxResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getInboxResponseDetails.add(GetInboxResponseDetail.fromJson(v));
      });
    }

    List<GetInboxResponseDeleted> getInboxResponseDeleteds = [];

    if (json["deleted"] != null) {
      json["deleted"].forEach((v) {
        getInboxResponseDeleteds.add(GetInboxResponseDeleted.fromJson(v));
      });
    }

    return GetInboxResponse(
      data: getInboxResponseDetails,
      deleted: getInboxResponseDeleteds,
    );
  }
}
