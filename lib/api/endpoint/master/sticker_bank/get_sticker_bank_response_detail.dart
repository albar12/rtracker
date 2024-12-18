class GetStickerBankResponseDetail {
  int idx;
  String nama_sticker_bank;
  int vendor_id;
  int version;
  GetStickerBankResponseDetail({
    required this.idx,
    required this.nama_sticker_bank,
    required this.vendor_id,
    required this.version,
  });

  factory GetStickerBankResponseDetail.fromJson(Map<String, dynamic> json) {
    return GetStickerBankResponseDetail(
      idx: json['idx'],
      nama_sticker_bank: json['nama_sticker_bank'],
      vendor_id: json['Vendor_id'],
      version: json['version'],
    );
  }
}
