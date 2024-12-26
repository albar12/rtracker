class LoginResponse {
  LoginResponse({
    required this.sessionId,
    required this.name,
    required this.nik,
    required this.phone,
    required this.workingStartDate,
    required this.workingEndDate,
    required this.letterOfAssignmentPcs,
    required this.letterOfAssignmentMti,
    required this.photo,
    required this.merchantImageAllowGallery,
    required this.machineImageAllowGallery,
    required this.machineSerialNumberPhotoAllowGallery,
    required this.transactionTestImageAllowGallery,
    required this.qrisReceiptImageAllowGallery,
    required this.brizziInstallmentReceiptImageAllowGallery,
    this.checkVersionInterval,
    this.sendLocationInterval,
    this.sendJobOrderInterval,
    this.pauseMax,
    this.webPortalUrl,
    required this.picMerchantImagesAllowGallery,
    required this.rollSalesDraftImagesAllowGallery,
    required this.trainingStatementLetterImagesAllowGallery,
    required this.edcAppImagesAllowGallery,
    required this.otherImagesAllowGallery,
  });

  final String sessionId;
  final String name;
  final String nik;
  final String phone;
  final DateTime workingStartDate;
  final DateTime workingEndDate;
  final String letterOfAssignmentPcs;
  final String letterOfAssignmentMti;
  final String photo;
  final bool merchantImageAllowGallery;
  final bool machineImageAllowGallery;
  final bool machineSerialNumberPhotoAllowGallery;
  final bool transactionTestImageAllowGallery;
  final bool qrisReceiptImageAllowGallery;
  final bool brizziInstallmentReceiptImageAllowGallery;
  final int? checkVersionInterval;
  final int? sendLocationInterval;
  final int? sendJobOrderInterval;
  final int? pauseMax;
  final String? webPortalUrl;
  final bool picMerchantImagesAllowGallery;
  final bool rollSalesDraftImagesAllowGallery;
  final bool trainingStatementLetterImagesAllowGallery;
  final bool edcAppImagesAllowGallery;
  final bool otherImagesAllowGallery;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    sessionId: json["sessionId"] ?? '',
    name: json["name"] ?? '',
    nik: json["nik"] ?? '',
    phone: json["phone"] ?? '',
    workingStartDate: json["workingStartDate"] != null
        ? DateTime.parse(json["workingStartDate"])
        : DateTime.now(),
    workingEndDate: json["workingEndDate"] != null
        ? DateTime.parse(json["workingEndDate"])
        : DateTime.now(),
    letterOfAssignmentPcs: json["letterOfAssignmentPCS"] ?? '',
    letterOfAssignmentMti: json["letterOfAssignmentMTI"] ?? '',
    photo: json["photo"] ?? '',
    merchantImageAllowGallery: json["merchantImageAllowGallery"] ?? false,
    machineImageAllowGallery: json["machineImageAllowGallery"] ?? false,
    machineSerialNumberPhotoAllowGallery:
    json["machineSerialNumberPhotoAllowGallery"] ?? false,
    transactionTestImageAllowGallery:
    json["transactionTestImageAllowGallery"] ?? false,
    qrisReceiptImageAllowGallery:
    json["qrisReceiptImageAllowGallery"] ?? false,
    brizziInstallmentReceiptImageAllowGallery:
    json["brizziInstallmentReceiptImageAllowGallery"] ?? false,
    checkVersionInterval: json["checkVersionInterval"],
    sendLocationInterval: json["sendLocationInterval"],
    sendJobOrderInterval: json["sendJobOrderInterval"],
    pauseMax: json["pauseMax"],
    webPortalUrl: json["webPortalUrl"],
    picMerchantImagesAllowGallery:
    json["picMerchantImagesAllowGallery"] ?? false,
    rollSalesDraftImagesAllowGallery:
    json["rollSalesDraftImagesAllowGallery"] ?? false,
    trainingStatementLetterImagesAllowGallery:
    json["trainingStatementLetterImagesAllowGallery"] ?? false,
    edcAppImagesAllowGallery:
    json["edcAppImagesAllowGallery"] ?? false,
    otherImagesAllowGallery:
    json["otherImagesAllowGallery"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "sessionId": sessionId,
    "name": name,
    "nik": nik,
    "phone": phone,
    "workingStartDate":
    "${workingStartDate.year.toString().padLeft(4, '0')}-${workingStartDate.month.toString().padLeft(2, '0')}-${workingStartDate.day.toString().padLeft(2, '0')}",
    "workingEndDate":
    "${workingEndDate.year.toString().padLeft(4, '0')}-${workingEndDate.month.toString().padLeft(2, '0')}-${workingEndDate.day.toString().padLeft(2, '0')}",
    "letterOfAssignmentPCS": letterOfAssignmentPcs,
    "letterOfAssignmentMTI": letterOfAssignmentMti,
    "photo": photo,
    "merchantImageAllowGallery": merchantImageAllowGallery,
    "machineImageAllowGallery": machineImageAllowGallery,
    "machineSerialNumberPhotoAllowGallery":
    machineSerialNumberPhotoAllowGallery,
    "transactionTestImageAllowGallery": transactionTestImageAllowGallery,
    "qrisReceiptImageAllowGallery": qrisReceiptImageAllowGallery,
    "brizziInstallmentReceiptImageAllowGallery":
    brizziInstallmentReceiptImageAllowGallery,
    "checkVersionInterval": checkVersionInterval,
    "sendLocationInterval": sendLocationInterval,
    "sendJobOrderInterval": sendJobOrderInterval,
    "pauseMax": pauseMax,
    "webPortalUrl": webPortalUrl,
    "picMerchantImagesAllowGallery": picMerchantImagesAllowGallery,
    "rollSalesDraftImagesAllowGallery": rollSalesDraftImagesAllowGallery,
    "trainingStatementLetterImagesAllowGallery": trainingStatementLetterImagesAllowGallery,
    "edcAppImagesAllowGallery": edcAppImagesAllowGallery,
    "otherImagesAllowGallery": otherImagesAllowGallery,
  };
}
