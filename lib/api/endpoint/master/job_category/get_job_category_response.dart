import 'package:rtracker/api/endpoint/master/job_category/get_job_category_response_detail.dart';

class GetJobCategoryResponse {
  final List<GetJobCategoryResponseDetail> data;

  GetJobCategoryResponse({
    required this.data,
  });

  factory GetJobCategoryResponse.fromJson(Map<String, dynamic> json) {
    List<GetJobCategoryResponseDetail> getJobCategoryResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getJobCategoryResponseDetails.add(GetJobCategoryResponseDetail.fromJson(v));
      });
    }

    return GetJobCategoryResponse(data: getJobCategoryResponseDetails);
  }
}
