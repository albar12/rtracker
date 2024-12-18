import 'package:rtracker/api/endpoint/master/sticker_bank/get_sticker_bank_response_detail.dart';

class GetStickerBankResponse {
  List<GetStickerBankResponseDetail> data;
  GetStickerBankResponse({
    required this.data,
  });

  factory GetStickerBankResponse.fromJson(Map<String, dynamic> json) {
    List<GetStickerBankResponseDetail> getStickerBankResponseDetail = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getStickerBankResponseDetail
            .add(GetStickerBankResponseDetail.fromJson(v));
      });
    }

    return GetStickerBankResponse(data: getStickerBankResponseDetail);
  }
}
