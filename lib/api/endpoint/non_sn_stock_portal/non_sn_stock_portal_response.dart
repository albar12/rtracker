import 'package:rtracker/api/endpoint/non_sn_stock_portal/non_sn_stock_portal_response_detail.dart';

class NonSnStockPortalResponse {
  final List<NonSnStockPortalResponseDetail> data;

  NonSnStockPortalResponse({
    required this.data,
  });

  factory NonSnStockPortalResponse.fromJson(Map<String, dynamic> json) {
    List<NonSnStockPortalResponseDetail> nonSnStockPortalResponseDetail = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        nonSnStockPortalResponseDetail.add(NonSnStockPortalResponseDetail.fromJson(v));
      });
    }

    return NonSnStockPortalResponse(data: nonSnStockPortalResponseDetail);
  }
}
