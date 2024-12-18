import 'package:rtracker/api/endpoint/master/non_sn_stock/get_non_sn_stock_response_detail.dart';

class GetNonSnStockResponse {
  final int version;
  final List<GetNonSnStockResponseDetail> data;

  GetNonSnStockResponse({
    required this.version,
    required this.data,
  });

  factory GetNonSnStockResponse.fromJson(Map<String, dynamic> json) {
    List<GetNonSnStockResponseDetail> getNonSnStockResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getNonSnStockResponseDetails.add(GetNonSnStockResponseDetail.fromJson(v));
      });
    }

    return GetNonSnStockResponse(
      version: json["version"],
      data: getNonSnStockResponseDetails,
    );
  }
}
