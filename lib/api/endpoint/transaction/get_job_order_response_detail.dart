import 'package:rtracker/api/endpoint/transaction/get_job_order_base_office.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_damage_type.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_document_status.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_edc_feature_test_case.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_edc_update.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_input_peripheral.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_job_category.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_job_type.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_machine_and_card.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_merchant.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_note.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_other_bank_edc.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_qris.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_replacement.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_request_type.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_service_point.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_status.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_timing.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_training_material.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_transaction_test.dart';
import 'package:rtracker/helper/extensions.dart';

class GetJobOrderResponseDetail {
  final String id;
  final String? parentId;
  final String? vendorId;
  final String? caseId;
  final String? mid;
  final String? tid;
  final String? poi;
  final String? iccid;
  final String? msisdn;
  final String? provider;
  final String? simCard;
  final String? cmRemark;
  final String? serialNumber;
  final String? sam;
  final String? sam2;
  final String? sam3;
  final String? sam4;
  final String? sam5;
  final String? sam6;
  final String? sam7;
  final DateTime? receivedDate;
  final DateTime? uploadDate;
  final DateTime? visitDate;
  final DateTime? endSla;
  final String? description;
  final String? requiredThermalCount;
  final String? scannedSerialNumber;
  final bool machineConditionNormal;
  final String serialNumberMandatoryType;
  final String serialNumberValidationType;
  final String serialNumberMaxDigit;
  final String imageMandatoryType;
  final GetJobOrderDocumentStatus? documentStatus;
  final GetJobOrderDamageType? damageType;
  final GetJobOrderBaseOffice? baseOffice;
  final GetJobOrderServicePoint? servicePoint;
  final GetJobOrderJobType? jobType;
  final GetJobOrderTiming? timing;
  final GetJobOrderStatus? status;
  final GetJobOrderRequestType? requestType;
  final GetJobOrderMerchant? merchant;
  final GetJobOrderMachineAndCard? machineAndCard;
  final List<GetJobOrderReplacement> replacements;
  final List<GetJobOrderInputPeripheral> inputPeripherals;
  final List<GetJobOrderNote> notes;
  final GetJobOrderQris? qris;
  final Map<String, dynamic> edcEquipments;
  final List<GetJobOrderEdcFeatureTestCase> edcFeatureTestCases;
  final List<GetJobOrderJobCategory> jobCategories;
  final GetJobOrderTransactionTest? transactionTest;
  final List<GetJobOrderOtherBankEdc> otherBankEdcs;
  final GetJobOrderEdcUpdate? edcUpdate;
  final List<GetJobOrderTrainingMaterial> trainingMaterials;
  final int version;
  final String? latitude;
  final String? longitude;
  final String? jamBukaToko;
  final String? jamTutupToko;
  final int? edcCount;

  GetJobOrderResponseDetail({
    required this.id,
    required this.parentId,
    required this.vendorId,
    required this.caseId,
    required this.mid,
    required this.tid,
    required this.poi,
    required this.iccid,
    required this.msisdn,
    required this.provider,
    required this.simCard,
    this.sam,
    this.sam2,
    this.sam3,
    this.sam4,
    this.sam5,
    this.sam6,
    this.sam7,
    required this.cmRemark,
    required this.serialNumber,
    required this.receivedDate,
    required this.uploadDate,
    required this.visitDate,
    required this.endSla,
    required this.description,
    required this.requiredThermalCount,
    required this.scannedSerialNumber,
    required this.machineConditionNormal,
    required this.serialNumberMandatoryType,
    required this.serialNumberValidationType,
    required this.serialNumberMaxDigit,
    required this.imageMandatoryType,
    required this.documentStatus,
    required this.damageType,
    required this.baseOffice,
    required this.servicePoint,
    required this.jobType,
    required this.timing,
    required this.status,
    required this.requestType,
    required this.merchant,
    required this.machineAndCard,
    required this.replacements,
    required this.inputPeripherals,
    required this.notes,
    required this.qris,
    required this.edcEquipments,
    required this.edcFeatureTestCases,
    required this.jobCategories,
    required this.transactionTest,
    required this.otherBankEdcs,
    required this.edcUpdate,
    required this.trainingMaterials,
    required this.version,
    this.latitude,
    this.longitude,
    this.jamBukaToko,
    this.jamTutupToko,
    this.edcCount,
  });

  factory GetJobOrderResponseDetail.fromJson(Map<String, dynamic> json) =>
      GetJobOrderResponseDetail(
        id: json["id"] ?? '',
        parentId: json["parentId"],
        vendorId: json["vendorId"],
        caseId: json["caseId"],
        mid: json["mid"],
        tid: json["tid"],
        poi: json["poi"],
        iccid: json["iccid"],
        msisdn: json["msisdn"],
        provider: json["provider"],
        simCard: json["simCard"],
        sam: json["sam"],
        sam2: json["sam2"],
        sam3: json["sam3"],
        sam4: json["sam4"],
        sam5: json["sam5"],
        sam6: json["sam6"],
        sam7: json["sam7"],
        cmRemark: json["cmRemark"],
        serialNumber: json["serialNumber"],
        receivedDate: DateTime.tryParse(json["receivedDate"] ?? ''),
        uploadDate: DateTime.tryParse(json["uploadDate"] ?? ''),
        visitDate: DateTime.tryParse(json["visitDate"] ?? ''),
        endSla: DateTime.tryParse(json["endSla"] ?? ''),
        description: json["description"],
        requiredThermalCount: json["requiredThermalCount"],
        scannedSerialNumber: json["scannedSerialNumber"],
        machineConditionNormal:
            json["machineConditionNormal"].toString().parseBool(),
        serialNumberMandatoryType:
            json["serialNumberMandatoryType"] ?? "111111111",
        serialNumberValidationType:
            json["serialNumberValidationType"] ?? "000000000",
        serialNumberMaxDigit:
            json["serialNumberMaxDigit"] ?? "10-10-8-8-8-8-8-8-8",
        imageMandatoryType: json["imageMandatoryType"] ?? "1111111",
        documentStatus: json["documentStatus"] != null
            ? GetJobOrderDocumentStatus.fromJson(json["documentStatus"])
            : null,
        damageType: json["damageType"] != null
            ? GetJobOrderDamageType.fromJson(json["damageType"])
            : null,
        baseOffice: json["baseOffice"] != null
            ? GetJobOrderBaseOffice.fromJson(json["baseOffice"])
            : null,
        servicePoint: json["servicePoint"] != null
            ? GetJobOrderServicePoint.fromJson(json["servicePoint"])
            : null,
        jobType: json["jobType"] != null
            ? GetJobOrderJobType.fromJson(json["jobType"])
            : null,
        timing: json["timing"] != null
            ? GetJobOrderTiming.fromJson(json["timing"])
            : null,
        status: json["status"] != null
            ? GetJobOrderStatus.fromJson(json["status"])
            : null,
        requestType: json["requestType"] != null
            ? GetJobOrderRequestType.fromJson(json["requestType"])
            : null,
        merchant: json["merchant"] != null
            ? GetJobOrderMerchant.fromJson(json["merchant"])
            : null,
        machineAndCard: json["machineAndCard"] != null
            ? GetJobOrderMachineAndCard.fromJson(json["machineAndCard"])
            : null,
        replacements: json["replacements"] != null
            ? List<GetJobOrderReplacement>.from(
                json["replacements"]
                    .map((x) => GetJobOrderReplacement.fromJson(x)),
              )
            : [],
        inputPeripherals: json["inputPeripherals"] != null
            ? List<GetJobOrderInputPeripheral>.from(
                json["inputPeripherals"]
                    .map((x) => GetJobOrderInputPeripheral.fromJson(x)),
              )
            : [],
        notes: json["notes"] != null
            ? List<GetJobOrderNote>.from(
                json["notes"].map((x) => GetJobOrderNote.fromJson(x)),
              )
            : [],
        qris: json["qris"] != null
            ? GetJobOrderQris.fromJson(json["qris"])
            : null,
        edcEquipments: json["edcEquipments"] ?? {},
        edcFeatureTestCases: json["edcFeatureTestCases"] != null
            ? List<GetJobOrderEdcFeatureTestCase>.from(
                json["edcFeatureTestCases"]
                    .map((x) => GetJobOrderEdcFeatureTestCase.fromJson(x)),
              )
            : [],
        jobCategories: json["jobCategories"] != null
            ? List<GetJobOrderJobCategory>.from(
                json["jobCategories"]
                    .map((x) => GetJobOrderJobCategory.fromJson(x)),
              )
            : [],
        transactionTest: json["transactionTest"] != null
            ? GetJobOrderTransactionTest.fromJson(json["transactionTest"])
            : null,
        otherBankEdcs: json["otherBankEdcs"] != null
            ? List<GetJobOrderOtherBankEdc>.from(
                json["otherBankEdcs"]
                    .map((x) => GetJobOrderOtherBankEdc.fromJson(x)),
              )
            : [],
        edcUpdate: json["edcUpdate"] != null
            ? GetJobOrderEdcUpdate.fromJson(json["edcUpdate"])
            : null,
        trainingMaterials: json["trainingMaterials"] != null
            ? List<GetJobOrderTrainingMaterial>.from(
                json["trainingMaterials"]
                    .map((x) => GetJobOrderTrainingMaterial.fromJson(x)),
              )
            : [],
        version: json["version"] ?? 0,
        latitude: json["latitude"],
        longitude: json["longitude"],
        jamBukaToko: json["jamBukaToko"],
        jamTutupToko: json["jamTutupToko"],
        edcCount: json["edcCount"],
      );
}
