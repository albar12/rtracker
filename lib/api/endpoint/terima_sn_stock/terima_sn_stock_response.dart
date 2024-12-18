import 'package:rtracker/api/endpoint/terima_sn_stock/terima_sn_stock_response_detail.dart';

class TerimaSnStockResponse {
  final List<TerimaSnStockResponseDetail> data;

  TerimaSnStockResponse({
    required this.data,
  });

  factory TerimaSnStockResponse.fromJson(Map<String, dynamic> json) {
    List<TerimaSnStockResponseDetail> terimaSnStockResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        terimaSnStockResponseDetails.add(TerimaSnStockResponseDetail.fromJson(v));
      });
    }

    return TerimaSnStockResponse(data: terimaSnStockResponseDetails);
  }
}
