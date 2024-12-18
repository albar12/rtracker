import 'package:realm/realm.dart';

part 'schemas.g.dart';

@RealmModel()
class _Inbox {
  @PrimaryKey()
  late String id;
  late String title;
  late String body;
  late DateTime date;
  late bool read;
  late bool sent;
  late int version;
}

@RealmModel()
class _ImageFile {
  late List<int> file;
}

@RealmModel()
class _Version {
  @PrimaryKey()
  late String key;
  late int value;
}

@RealmModel()
class _Vendor {
  @PrimaryKey()
  late String id;
  late String name;
  late int version;
}

@RealmModel()
class _BaseOffice {
  @PrimaryKey()
  late String id;
  late String name;
  late int version;
}

@RealmModel()
class _ServicePoint {
  @PrimaryKey()
  late String id;
  late String vendorId;
  late String baseOfficeId;
  late String name;
  late int version;
}

@RealmModel()
class _JobType {
  late String id;
  late String vendorId;
  late String name;
  late String description;
  late int version;
}

@RealmModel()
class _DocumentStatus {
  @PrimaryKey()
  late String id;
  late String name;
  late int version;
}

@RealmModel()
class _RequestType {
  @PrimaryKey()
  late String id;
  late String name;
  late int version;
}

@RealmModel()
class _MmsStatus {
  @PrimaryKey()
  late String id;
  late String name;
  late int version;
}

@RealmModel()
class _Provider {
  @PrimaryKey()
  late String id;
  late String vendorId;
  late String name;
  late int version;
}

@RealmModel()
class _EdcType {
  @PrimaryKey()
  late String id;
  late String vendorId;
  late String name;
  late int version;
}

@RealmModel()
class _AppVersion {
  @PrimaryKey()
  late int id_primary;
  late int id_versi_aplikasi;
  late String versi_aplikasi;
  late int id_tipe_edc;
  late int android;
  late int vendor_id;
  late int version;
}

@RealmModel()
class _OsPatch {
  @PrimaryKey()
  late int id_os_patch;
  late String os_patch_name;
  late int id_versi_aplikasi;
  late int id_tipe_edc;
  late int vendor_id;
  late int version;
}

@RealmModel()
class _StickerBank {
  @PrimaryKey()
  late int idx;
  late String nama_sticker_bank;
  late int vendor_id;
  late int version;
}

@RealmModel()
class _EdcCommunicationType {
  @PrimaryKey()
  late String id;
  late String name;
  late int version;
}

@RealmModel()
class _ReplacementType {
  @PrimaryKey()
  late String id;
  late String name;
  late int version;
}

@RealmModel()
class _JobStatus {
  late String id;
  late String aliasId;
  late String vendorId;
  late String name;
  late int version;
}

@RealmModel()
class _JobStatusCategory {
  @PrimaryKey()
  late String id;
  late String jobStatusId;
  late String jobStatusAliasId;
  late String vendorId;
  late String? jobTypeId;
  late String name;
  late int version;
}

@RealmModel()
class _Note {
  @PrimaryKey()
  late String id;
  late String name;
  late int version;
}

@RealmModel()
class _QrisMenu {
  @PrimaryKey()
  late String id;
  late String name;
  late int version;
}

@RealmModel()
class _EdcEquipment {
  @PrimaryKey()
  late String name;
  late String vendorId;
}

@RealmModel()
class _EdcFeatureTestCase {
  @PrimaryKey()
  late String id;
  late String name;
  late String type;
  late int version;
}

@RealmModel()
class _JobCategory {
  @PrimaryKey()
  late String id;
  late String vendorId;
  late String name;
  late int version;
}

@RealmModel()
class _TransactionTestCase {
  @PrimaryKey()
  late String id;
  late String jobTypeId;
  late String name;
  late String amount;
  late int version;
}

@RealmModel()
class _OtherBankEdc {
  @PrimaryKey()
  late String id;
  late String name;
  late int version;
}

@RealmModel()
class _DorMenu {
  @PrimaryKey()
  late String id;
  late String name;
  late int version;
}

@RealmModel()
class _MarcollUpdateStatus {
  @PrimaryKey()
  late String id;
  late String name;
  late int version;
}

@RealmModel()
class _EosUpdateStatus {
  @PrimaryKey()
  late String id;
  late String name;
  late int version;
}

@RealmModel()
class _TrainingMaterial {
  @PrimaryKey()
  late String id;
  late String name;
  late int version;
}

@RealmModel()
class _DamageType {
  @PrimaryKey()
  late String id;
  late String name;
  late int version;
}

@RealmModel()
class _SnStock {
  late String serialNumber;
  late String category;
  late String productId;
  late String productName;
  late String servicePointId;
  late String servicePointName;
  late bool used;
}

@RealmModel()
class _NonSnStock {
  late String id;
  late String servicePointId;
  late String servicePointName;
  late String category;
  late String productName;
  late int quantity;
}

@RealmModel()
class _JobOrderDocumentStatus {
  late String id;
  late String name;
}

@RealmModel()
class _JobOrderDamageType {
  late String id;
  late String name;
}

@RealmModel()
class _JobOrderBaseOffice {
  late String id;
  late String name;
}

@RealmModel()
class _JobOrderServicePoint {
  late String id;
  late String name;
}

@RealmModel()
class _JobOrderJobType {
  late String id;
  late String name;
}

@RealmModel()
class _JobOrderTiming {
  late DateTime? departure;
  late String? departureCoordinate;
  late DateTime? visit;
  late String? visitCoordinate;
  late DateTime? start;
  late String? startCoordinate;
  late DateTime? pause;
  late String? pauseCoordinate;
  late DateTime? finish;
  late String? finishCoordinate;
}

@RealmModel()
class _JobOrderStatus {
  late String? id;
  late String? name;
  late String? categoryId;
  late String? categoryName;
  late DateTime? newVisitDate;
}

@RealmModel()
class _JobOrderRequestType {
  late String id;
  late String name;
}

@RealmModel()
class _JobOrderMerchant {
  late String id;
  late String name;
  late String shortName;
  late String city;
  late String address;
  late String phoneNumber;
  late String assignedPicName;
  late String? picName;
  late String? picPhoneNumber;
  late int invoiceCount;
  late String? note;
  late _ImageFile? signature;
  late List<_ImageFile> images;
}

@RealmModel()
class _JobOrderProvider {
  late String id;
  late String name;
}

@RealmModel()
class _JobOrderEdcType {
  late String id;
  late String name;
  late String flag_android;
}

@RealmModel()
class _JobOrderEdcCommunicationType {
  late String id;
  late String name;
}

@RealmModel()
class _JobOrderMachineAndCard {
  late String? simCard;
  late _JobOrderProvider? provider;
  late String? sam;
  late String? sam2;
  late String? sam3;
  late String? sam4;
  late String? sam5;
  late String? sam6;
  late String? sam7;
  late _JobOrderEdcType? edcType;
  late _JobOrderEdcCommunicationType? edcCommunicationType;
  late List<_ImageFile> images;
  late List<_ImageFile> serialNumberPhotos;
}

@RealmModel()
class _JobOrderReplacementType {
  late String id;
  late String name;
}

@RealmModel()
class _JobOrderReplacement {
  late _JobOrderReplacementType? type;
  late String category;
  late String productId;
  late String name;
  late String oldSerialNumber;
  late String newSerialNumber;
  late int quantity;
  late String reason;
}

@RealmModel()
class _JobOrderInputPeripheral {
  late String id;
  late String servicePoint;
  late String category;
  late String productName;
  late int quantity;
}

@RealmModel()
class _JobOrderNote {
  late String id;
  late String name;
  late bool value;
}

@RealmModel()
class _JobOrderQrisMenu {
  late String id;
  late String name;
  late bool value;
}

@RealmModel()
class _JobOrderQris {
  late bool exist;
  late bool testResult;
  late List<_JobOrderQrisMenu> menus;
  late List<_ImageFile> qrisReceiptImages;
  late List<_ImageFile> brizziInstallmentReceiptImages;
}

@RealmModel()
class _JobOrderEdcEquipment {
  late String name;
  late int quantity;
}

@RealmModel()
class _JobOrderEdcFeatureTestCase {
  late String id;
  late String name;
  late String? type;
  late bool value;
}

@RealmModel()
class _JobOrderJobCategory {
  late String id;
  late String name;
  late bool value;
}

@RealmModel()
class _JobOrderTransactionTestCase {
  late String id;
  late String name;
  late String amount;
  late bool value;
}

@RealmModel()
class _JobOrderTransactionTest {
  late DateTime? date;
  late List<_JobOrderTransactionTestCase> cases;
  late List<_ImageFile> images;
}

@RealmModel()
class _JobOrderOtherBankEdc {
  late String id;
  late String name;
  late bool value;
}

@RealmModel()
class _JobOrderDorMenu {
  late String id;
  late String name;
}

@RealmModel()
class _JobOrderMarcollUpdateStatus {
  late String id;
  late String name;
}

@RealmModel()
class _JobOrderEosUpdateStatus {
  late String id;
  late String name;
}

@RealmModel()
class _JobOrderAppVersion {
  late String id;
  late String name;
  late String id_tipe_edc;
}

@RealmModel()
class _JobOrderOsPatch {
  late String id;
  late String name;
}

@RealmModel()
class _JobOrderStickerBank {
  late String id;
  late String name;
}

@RealmModel()
class _JobOrderCleaningEdc {
  late String id;
  late String name;
}

@RealmModel()
class _JobOrderEdcUpdate {
  late _JobOrderDorMenu? dorMenu;
  late _JobOrderMarcollUpdateStatus? marcollUpdateStatus;
  late _JobOrderEosUpdateStatus? eosUpdateStatus;
  late _JobOrderAppVersion? appVersion;
  late _JobOrderOsPatch? osPatch;
  late _JobOrderStickerBank? stickerBank;
  late _JobOrderCleaningEdc? cleaningEdc;
}

@RealmModel()
class _JobOrderTrainingMaterial {
  late String id;
  late String name;
  late bool value;
}

@RealmModel()
class _JobOrder {
  @PrimaryKey()
  late String id;
  late String? parentId;
  late String? vendorId;
  late String? caseId;
  late String? mid;
  late String? tid;
  late String? poi;
  late String? iccid;
  late String? msisdn;
  late String? provider;
  late String? simCard;
  late String? sam;
  late String? sam2;
  late String? sam3;
  late String? sam4;
  late String? sam5;
  late String? sam6;
  late String? sam7;
  late String? cmRemark;
  late String? serialNumber;
  late DateTime? receivedDate;
  late DateTime? uploadDate;
  late DateTime? visitDate;
  late DateTime? endSla;
  late String? description;
  late String? requiredThermalCount;
  late String? scannedSerialNumber;
  late bool machineConditionNormal;
  late String serialNumberMandatoryType;
  late String serialNumberValidationType;
  late String serialNumberMaxDigit;
  late String imageMandatoryType;
  late _JobOrderDocumentStatus? documentStatus;
  late _JobOrderDamageType? damageType;
  late _JobOrderBaseOffice? baseOffice;
  late _JobOrderServicePoint? servicePoint;
  late _JobOrderJobType? jobType;
  late _JobOrderTiming? timing;
  late _JobOrderStatus? status;
  late _JobOrderRequestType? requestType;
  late _JobOrderMerchant? merchant;
  late _JobOrderMachineAndCard? machineAndCard;
  late List<_JobOrderReplacement> replacements;
  late List<_JobOrderInputPeripheral> inputPeripherals;
  late List<_JobOrderNote> notes;
  late _JobOrderQris? qris;
  late List<_JobOrderEdcEquipment> edcEquipments;
  late List<_JobOrderEdcFeatureTestCase> edcFeatureTestCases;
  late List<_JobOrderJobCategory> jobCategories;
  late _JobOrderTransactionTest? transactionTest;
  late List<_JobOrderOtherBankEdc> otherBankEdcs;
  late _JobOrderEdcUpdate? edcUpdate;
  late List<_JobOrderTrainingMaterial> trainingMaterials;
  late int version;
  late bool sent;
  late bool synced;
  late String? latitude;
  late String? longitude;
  late String? jamBukaToko;
  late String? jamTutupToko;
}
