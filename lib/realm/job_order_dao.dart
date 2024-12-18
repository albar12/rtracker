import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:jiffy/jiffy.dart';
import 'package:realm/realm.dart';
import 'package:rtracker/api/api_manager.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_response.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_response_deleted.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/helper/job_order_filter.dart';
import 'package:rtracker/helper/locations.dart';
import 'package:rtracker/realm/document_status_dao.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class JobOrderDao {
  static Future<void> addJobOrder({
    required VersionKey versionKey,
    required GetJobOrderResponse getJobOrderResponse,
  }) async {
    Realm realm = Realms.get();

    for (GetJobOrderResponseDetail getJobOrderResponseDetail
        in getJobOrderResponse.data) {
      List<int> merchantSignature = [];
      List<List<int>> merchantImages = [];

      if (getJobOrderResponseDetail.merchant != null) {
        if (getJobOrderResponseDetail.merchant!.signature.isNotEmpty) {
          Uint8List bytes = await ApiManager()
              .download(url: getJobOrderResponseDetail.merchant!.signature);

          if (bytes.isNotEmpty) {
            merchantSignature = bytes;
          }
        }

        for (String merchantImage
            in getJobOrderResponseDetail.merchant!.images) {
          Uint8List bytes = await ApiManager().download(url: merchantImage);

          if (bytes.isNotEmpty) {
            merchantImages.add(bytes);
          }
        }
      }

      List<List<int>> machineSerialNumberPhotos = [];
      List<List<int>> machineImages = [];

      if (getJobOrderResponseDetail.machineAndCard != null) {
        for (String machineSerialNumberPhoto
            in getJobOrderResponseDetail.machineAndCard!.serialNumberPhotos) {
          Uint8List bytes =
              await ApiManager().download(url: machineSerialNumberPhoto);

          if (bytes.isNotEmpty) {
            machineSerialNumberPhotos.add(bytes);
          }
        }

        for (String machineImage
            in getJobOrderResponseDetail.machineAndCard!.images) {
          Uint8List bytes = await ApiManager().download(url: machineImage);

          if (bytes.isNotEmpty) {
            machineImages.add(bytes);
          }
        }
      }

      List<List<int>> transactionTestImages = [];

      if (getJobOrderResponseDetail.transactionTest != null) {
        for (String transactionTestImage
            in getJobOrderResponseDetail.transactionTest!.images) {
          Uint8List bytes =
              await ApiManager().download(url: transactionTestImage);

          if (bytes.isNotEmpty) {
            transactionTestImages.add(bytes);
          }
        }
      }

      List<List<int>> qrisReceiptImages = [];
      List<List<int>> brizziInstallmentReceiptImages = [];

      if (getJobOrderResponseDetail.qris != null) {
        for (String qrisReceiptImage
            in getJobOrderResponseDetail.qris!.qrisReceiptImages) {
          Uint8List bytes = await ApiManager().download(url: qrisReceiptImage);

          if (bytes.isNotEmpty) {
            qrisReceiptImages.add(bytes);
          }
        }

        for (String brizziInstallmentReceiptImage
            in getJobOrderResponseDetail.qris!.brizziInstallmentReceiptImages) {
          Uint8List bytes =
              await ApiManager().download(url: brizziInstallmentReceiptImage);

          if (bytes.isNotEmpty) {
            brizziInstallmentReceiptImages.add(bytes);
          }
        }
      }

      realm.write(() {
        JobOrderDocumentStatus? jobOrderDocumentStatus;

        if (getJobOrderResponseDetail.documentStatus != null) {
          jobOrderDocumentStatus = JobOrderDocumentStatus(
            getJobOrderResponseDetail.documentStatus!.id,
            getJobOrderResponseDetail.documentStatus!.name,
          );
        }

        JobOrderDamageType? jobOrderDamageType;

        if (getJobOrderResponseDetail.damageType != null) {
          jobOrderDamageType = JobOrderDamageType(
            getJobOrderResponseDetail.damageType!.id,
            getJobOrderResponseDetail.damageType!.name,
          );
        }

        JobOrderServicePoint? jobOrderServicePoint;

        if (getJobOrderResponseDetail.servicePoint != null) {
          jobOrderServicePoint = JobOrderServicePoint(
            getJobOrderResponseDetail.servicePoint!.id,
            getJobOrderResponseDetail.servicePoint!.name,
          );
        }

        JobOrderTransactionTest? jobOrderTransactionTest;

        if (getJobOrderResponseDetail.transactionTest != null) {
          jobOrderTransactionTest = JobOrderTransactionTest(
            date: getJobOrderResponseDetail.transactionTest!.date,
            cases: getJobOrderResponseDetail.transactionTest!.cases.map(
              (cases) => JobOrderTransactionTestCase(
                cases.id,
                cases.name,
                cases.amount,
                cases.value,
              ),
            ),
            images: transactionTestImages.map((e) => ImageFile(file: e)),
          );
        }

        JobOrderEdcUpdate? jobOrderEdcUpdate;

        if (getJobOrderResponseDetail.edcUpdate != null) {
          JobOrderDorMenu? jobOrderDorMenu;

          if (getJobOrderResponseDetail.edcUpdate!.dorMenu != null) {
            jobOrderDorMenu = JobOrderDorMenu(
              getJobOrderResponseDetail.edcUpdate!.dorMenu!.id,
              getJobOrderResponseDetail.edcUpdate!.dorMenu!.name,
            );
          }

          JobOrderMarcollUpdateStatus? jobOrderMarcollUpdateStatus;

          if (getJobOrderResponseDetail.edcUpdate!.marcollUpdateStatus !=
              null) {
            jobOrderMarcollUpdateStatus = JobOrderMarcollUpdateStatus(
              getJobOrderResponseDetail.edcUpdate!.marcollUpdateStatus!.id,
              getJobOrderResponseDetail.edcUpdate!.marcollUpdateStatus!.name,
            );
          }

          JobOrderEosUpdateStatus? jobOrderEosUpdateStatus;

          if (getJobOrderResponseDetail.edcUpdate!.eosUpdateStatus != null) {
            jobOrderEosUpdateStatus = JobOrderEosUpdateStatus(
              getJobOrderResponseDetail.edcUpdate!.eosUpdateStatus!.id,
              getJobOrderResponseDetail.edcUpdate!.eosUpdateStatus!.name,
            );
          }

          jobOrderEdcUpdate = JobOrderEdcUpdate(
            dorMenu: jobOrderDorMenu,
            marcollUpdateStatus: jobOrderMarcollUpdateStatus,
            eosUpdateStatus: jobOrderEosUpdateStatus,
          );
        }

        JobOrderRequestType? jobOrderRequestType;

        if (getJobOrderResponseDetail.requestType != null) {
          jobOrderRequestType = JobOrderRequestType(
            getJobOrderResponseDetail.requestType!.id,
            getJobOrderResponseDetail.requestType!.name,
          );
        }

        JobOrderMachineAndCard? jobOrderMachineAndCard;

        if (getJobOrderResponseDetail.machineAndCard != null) {
          JobOrderProvider? jobOrderProvider;

          if (getJobOrderResponseDetail.machineAndCard!.provider != null) {
            jobOrderProvider = JobOrderProvider(
              getJobOrderResponseDetail.machineAndCard!.provider!.id,
              getJobOrderResponseDetail.machineAndCard!.provider!.name,
            );
          }

          JobOrderEdcType? jobOrderEdcType;

          if (getJobOrderResponseDetail.machineAndCard!.edcType != null) {
            jobOrderEdcType = JobOrderEdcType(
              getJobOrderResponseDetail.machineAndCard!.edcType!.id,
              getJobOrderResponseDetail.machineAndCard!.edcType!.name,
              getJobOrderResponseDetail.machineAndCard!.edcType!.flag_android,
            );
          }

          JobOrderEdcCommunicationType? jobOrderEdcCommunicationType;

          if (getJobOrderResponseDetail.machineAndCard!.edcCommunicationType !=
              null) {
            jobOrderEdcCommunicationType = JobOrderEdcCommunicationType(
              getJobOrderResponseDetail
                  .machineAndCard!.edcCommunicationType!.id,
              getJobOrderResponseDetail
                  .machineAndCard!.edcCommunicationType!.name,
            );
          }

          jobOrderMachineAndCard = JobOrderMachineAndCard(
            simCard: getJobOrderResponseDetail.machineAndCard!.simCard,
            provider: jobOrderProvider,
            sam: getJobOrderResponseDetail.machineAndCard!.sam,
            sam2: getJobOrderResponseDetail.machineAndCard!.sam2,
            sam3: getJobOrderResponseDetail.machineAndCard!.sam3,
            sam4: getJobOrderResponseDetail.machineAndCard!.sam4,
            sam5: getJobOrderResponseDetail.machineAndCard!.sam5,
            sam6: getJobOrderResponseDetail.machineAndCard!.sam6,
            sam7: getJobOrderResponseDetail.machineAndCard!.sam7,
            edcType: jobOrderEdcType,
            edcCommunicationType: jobOrderEdcCommunicationType,
            serialNumberPhotos:
                machineSerialNumberPhotos.map((e) => ImageFile(file: e)),
            images: machineImages.map((e) => ImageFile(file: e)),
          );
        }

        JobOrderQris? jobOrderQris;

        if (getJobOrderResponseDetail.qris != null) {
          jobOrderQris = JobOrderQris(
            getJobOrderResponseDetail.qris!.exist,
            getJobOrderResponseDetail.qris!.testResult,
            menus: getJobOrderResponseDetail.qris!.menus.map(
              (menu) => JobOrderQrisMenu(
                menu.id,
                menu.name,
                menu.value,
              ),
            ),
            qrisReceiptImages: qrisReceiptImages.map((e) => ImageFile(file: e)),
            brizziInstallmentReceiptImages:
                brizziInstallmentReceiptImages.map((e) => ImageFile(file: e)),
          );
        }

        JobOrderBaseOffice? jobOrderBaseOffice;

        if (getJobOrderResponseDetail.baseOffice != null) {
          jobOrderBaseOffice = JobOrderBaseOffice(
            getJobOrderResponseDetail.baseOffice!.id,
            getJobOrderResponseDetail.baseOffice!.name,
          );
        }

        JobOrderJobType? jobOrderJobType;

        if (getJobOrderResponseDetail.jobType != null) {
          jobOrderJobType = JobOrderJobType(
            getJobOrderResponseDetail.jobType!.id,
            getJobOrderResponseDetail.jobType!.name,
          );
        }

        JobOrderTiming? jobOrderTiming;

        if (getJobOrderResponseDetail.timing != null) {
          jobOrderTiming = JobOrderTiming(
            departure: getJobOrderResponseDetail.timing!.departure,
            departureCoordinate:
                getJobOrderResponseDetail.timing!.departureCoordinate,
            visit: getJobOrderResponseDetail.timing!.visit,
            visitCoordinate: getJobOrderResponseDetail.timing!.visitCoordinate,
            start: getJobOrderResponseDetail.timing!.start,
            startCoordinate: getJobOrderResponseDetail.timing!.startCoordinate,
            pause: getJobOrderResponseDetail.timing!.pause,
            pauseCoordinate: getJobOrderResponseDetail.timing!.pauseCoordinate,
            finish: getJobOrderResponseDetail.timing!.finish,
            finishCoordinate:
                getJobOrderResponseDetail.timing!.finishCoordinate,
          );
        }

        JobOrderStatus? jobOrderStatus;

        if (getJobOrderResponseDetail.status != null) {
          jobOrderStatus = JobOrderStatus(
            id: getJobOrderResponseDetail.status!.id,
            name: getJobOrderResponseDetail.status!.name,
            categoryId: getJobOrderResponseDetail.status!.categoryId,
            categoryName: getJobOrderResponseDetail.status!.categoryName,
            newVisitDate: getJobOrderResponseDetail.status!.newVisitDate,
          );
        }

        JobOrder? jobOrder = realm.find<JobOrder>(getJobOrderResponseDetail.id);

        if (jobOrder != null) {
          jobOrder.id = getJobOrderResponseDetail.id;
          jobOrder.serialNumberMandatoryType =
              getJobOrderResponseDetail.serialNumberMandatoryType;
          jobOrder.serialNumberValidationType =
              getJobOrderResponseDetail.serialNumberValidationType;
          jobOrder.serialNumberMaxDigit =
              getJobOrderResponseDetail.serialNumberMaxDigit;
          jobOrder.imageMandatoryType =
              getJobOrderResponseDetail.imageMandatoryType;
          jobOrder.latitude = getJobOrderResponseDetail.latitude;
          jobOrder.longitude = getJobOrderResponseDetail.longitude;
          jobOrder.jamBukaToko = getJobOrderResponseDetail.jamBukaToko;
          jobOrder.jamTutupToko = getJobOrderResponseDetail.jamTutupToko;
          jobOrder.edcCount = getJobOrderResponseDetail.edcCount;
          jobOrder.version = getJobOrderResponseDetail.version;
          jobOrder.parentId = getJobOrderResponseDetail.parentId;
          jobOrder.vendorId = getJobOrderResponseDetail.vendorId;
          jobOrder.caseId = getJobOrderResponseDetail.caseId;
          jobOrder.mid = getJobOrderResponseDetail.mid;
          jobOrder.tid = getJobOrderResponseDetail.tid;
          jobOrder.iccid = getJobOrderResponseDetail.iccid;
          jobOrder.msisdn = getJobOrderResponseDetail.msisdn;
          jobOrder.provider = getJobOrderResponseDetail.provider;
          jobOrder.simCard = getJobOrderResponseDetail.simCard;
          jobOrder.sam = getJobOrderResponseDetail.sam;
          jobOrder.sam2 = getJobOrderResponseDetail.sam2;
          jobOrder.sam3 = getJobOrderResponseDetail.sam3;
          jobOrder.sam4 = getJobOrderResponseDetail.sam4;
          jobOrder.sam5 = getJobOrderResponseDetail.sam5;
          jobOrder.sam6 = getJobOrderResponseDetail.sam6;
          jobOrder.sam7 = getJobOrderResponseDetail.sam7;
          jobOrder.visitDate = getJobOrderResponseDetail.visitDate;
          jobOrder.endSla = getJobOrderResponseDetail.endSla;
          jobOrder.description = getJobOrderResponseDetail.description;
          jobOrder.baseOffice = jobOrderBaseOffice;
          jobOrder.cmRemark = getJobOrderResponseDetail.cmRemark;
          jobOrder.servicePoint = jobOrderServicePoint;
          jobOrder.serialNumber = getJobOrderResponseDetail.serialNumber;
          jobOrder.jobType = jobOrderJobType;
          jobOrder.receivedDate = getJobOrderResponseDetail.receivedDate;
          jobOrder.requestType = jobOrderRequestType;
          jobOrder.uploadDate = getJobOrderResponseDetail.uploadDate;

          if (jobOrder.merchant != null) {
            jobOrder.merchant!.id = getJobOrderResponseDetail.merchant!.id;
            jobOrder.merchant!.name = getJobOrderResponseDetail.merchant!.name;
            jobOrder.merchant!.shortName =
                getJobOrderResponseDetail.merchant!.shortName;
            jobOrder.merchant!.city = getJobOrderResponseDetail.merchant!.city;
            jobOrder.merchant!.address =
                getJobOrderResponseDetail.merchant!.address;
            jobOrder.merchant!.phoneNumber =
                getJobOrderResponseDetail.merchant!.phoneNumber;
            jobOrder.merchant!.assignedPicName =
                getJobOrderResponseDetail.merchant!.assignedPicName;
          } else {
            JobOrderMerchant? jobOrderMerchant;

            if (getJobOrderResponseDetail.merchant != null) {
              jobOrderMerchant = JobOrderMerchant(
                getJobOrderResponseDetail.merchant!.id,
                getJobOrderResponseDetail.merchant!.name,
                getJobOrderResponseDetail.merchant!.shortName,
                getJobOrderResponseDetail.merchant!.city,
                getJobOrderResponseDetail.merchant!.address,
                getJobOrderResponseDetail.merchant!.phoneNumber,
                getJobOrderResponseDetail.merchant!.assignedPicName,
                getJobOrderResponseDetail.merchant!.invoiceCount,
                picName: getJobOrderResponseDetail.merchant!.picName,
                picPhoneNumber:
                    getJobOrderResponseDetail.merchant!.picPhoneNumber,
                note: getJobOrderResponseDetail.merchant!.note,
                signature: ImageFile(file: merchantSignature),
                images: merchantImages.map((e) => ImageFile(file: e)),
              );
            }

            jobOrder.merchant = jobOrderMerchant;
          }
        } else {
          JobOrderMerchant? jobOrderMerchant;

          if (getJobOrderResponseDetail.merchant != null) {
            jobOrderMerchant = JobOrderMerchant(
              getJobOrderResponseDetail.merchant!.id,
              getJobOrderResponseDetail.merchant!.name,
              getJobOrderResponseDetail.merchant!.shortName,
              getJobOrderResponseDetail.merchant!.city,
              getJobOrderResponseDetail.merchant!.address,
              getJobOrderResponseDetail.merchant!.phoneNumber,
              getJobOrderResponseDetail.merchant!.assignedPicName,
              getJobOrderResponseDetail.merchant!.invoiceCount,
              picName: getJobOrderResponseDetail.merchant!.picName,
              picPhoneNumber:
                  getJobOrderResponseDetail.merchant!.picPhoneNumber,
              note: getJobOrderResponseDetail.merchant!.note,
              signature: ImageFile(file: merchantSignature),
              images: merchantImages.map((e) => ImageFile(file: e)),
            );
          }

          jobOrder = JobOrder(
            getJobOrderResponseDetail.id,
            getJobOrderResponseDetail.version,
            getJobOrderResponseDetail.serialNumberMaxDigit,
            true,
            getJobOrderResponseDetail.machineConditionNormal,
            getJobOrderResponseDetail.serialNumberMandatoryType,
            getJobOrderResponseDetail.serialNumberValidationType,
            getJobOrderResponseDetail.imageMandatoryType,
            getJobOrderResponseDetail.latitude,
            getJobOrderResponseDetail.longitude,
            getJobOrderResponseDetail.jamBukaToko,
            getJobOrderResponseDetail.jamTutupToko,
            getJobOrderResponseDetail.edcCount,
            true,
            parentId: getJobOrderResponseDetail.parentId,
            vendorId: getJobOrderResponseDetail.vendorId,
            caseId: getJobOrderResponseDetail.caseId,
            mid: getJobOrderResponseDetail.mid,
            tid: getJobOrderResponseDetail.tid,
            poi: getJobOrderResponseDetail.poi,
            iccid: getJobOrderResponseDetail.iccid,
            msisdn: getJobOrderResponseDetail.msisdn,
            provider: getJobOrderResponseDetail.provider,
            simCard: getJobOrderResponseDetail.simCard,
            sam: getJobOrderResponseDetail.sam,
            sam2: getJobOrderResponseDetail.sam2,
            sam3: getJobOrderResponseDetail.sam3,
            sam4: getJobOrderResponseDetail.sam4,
            sam5: getJobOrderResponseDetail.sam5,
            sam6: getJobOrderResponseDetail.sam6,
            sam7: getJobOrderResponseDetail.sam7,
            uploadDate: getJobOrderResponseDetail.uploadDate,
            visitDate: getJobOrderResponseDetail.visitDate,
            endSla: getJobOrderResponseDetail.endSla,
            description: getJobOrderResponseDetail.description,
            requiredThermalCount:
                getJobOrderResponseDetail.requiredThermalCount,
            scannedSerialNumber: getJobOrderResponseDetail.scannedSerialNumber,
            documentStatus: jobOrderDocumentStatus,
            damageType: jobOrderDamageType,
            servicePoint: jobOrderServicePoint,
            transactionTest: jobOrderTransactionTest,
            edcUpdate: jobOrderEdcUpdate,
            requestType: jobOrderRequestType,
            machineAndCard: jobOrderMachineAndCard,
            qris: jobOrderQris,
            baseOffice: jobOrderBaseOffice,
            cmRemark: getJobOrderResponseDetail.cmRemark,
            jobType: jobOrderJobType,
            serialNumber: getJobOrderResponseDetail.serialNumber,
            timing: jobOrderTiming,
            status: jobOrderStatus,
            receivedDate: getJobOrderResponseDetail.receivedDate,
            merchant: jobOrderMerchant,
            edcEquipments: getJobOrderResponseDetail.edcEquipments.entries.map(
              (e) => JobOrderEdcEquipment(
                e.key,
                int.tryParse(e.value.toString()) ?? 0,
              ),
            ),
            jobCategories: getJobOrderResponseDetail.jobCategories
                .map((e) => JobOrderJobCategory(e.id, e.name, e.value)),
            trainingMaterials: getJobOrderResponseDetail.trainingMaterials
                .map((e) => JobOrderTrainingMaterial(e.id, e.name, e.value)),
            edcFeatureTestCases:
                getJobOrderResponseDetail.edcFeatureTestCases.map(
              (e) => JobOrderEdcFeatureTestCase(
                e.id,
                e.name,
                e.value,
                type: e.type,
              ),
            ),
            replacements: getJobOrderResponseDetail.replacements.map((e) {
              JobOrderReplacementType? jobOrderReplacementType;

              if (e.type != null) {
                jobOrderReplacementType = JobOrderReplacementType(
                  e.type!.id,
                  e.type!.name,
                );
              }

              return JobOrderReplacement(
                e.category,
                e.productId,
                e.name,
                e.oldSerialNumber,
                e.newSerialNumber,
                e.quantity,
                e.reason,
                type: jobOrderReplacementType,
              );
            }),
            inputPeripherals:
                getJobOrderResponseDetail.inputPeripherals.map((e) {
              return JobOrderInputPeripheral(
                e.id,
                e.servicePoint,
                e.category,
                e.productName,
                e.quantity,
              );
            }),
            notes: getJobOrderResponseDetail.notes
                .map((e) => JobOrderNote(e.id, e.name, e.value)),
            otherBankEdcs: getJobOrderResponseDetail.otherBankEdcs
                .map((e) => JobOrderOtherBankEdc(e.id, e.name, e.value)),
          );

          realm.add(jobOrder);
        }

        VersionDao.updateVersion(
          realm: realm,
          versionKey: versionKey,
          lastVersion: getJobOrderResponseDetail.version,
        );
      });
    }

    for (GetJobOrderResponseDeleted getJobOrderResponseDeleted
        in getJobOrderResponse.deleted) {
      realm.write(() {
        JobOrder? jobOrder =
            realm.find<JobOrder>(getJobOrderResponseDeleted.id);

        if (jobOrder != null) {
          realm.delete<JobOrder>(jobOrder);
        }

        VersionDao.updateVersion(
          realm: realm,
          versionKey: versionKey,
          lastVersion: getJobOrderResponseDeleted.version,
        );
      });
    }
  }

  static List<JobOrder> list({
    required bool finished,
    required JobOrderFilter jobOrderFilter,
  }) {
    Realm realm = Realms.get();

    final List<String> clauses = [];
    final List<Object?> parameters = [];

    if (finished) {
      clauses.add("documentStatus.id == '0'");
    } else {
      clauses.add("documentStatus.id != '0'");
    }

    {
      int count = 0;

      if (StringUtils.isNotNullOrEmpty(jobOrderFilter.vendorId)) {
        clauses.add('vendorId == \$$count');
        parameters.add(jobOrderFilter.vendorId);

        count++;
      }

      if (StringUtils.isNotNullOrEmpty(jobOrderFilter.baseOfficeId)) {
        clauses.add('baseOffice.id == \$$count');
        parameters.add(jobOrderFilter.baseOfficeId);

        count++;
      }

      if (StringUtils.isNotNullOrEmpty(jobOrderFilter.servicePointId)) {
        clauses.add('servicePoint.id == \$$count');
        parameters.add(jobOrderFilter.servicePointId);

        count++;
      }

      if (StringUtils.isNotNullOrEmpty(jobOrderFilter.jobTypeId)) {
        clauses.add('jobType.id == \$$count');
        parameters.add(jobOrderFilter.jobTypeId);

        count++;
      }

      if (StringUtils.isNotNullOrEmpty(jobOrderFilter.caseId)) {
        clauses.add('caseId CONTAINS[c] \$$count');
        parameters.add(jobOrderFilter.caseId);

        count++;
      }

      if (StringUtils.isNotNullOrEmpty(jobOrderFilter.mid)) {
        clauses.add('mid CONTAINS[c] \$$count');
        parameters.add(jobOrderFilter.mid);

        count++;
      }

      if (StringUtils.isNotNullOrEmpty(jobOrderFilter.tid)) {
        clauses.add('tid CONTAINS[c] \$$count');
        parameters.add(jobOrderFilter.tid);

        count++;
      }

      if (StringUtils.isNotNullOrEmpty(jobOrderFilter.merchantName)) {
        clauses.add('merchant.name CONTAINS[c] \$$count');
        parameters.add(jobOrderFilter.merchantName);

        count++;
      }

      if (jobOrderFilter.receivedDate != null) {
        clauses.add('receivedDate >= \$$count');
        parameters.add(Jiffy.parseFromDateTime(jobOrderFilter.receivedDate!)
            .startOf(Unit.day)
            .dateTime);

        count++;

        clauses.add('receivedDate <= \$$count');
        parameters.add(Jiffy.parseFromDateTime(jobOrderFilter.receivedDate!)
            .endOf(Unit.day)
            .dateTime);

        count++;
      }

      if (StringUtils.isNotNullOrEmpty(jobOrderFilter.documentStatusId)) {
        clauses.add('documentStatus.id == \$$count');
        parameters.add(jobOrderFilter.documentStatusId);

        count++;
      }
    }

    String assembledQuery = "";

    {
      for (int i = 0; i < clauses.length; i++) {
        if (i > 0) {
          assembledQuery += " AND ";
        }

        assembledQuery += clauses[i];
      }

      if (jobOrderFilter.sortBy != null) {
        if (assembledQuery.isNotEmpty) {
          assembledQuery += " ";
        } else {
          assembledQuery += "TRUEPREDICATE ";
        }

        assembledQuery += "SORT (${jobOrderFilter.sortBy!} ASC)";
      }
    }

    print("tes alif list job order");
    print(clauses);
    print(StringUtils.isNotNullOrEmpty(assembledQuery));
    if (StringUtils.isNotNullOrEmpty(assembledQuery)) {
      return List<JobOrder>.from(
        realm.query<JobOrder>(
          assembledQuery,
          parameters,
        ),
      );
    } else {
      return List<JobOrder>.from(
        realm.all<JobOrder>(),
      );
    }
  }

  static List<JobOrder> pendings() {
    return List<JobOrder>.from(
      Realms.get().query<JobOrder>(
        "synced == FALSE",
      ),
    );
  }

  static bool hasOngoingJob(String id) {
    return Realms.get().query<JobOrder>(
      "id != \$0 AND documentStatus.id IN {\$1, \$2, \$3}",
      [id, "6", "1", "4"],
    ).isNotEmpty;
  }

  static int pauseJobs(String id) {
    return Realms.get().query<JobOrder>(
      "id != \$0 AND documentStatus.id == \$1",
      [id, "3"],
    ).length;
  }

  static Future<void> execute(JobOrder jobOrder) async {
    if (jobOrder.documentStatus != null) {
      if (jobOrder.documentStatus!.id == "2") {
        DocumentStatus? documentStatus = DocumentStatusDao.find("6");

        if (documentStatus != null) {
          LongLat? longLat = await Locations.lastPosition();

          Realms.get().write(() {
            jobOrder.documentStatus!.id = documentStatus.id;
            jobOrder.documentStatus!.name = documentStatus.name;

            jobOrder.timing ??= JobOrderTiming();
            jobOrder.timing!.departure = DateTime.now();

            if (longLat != null) {
              jobOrder.timing!.departureCoordinate =
                  "${longLat.latitude},${longLat.longitude}";
            }
          });
        }
      }
    }
  }

  static Future<void> visit(JobOrder jobOrder) async {
    if (jobOrder.documentStatus != null) {
      if (jobOrder.documentStatus!.id == "6") {
        DocumentStatus? documentStatus = DocumentStatusDao.find("1");

        if (documentStatus != null) {
          LongLat? longLat = await Locations.lastPosition();

          Realms.get().write(() {
            jobOrder.documentStatus!.id = documentStatus.id;
            jobOrder.documentStatus!.name = documentStatus.name;

            jobOrder.timing ??= JobOrderTiming();
            jobOrder.timing!.visit = DateTime.now();

            if (longLat != null) {
              jobOrder.timing!.visitCoordinate =
                  "${longLat.latitude},${longLat.longitude}";
            }
          });
        }
      }
    }
  }

  static Future<void> start(JobOrder jobOrder) async {
    if (jobOrder.documentStatus != null) {
      if (jobOrder.documentStatus!.id == "1" ||
          jobOrder.documentStatus!.id == "3") {
        DocumentStatus? documentStatus = DocumentStatusDao.find("4");

        if (documentStatus != null) {
          LongLat? longLat = await Locations.lastPosition();

          Realms.get().write(() {
            jobOrder.documentStatus!.id = documentStatus.id;
            jobOrder.documentStatus!.name = documentStatus.name;

            jobOrder.timing ??= JobOrderTiming();
            jobOrder.timing!.start = DateTime.now();

            if (longLat != null) {
              jobOrder.timing!.startCoordinate =
                  "${longLat.latitude},${longLat.longitude}";
            }
          });
        }
      }
    }
  }

  static Future<void> pause(JobOrder jobOrder) async {
    if (jobOrder.documentStatus != null) {
      if (jobOrder.documentStatus!.id == "4") {
        DocumentStatus? documentStatus = DocumentStatusDao.find("3");

        if (documentStatus != null) {
          LongLat? longLat = await Locations.lastPosition();

          Realms.get().write(() {
            jobOrder.documentStatus!.id = documentStatus.id;
            jobOrder.documentStatus!.name = documentStatus.name;

            jobOrder.timing ??= JobOrderTiming();
            jobOrder.timing!.pause = DateTime.now();

            if (longLat != null) {
              jobOrder.timing!.pauseCoordinate =
                  "${longLat.latitude},${longLat.longitude}";
            }
          });
        }
      }
    }
  }

  static Future<void> finish(JobOrder jobOrder) async {
    if (jobOrder.documentStatus != null) {
      if (jobOrder.documentStatus!.id == "4") {
        DocumentStatus? documentStatus = DocumentStatusDao.find("0");

        if (documentStatus != null) {
          LongLat? longLat = await Locations.lastPosition();

          Realms.get().write(() {
            jobOrder.synced = false;
            jobOrder.documentStatus!.id = documentStatus.id;
            jobOrder.documentStatus!.name = documentStatus.name;

            jobOrder.timing ??= JobOrderTiming();
            jobOrder.timing!.finish = DateTime.now();

            if (longLat != null) {
              jobOrder.timing!.finishCoordinate =
                  "${longLat.latitude},${longLat.longitude}";
            }
          });
        }
      }
    }
  }

  static void synced(JobOrder jobOrder) {
    Realms.get().write(() {
      jobOrder.synced = true;
    });
  }

  static int references(String id) {
    return Realms.get().query<JobOrder>(
      "id != parentId AND parentId = \$0",
      [id],
    ).length;
  }
}
