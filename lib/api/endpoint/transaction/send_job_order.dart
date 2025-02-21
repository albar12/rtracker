import 'package:rtracker/api/endpoint/transaction/send_bni_mti_edc_feature.dart';
import 'package:rtracker/api/endpoint/transaction/send_job_order_edc_feature_test_case.dart';
import 'package:rtracker/api/endpoint/transaction/send_job_order_edc_update.dart';
import 'package:rtracker/api/endpoint/transaction/send_job_order_input_peripheral.dart';
import 'package:rtracker/api/endpoint/transaction/send_job_order_job_category.dart';
import 'package:rtracker/api/endpoint/transaction/send_job_order_machine_and_card.dart';
import 'package:rtracker/api/endpoint/transaction/send_job_order_merchant.dart';
import 'package:rtracker/api/endpoint/transaction/send_job_order_note.dart';
import 'package:rtracker/api/endpoint/transaction/send_job_order_other_bank_edc.dart';
import 'package:rtracker/api/endpoint/transaction/send_job_order_qris.dart';
import 'package:rtracker/api/endpoint/transaction/send_job_order_qris_menu.dart';
import 'package:rtracker/api/endpoint/transaction/send_job_order_replacement.dart';
import 'package:rtracker/api/endpoint/transaction/send_job_order_status.dart';
import 'package:rtracker/api/endpoint/transaction/send_job_order_timing.dart';
import 'package:rtracker/api/endpoint/transaction/send_job_order_training_material.dart';
import 'package:rtracker/api/endpoint/transaction/send_job_order_transaction_test.dart';
import 'package:rtracker/api/endpoint/transaction/send_job_order_transaction_test_case.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/schemas.dart';

class SendJobOrder {
  final String id;
  final String? scannedSerialNumber;
  final bool machineConditionNormal;
  final String? damageTypeId;
  final String? documentStatusId;
  final String? poi;
  final SendJobOrderTiming? timing;
  final SendJobOrderStatus? status;
  final SendJobOrderMerchant? merchant;
  final SendJobOrderMachineAndCard? machineAndCard;
  final List<SendJobOrderReplacement> replacements;
  final List<SendJobOrderInputPeripheral> inputPeripherals;
  final List<SendJobOrderNote> notes;
  final SendJobOrderQris? qris;
  final Map<String, dynamic> edcEquipments;
  final List<SendJobOrderEdcFeatureTestCase> edcFeatureTestCases;
  final List<SendJobOrderJobCategory> jobCategories;
  final SendJobOrderTransactionTest? transactionTest;
  final List<SendJobOrderOtherBankEdc> otherBankEdcs;
  final SendJobOrderEdcUpdate? edcUpdate;
  final List<SendJobOrderTrainingMaterial> trainingMaterials;
  final String? jamBukaToko;
  final String? jamTutupToko;
  final int? edcCount;
  final String? edcCleaning;
  final String? edcProblem;
  final String? comLine;
  final String? settlement;
  final String? signalBar;
  final String? priorityEdc;
  final String? merchantComment;
  final String? mostUsedEdc;
  final String? otherEdc;
  final String? merchantRequest;
  final String? promoMaterial;
  final String? position;
  final List<SendBniMtiEdcFeature> edcBniMtiFeatures;
  final String? mostStableEdc;
  final String? mostGoodProviderInMerchantLocation;
  final String? otherBankEdcProvider;

  SendJobOrder(
      {required this.id,
      this.scannedSerialNumber,
      required this.machineConditionNormal,
      this.damageTypeId,
      this.documentStatusId,
      this.poi,
      this.timing,
      this.status,
      this.merchant,
      this.machineAndCard,
      required this.replacements,
      required this.inputPeripherals,
      required this.notes,
      this.qris,
      required this.edcEquipments,
      required this.edcFeatureTestCases,
      required this.jobCategories,
      this.transactionTest,
      required this.otherBankEdcs,
      this.edcUpdate,
      required this.trainingMaterials,
      this.jamBukaToko,
      this.jamTutupToko,
      this.edcCount,
      this.edcCleaning,
      this.edcProblem,
      this.comLine,
      this.settlement,
      this.signalBar,
      this.priorityEdc,
      this.merchantComment,
      this.mostUsedEdc,
      this.otherEdc,
      this.merchantRequest,
      this.promoMaterial,
      this.position,
      required this.edcBniMtiFeatures,
      this.mostStableEdc,
      this.mostGoodProviderInMerchantLocation,
      this.otherBankEdcProvider,});

  Map<String, dynamic> toJson() => {
    "id": id,
    "scannedSerialNumber": scannedSerialNumber,
    "machineConditionNormal": machineConditionNormal,
    "damageTypeId": damageTypeId,
    "documentStatusId": documentStatusId,
    "poi": poi,
    "timing": timing != null ? timing!.toJson() : null,
    "status": status != null ? status!.toJson() : null,
    "merchant": merchant != null ? merchant!.toJson() : null,
    "machineAndCard":
    machineAndCard != null ? machineAndCard!.toJson() : null,
    "replacements": List<dynamic>.from(replacements.map((x) => x.toJson())),
    "inputPeripherals":
    List<dynamic>.from(inputPeripherals.map((x) => x.toJson())),
    "notes": List<dynamic>.from(notes.map((x) => x.toJson())),
    "qris": qris != null ? qris!.toJson() : null,
    "edcEquipments": edcEquipments,
    "edcFeatureTestCases":
    List<dynamic>.from(edcFeatureTestCases.map((x) => x.toJson())),
    "jobCategories":
    List<dynamic>.from(jobCategories.map((x) => x.toJson())),
    "transactionTest":
    transactionTest != null ? transactionTest!.toJson() : null,
    "otherBankEdcs":
    List<dynamic>.from(otherBankEdcs.map((x) => x.toJson())),
    "edcUpdate": edcUpdate != null ? edcUpdate!.toJson() : null,
    "trainingMaterials":
    List<dynamic>.from(trainingMaterials.map((x) => x.toJson())),
    "jamBukaToko": jamBukaToko,
    "jamTutupToko": jamTutupToko,
    "edcCount": edcCount,
    "edcCleaning": edcCleaning,
    "edcProblem": edcProblem,
    "comLine": comLine,
    "settlement": settlement,
    "signalBar": signalBar,
    "priorityEdc": priorityEdc,
    "merchantComment": merchantComment,
    "mostUsedEdc": mostUsedEdc,
    "otherEdc": otherEdc,
    "merchantRequest": merchantRequest,
    "promoMaterial": promoMaterial,
    "position": position,
    "edcBniMtiFeatures": List<dynamic>.from(edcBniMtiFeatures.map((x) => x.toJson())),
    "mostStableEdc": mostStableEdc,
    "mostGoodProviderInMerchantLocation": mostGoodProviderInMerchantLocation,
    "otherBankEdcProvider": otherBankEdcProvider,
  };

  static SendJobOrder build(JobOrder jobOrder) {
    SendJobOrderTiming? sendJobOrderTiming;

    if (jobOrder.timing != null) {
      sendJobOrderTiming = SendJobOrderTiming(
        departure: jobOrder.timing!.departure,
        departureCoordinate: jobOrder.timing!.departureCoordinate,
        visit: jobOrder.timing!.visit,
        visitCoordinate: jobOrder.timing!.visitCoordinate,
        start: jobOrder.timing!.start,
        startCoordinate: jobOrder.timing!.startCoordinate,
        pause: jobOrder.timing!.pause,
        pauseCoordinate: jobOrder.timing!.pauseCoordinate,
        finish: jobOrder.timing!.finish,
        finishCoordinate: jobOrder.timing!.finishCoordinate,
      );
    }

    SendJobOrderStatus? sendJobOrderStatus;

    if (jobOrder.status != null) {
      sendJobOrderStatus = SendJobOrderStatus(
        id: jobOrder.status!.id,
        categoryId: jobOrder.status!.categoryId,
        newVisitDate: jobOrder.status!.newVisitDate,
      );
    }

    SendJobOrderMerchant? sendJobOrderMerchant;

    if (jobOrder.merchant != null) {
      sendJobOrderMerchant = SendJobOrderMerchant(
        picName: jobOrder.merchant!.picName,
        picPhoneNumber: jobOrder.merchant!.picPhoneNumber,
        invoiceCount: jobOrder.merchant!.invoiceCount,
        note: jobOrder.merchant!.note,
      );
    }

    SendJobOrderMachineAndCard? sendJobOrderMachineAndCard;

    if (jobOrder.machineAndCard != null) {
      String? providerId;

      if (jobOrder.machineAndCard!.provider != null) {
        providerId = jobOrder.machineAndCard!.provider!.id;
      }

      String? edcTypeId;

      if (jobOrder.machineAndCard!.edcType != null) {
        edcTypeId = jobOrder.machineAndCard!.edcType!.id;
      }

      String? edcCommunicationTypeId;

      if (jobOrder.machineAndCard!.edcCommunicationType != null) {
        edcCommunicationTypeId =
            jobOrder.machineAndCard!.edcCommunicationType!.id;
      }

      sendJobOrderMachineAndCard = SendJobOrderMachineAndCard(
        simCard: jobOrder.machineAndCard!.simCard,
        providerId: providerId,
        sam: jobOrder.machineAndCard!.sam,
        sam2: jobOrder.machineAndCard!.sam2,
        sam3: jobOrder.machineAndCard!.sam3,
        sam4: jobOrder.machineAndCard!.sam4,
        sam5: jobOrder.machineAndCard!.sam5,
        sam6: jobOrder.machineAndCard!.sam6,
        sam7: jobOrder.machineAndCard!.sam7,
        edcTypeId: edcTypeId,
        edcCommunicationTypeId: edcCommunicationTypeId,
      );
    }

    List<SendJobOrderReplacement> replacements = [];

    for (JobOrderReplacement jobOrderReplacement in jobOrder.replacements) {
      String? typeId;

      if (jobOrderReplacement.type != null) {
        typeId = jobOrderReplacement.type!.id;
      }

      replacements.add(
        SendJobOrderReplacement(
          typeId: typeId,
          category: jobOrderReplacement.category,
          productId: jobOrderReplacement.productId,
          name: jobOrderReplacement.name,
          oldSerialNumber: jobOrderReplacement.oldSerialNumber,
          newSerialNumber: jobOrderReplacement.newSerialNumber,
          quantity: jobOrderReplacement.quantity,
          reason: jobOrderReplacement.reason,
        ),
      );
    }

    List<SendJobOrderInputPeripheral> inputPeripherals = [];

    for (JobOrderInputPeripheral jobOrderInputPeripheral
        in jobOrder.inputPeripherals) {
      inputPeripherals.add(
        SendJobOrderInputPeripheral(
          id: jobOrderInputPeripheral.id,
          servicePoint: jobOrderInputPeripheral.servicePoint,
          category: jobOrderInputPeripheral.category,
          productName: jobOrderInputPeripheral.productName,
          quantity: jobOrderInputPeripheral.quantity,
        ),
      );
    }

    List<SendJobOrderNote> notes = [];

    for (JobOrderNote jobOrderNote in jobOrder.notes) {
      notes.add(
        SendJobOrderNote(
          id: jobOrderNote.id,
          value: jobOrderNote.value,
        ),
      );
    }

    SendJobOrderQris? sendJobOrderQris;

    if (jobOrder.qris != null) {
      List<SendJobOrderQrisMenu> menus = [];

      for (JobOrderQrisMenu jobOrderQrisMenu in jobOrder.qris!.menus) {
        menus.add(
          SendJobOrderQrisMenu(
            id: jobOrderQrisMenu.id,
            value: jobOrderQrisMenu.value,
          ),
        );
      }

      sendJobOrderQris = SendJobOrderQris(
        exist: jobOrder.qris!.exist,
        testResult: jobOrder.qris!.testResult,
        menus: menus,
      );
    }

    Map<String, dynamic> edcEquipments = {};

    for (JobOrderEdcEquipment jobOrderEdcEquipment in jobOrder.edcEquipments) {
      edcEquipments[jobOrderEdcEquipment.name] = jobOrderEdcEquipment.quantity;
    }

    List<SendJobOrderEdcFeatureTestCase> edcFeatureTestCases = [];

    for (JobOrderEdcFeatureTestCase jobOrderEdcFeatureTestCase
        in jobOrder.edcFeatureTestCases) {
      edcFeatureTestCases.add(
        SendJobOrderEdcFeatureTestCase(
          id: jobOrderEdcFeatureTestCase.id,
          value: jobOrderEdcFeatureTestCase.value,
        ),
      );
    }

    List<SendJobOrderJobCategory> jobCategories = [];

    for (JobOrderJobCategory jobOrderJobCategory in jobOrder.jobCategories) {
      jobCategories.add(
        SendJobOrderJobCategory(
          id: jobOrderJobCategory.id,
          value: jobOrderJobCategory.value,
        ),
      );
    }

    SendJobOrderTransactionTest? sendJobOrderTransactionTest;

    if (jobOrder.transactionTest != null) {
      List<SendJobOrderTransactionTestCase> cases = [];

      for (JobOrderTransactionTestCase jobOrderTransactionTestCase
          in jobOrder.transactionTest!.cases) {
        cases.add(
          SendJobOrderTransactionTestCase(
            id: jobOrderTransactionTestCase.id,
            value: jobOrderTransactionTestCase.value,
          ),
        );
      }

      sendJobOrderTransactionTest = SendJobOrderTransactionTest(
        date: jobOrder.transactionTest!.date,
        cases: cases,
      );
    }

    List<SendJobOrderOtherBankEdc> otherBankEdcs = [];

    for (JobOrderOtherBankEdc jobOrderOtherBankEdc in jobOrder.otherBankEdcs) {
      otherBankEdcs.add(
        SendJobOrderOtherBankEdc(
          id: jobOrderOtherBankEdc.id,
          value: jobOrderOtherBankEdc.value,
        ),
      );
    }

    List<SendBniMtiEdcFeature> bniMtiEdcFeatures = [];

    for (EdcBniMtiFeature edcFeature in jobOrder.edcBniMtiFeatures) {
      bniMtiEdcFeatures.add(
        SendBniMtiEdcFeature(
          id: edcFeature.id,
          value: edcFeature.value,
        ),
      );
    }

    SendJobOrderEdcUpdate? sendJobOrderEdcUpdate;

    if (jobOrder.edcUpdate != null) {
      String? dorMenuId;

      if (jobOrder.edcUpdate!.dorMenu != null) {
        dorMenuId = jobOrder.edcUpdate!.dorMenu!.id;
      }

      String? marcollUpdateStatusId;

      if (jobOrder.edcUpdate!.marcollUpdateStatus != null) {
        marcollUpdateStatusId = jobOrder.edcUpdate!.marcollUpdateStatus!.id;
      }

      String? eosUpdateStatusId;

      if (jobOrder.edcUpdate!.eosUpdateStatus != null) {
        eosUpdateStatusId = jobOrder.edcUpdate!.eosUpdateStatus!.id;
      }

      String? appVersion;

      if (jobOrder.edcUpdate!.appVersion != null) {
        appVersion = jobOrder.edcUpdate!.appVersion!.id;
      }

      String? osPatch;

      if (jobOrder.edcUpdate!.osPatch != null) {
        osPatch = jobOrder.edcUpdate!.osPatch!.id;
      }

      String? stickerBank;

      if (jobOrder.edcUpdate!.stickerBank != null) {
        stickerBank = jobOrder.edcUpdate!.stickerBank!.id;
      }

      String? cleaningEdc;

      if (jobOrder.edcUpdate!.cleaningEdc != null) {
        cleaningEdc = jobOrder.edcUpdate!.cleaningEdc!.id;
      }

      sendJobOrderEdcUpdate = SendJobOrderEdcUpdate(
        dorMenuId: dorMenuId,
        marcollUpdateStatusId: marcollUpdateStatusId,
        eosUpdateStatusId: eosUpdateStatusId,
        appVersion: appVersion,
        osPatch: osPatch,
        stickerBank: stickerBank,
        cleaningEdc: cleaningEdc,
      );
    }

    List<SendJobOrderTrainingMaterial> trainingMaterials = [];

    for (JobOrderTrainingMaterial jobOrderTrainingMaterial
        in jobOrder.trainingMaterials) {
      trainingMaterials.add(
        SendJobOrderTrainingMaterial(
          id: jobOrderTrainingMaterial.id,
          value: jobOrderTrainingMaterial.value,
        ),
      );
    }

    String? damageTypeId;

    if (jobOrder.damageType != null) {
      damageTypeId = jobOrder.damageType!.id;
    }

    String? documentStatusId;

    if (jobOrder.documentStatus != null) {
      documentStatusId = jobOrder.documentStatus!.id;
    }

    SendJobOrder sendJobOrder = SendJobOrder(
      id: jobOrder.id,
      scannedSerialNumber: jobOrder.scannedSerialNumber,
      machineConditionNormal: jobOrder.machineConditionNormal,
      damageTypeId: damageTypeId,
      documentStatusId: documentStatusId,
      poi: jobOrder.poi,
      timing: sendJobOrderTiming,
      status: sendJobOrderStatus,
      merchant: sendJobOrderMerchant,
      machineAndCard: sendJobOrderMachineAndCard,
      replacements: replacements,
      inputPeripherals: inputPeripherals,
      notes: notes,
      qris: sendJobOrderQris,
      edcEquipments: edcEquipments,
      edcFeatureTestCases: edcFeatureTestCases,
      jobCategories: jobCategories,
      transactionTest: sendJobOrderTransactionTest,
      otherBankEdcs: otherBankEdcs,
      edcUpdate: sendJobOrderEdcUpdate,
      trainingMaterials: trainingMaterials,
      jamBukaToko: jobOrder.jamBukaToko,
      jamTutupToko: jobOrder.jamTutupToko,
      edcCount: jobOrder.edcCount,
      edcCleaning: jobOrder.edcCleaning ?? SwitchValues.no,
      edcProblem: jobOrder.edcProblem ?? SwitchValues.no,
      settlement: jobOrder.settlement ?? SwitchValues.no,
      otherEdc: jobOrder.otherEdc ?? SwitchValues.no,
      comLine: jobOrder.comLine,
      signalBar: jobOrder.signalBar,
      priorityEdc: jobOrder.priorityEdc,
      merchantComment: jobOrder.merchantComment,
      mostUsedEdc: jobOrder.mostUsedEdc,
      merchantRequest: jobOrder.merchantRequest ?? "",
      promoMaterial: jobOrder.promoMaterial ?? "",
      position: jobOrder.position,
      edcBniMtiFeatures: bniMtiEdcFeatures,
      mostStableEdc: jobOrder.mostStableEdc,
      mostGoodProviderInMerchantLocation: jobOrder.mostGoodProviderInMerchantLocation,
      otherBankEdcProvider: jobOrder.otherBankEdcProvider,
    );

    return sendJobOrder;
  }
}
