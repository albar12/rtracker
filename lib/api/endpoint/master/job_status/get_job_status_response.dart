import 'package:rtracker/api/endpoint/master/job_status/get_job_status_response_detail.dart';

class GetJobStatusResponse {
  final List<GetJobStatusResponseDetail> data;

  GetJobStatusResponse({
    required this.data,
  });

  factory GetJobStatusResponse.fromJson(Map<String, dynamic> json) {
    List<GetJobStatusResponseDetail> getJobStatusResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getJobStatusResponseDetails.add(GetJobStatusResponseDetail.fromJson(v));
      });
    }

    return GetJobStatusResponse(data: getJobStatusResponseDetails);
  }
}
