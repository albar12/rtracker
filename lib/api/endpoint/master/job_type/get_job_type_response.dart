import 'package:rtracker/api/endpoint/master/job_type/get_job_type_response_detail.dart';

class GetJobTypeResponse {
  final List<GetJobTypeResponseDetail> data;

  GetJobTypeResponse({
    required this.data,
  });

  factory GetJobTypeResponse.fromJson(Map<String, dynamic> json) {
    List<GetJobTypeResponseDetail> getJobTypeResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getJobTypeResponseDetails.add(GetJobTypeResponseDetail.fromJson(v));
      });
    }

    return GetJobTypeResponse(data: getJobTypeResponseDetails);
  }
}
