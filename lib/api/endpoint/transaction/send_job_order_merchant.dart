class SendJobOrderMerchant {
  final String? picName;
  final String? picPhoneNumber;
  final int? invoiceCount;
  final String? note;

  SendJobOrderMerchant({
    this.picName,
    this.picPhoneNumber,
    this.invoiceCount,
    this.note,
  });

  Map<String, dynamic> toJson() => {"picName": picName, "picPhoneNumber": picPhoneNumber, "invoiceCount": invoiceCount, "note": note};
}
