import 'package:rtracker/api/endpoint/master/sn_stock/get_sn_stock_response_detail.dart';

class GetSnStockResponse {
  final int version;
  final List<GetSnStockResponseDetail> data;

  GetSnStockResponse({
    required this.version,
    required this.data,
  });

  factory GetSnStockResponse.fromJson(Map<String, dynamic> json) {
    List<GetSnStockResponseDetail> getSnStockResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getSnStockResponseDetails.add(GetSnStockResponseDetail.fromJson(v));
      });
    }

    return GetSnStockResponse(
      version: json["version"],
      data: getSnStockResponseDetails,
    );
  }
}
