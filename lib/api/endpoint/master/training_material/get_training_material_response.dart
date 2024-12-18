import 'package:rtracker/api/endpoint/master/training_material/get_training_material_response_detail.dart';

class GetTrainingMaterialResponse {
  final List<GetTrainingMaterialResponseDetail> data;

  GetTrainingMaterialResponse({
    required this.data,
  });

  factory GetTrainingMaterialResponse.fromJson(Map<String, dynamic> json) {
    List<GetTrainingMaterialResponseDetail> getTrainingMaterialResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getTrainingMaterialResponseDetails.add(GetTrainingMaterialResponseDetail.fromJson(v));
      });
    }

    return GetTrainingMaterialResponse(
      data: getTrainingMaterialResponseDetails,
    );
  }
}
