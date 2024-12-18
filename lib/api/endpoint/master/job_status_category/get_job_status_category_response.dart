import 'package:rtracker/api/endpoint/master/job_status_category/get_job_status_category_response_detail.dart';

class GetJobStatusCategoryResponse {
  final List<GetJobStatusCategoryResponseDetail> data;

  GetJobStatusCategoryResponse({
    required this.data,
  });

  factory GetJobStatusCategoryResponse.fromJson(Map<String, dynamic> json) {
    List<GetJobStatusCategoryResponseDetail> getJobStatusCategoryResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getJobStatusCategoryResponseDetails.add(GetJobStatusCategoryResponseDetail.fromJson(v));
      });
    }

    return GetJobStatusCategoryResponse(
      data: getJobStatusCategoryResponseDetails,
    );
  }
}
