import 'package:rtracker/api/endpoint/sn_stock_portal/sn_stock_portal_response_detail.dart';

class SnStockPortalResponse {
  final List<SnStockPortalResponseDetail> data;

  SnStockPortalResponse({
    required this.data,
  });

  factory SnStockPortalResponse.fromJson(Map<String, dynamic> json) {
    List<SnStockPortalResponseDetail> snStockPortalResponseDetail = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        snStockPortalResponseDetail.add(SnStockPortalResponseDetail.fromJson(v));
      });
    }

    return SnStockPortalResponse(data: snStockPortalResponseDetail);
  }
}
