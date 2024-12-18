import 'package:rtracker/api/endpoint/terima_non_sn_stock/terima_non_sn_stock_response_detail.dart';

class TerimaNonSnStockResponse {
  final List<TerimaNonSnStockResponseDetail> data;

  TerimaNonSnStockResponse({
    required this.data,
  });

  factory TerimaNonSnStockResponse.fromJson(Map<String, dynamic> json) {
    List<TerimaNonSnStockResponseDetail> terimaNonSnStockResponseDetail = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        terimaNonSnStockResponseDetail.add(TerimaNonSnStockResponseDetail.fromJson(v));
      });
    }

    return TerimaNonSnStockResponse(data: terimaNonSnStockResponseDetail);
  }
}
