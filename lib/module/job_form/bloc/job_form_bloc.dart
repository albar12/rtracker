import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:rtracker/api/api_manager.dart';
import 'package:rtracker/api/endpoint/transaction/send_job_order.dart';
import 'package:rtracker/module/job_form/bloc/job_form_event.dart';
import 'package:rtracker/module/job_form/bloc/job_form_state.dart';
import 'package:rtracker/realm/app_version_dao.dart';
import 'package:rtracker/realm/damage_type_dao.dart';
import 'package:rtracker/realm/dor_menu_dao.dart';
import 'package:rtracker/realm/edc_communication_type_dao.dart';
import 'package:rtracker/realm/edc_equipment_dao.dart';
import 'package:rtracker/realm/edc_feature_test_case_dao.dart';
import 'package:rtracker/realm/edc_type_dao.dart';
import 'package:rtracker/realm/eos_update_status_dao.dart';
import 'package:rtracker/realm/job_category_dao.dart';
import 'package:rtracker/realm/job_order_dao.dart';
import 'package:rtracker/realm/job_status_category_dao.dart';
import 'package:rtracker/realm/job_status_dao.dart';
import 'package:rtracker/realm/marcoll_update_status_dao.dart';
import 'package:rtracker/realm/note_dao.dart';
import 'package:rtracker/realm/os_patch_dao.dart';
import 'package:rtracker/realm/other_bank_edc_dao.dart';
import 'package:rtracker/realm/provider_dao.dart';
import 'package:rtracker/realm/qris_menu_dao.dart';
import 'package:rtracker/realm/replacement_type_dao.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/sticker_bank_dao.dart';
import 'package:rtracker/realm/training_material_dao.dart';
import 'package:rtracker/realm/transaction_test_case_dao.dart';

class JobFormBloc extends Bloc<JobFormEvent, JobFormState> {
  JobFormBloc() : super(JobFormInitial()) {
    on<JobFormStarted>(started);
    on<JobFormJobStatusSelected>(jobStatusSelected);
    on<JobFormSubmitted>(submitted);
  }

  FutureOr<void> started(JobFormStarted event, Emitter<JobFormState> emit) {
    List<Provider> providers = ProviderDao.all(vendorId: event.vendorId);
    List<EdcType> edcTypes = EdcTypeDao.all(vendorId: event.vendorId);
    List<AppVersion> appVersion =
        AppVersionDao.all(vendorId: event.vendorId.toString());
    List<OsPatch> osPatch = OsPatchDao.all(vendorId: event.vendorId.toString());
    List<StickerBank> sticerBank =
        StickerBankDao.all(vendorId: event.vendorId.toString());
    List<EdcCommunicationType> edcCommunicationTypes =
        EdcCommunicationTypeDao.all();
    List<ReplacementType> replacementTypes = ReplacementTypeDao.all();
    List<JobStatus> jobStatuses = JobStatusDao.all(vendorId: event.vendorId);

    List<JobStatusCategory> jobStatusCategories = [];

    if (event.jobOrder.status != null) {
      String? jobTypeId;

      // if (event.jobOrder.vendorId! == "2") { //sebelumnya hanya membaca MTI (vendorId == 2)
      jobTypeId = event.jobOrder.jobType!.id;
      // }

      jobStatusCategories = JobStatusCategoryDao.all(
        jobStatusId: event.jobOrder.status!.id ?? "0",
        vendorId: event.jobOrder.vendorId!,
        jobTypeId: jobTypeId,
      );
    }

    List<Note> notes = NoteDao.all();
    List<QrisMenu> qrisMenus = QrisMenuDao.all();
    List<EdcEquipment> edcEquipments =
        EdcEquipmentDao.all(vendorId: event.vendorId);
    List<EdcFeatureTestCase> edcFeatureTestCases = EdcFeatureTestCaseDao.all();
    List<JobCategory> jobCategories =
        JobCategoryDao.all(vendorId: event.vendorId);
    List<OtherBankEdc> otherBankEdcs = OtherBankEdcDao.all();
    List<DorMenu> dorMenus = DorMenuDao.all();
    List<MarcollUpdateStatus> marcollUpdateStatuses =
        MarcollUpdateStatusDao.all();
    List<EosUpdateStatus> eosUpdateStatuses = EosUpdateStatusDao.all();
    List<TrainingMaterial> trainingMaterials = TrainingMaterialDao.all();
    List<DamageType> damageTypes = DamageTypeDao.all();
    List<TransactionTestCase> transactionTestCases =
        TransactionTestCaseDao.all(jobTypeId: event.jobOrder.jobType!.id);

    emit(
      JobFormLoaded(
        providers: providers,
        edcTypes: edcTypes,
        appVersion: appVersion,
        osPatch: osPatch,
        stickerBank: sticerBank,
        edcCommunicationTypes: edcCommunicationTypes,
        jobStatuses: jobStatuses,
        jobStatusCategories: jobStatusCategories,
        notes: notes,
        qrisMenus: qrisMenus,
        edcEquipments: edcEquipments,
        edcFeatureTestCases: edcFeatureTestCases,
        jobCategories: jobCategories,
        transactionTestCases: transactionTestCases,
        replacementTypes: replacementTypes,
        otherBankEdcs: otherBankEdcs,
        dorMenus: dorMenus,
        marcollUpdateStatuses: marcollUpdateStatuses,
        eosUpdateStatuses: eosUpdateStatuses,
        trainingMaterials: trainingMaterials,
        damageTypes: damageTypes,
      ),
    );
  }

  FutureOr<void> jobStatusSelected(
    JobFormJobStatusSelected event,
    Emitter<JobFormState> emit,
  ) async {
    String? jobTypeId;

    // if (event.vendorId == "2") { //sebelumnya hanya baca MTI (vendorId == 2)
    jobTypeId = event.jobTypeId;
    // }

    List<JobStatusCategory> jobStatusCategories = JobStatusCategoryDao.all(
      jobStatusId: event.jobStatusId,
      vendorId: event.vendorId,
      jobTypeId: jobTypeId,
    );

    emit(
      JobFormJobStatusCategorySuccess(
        jobStatusCategories: jobStatusCategories,
      ),
    );
  }

  FutureOr<void> submitted(
    JobFormSubmitted event,
    Emitter<JobFormState> emit,
  ) async {
    emit(JobFormSubmitLoading());

    try {
      Uint8List? merchantSignature;
      List<Uint8List> merchantImages = [];
      List<Uint8List> machineImages = [];
      List<Uint8List> machineSerialNumberPhotos = [];
      List<Uint8List> transactionTestImages = [];
      List<Uint8List> qrisReceiptImages = [];
      List<Uint8List> brizziInstallmentReceiptImages = [];
      List<Uint8List> picMerchantImages = [];
      List<Uint8List> rollSalesDraftImages = [];
      List<Uint8List> trainingStatementLetterImages = [];
      List<Uint8List> edcAppImages = [];
      List<Uint8List> otherImages = [];

      if (event.jobOrder.merchant != null) {
        if (event.jobOrder.merchant!.signature != null) {
          merchantSignature = Uint8List.fromList(
            event.jobOrder.merchant!.signature!.file,
          );
        }

        for (ImageFile imageFile in event.jobOrder.merchant!.images) {
          merchantImages.add(
            Uint8List.fromList(
              imageFile.file,
            ),
          );
        }
      }

      if (event.jobOrder.machineAndCard != null) {
        for (ImageFile imageFile
            in event.jobOrder.machineAndCard!.serialNumberPhotos) {
          machineSerialNumberPhotos.add(
            Uint8List.fromList(
              imageFile.file,
            ),
          );
        }

        for (ImageFile imageFile in event.jobOrder.machineAndCard!.images) {
          machineImages.add(
            Uint8List.fromList(
              imageFile.file,
            ),
          );
        }

        // Add here
        for (ImageFile imageFile in event.jobOrder.machineAndCard!.picMerchantImages) {
          picMerchantImages.add(
            Uint8List.fromList(
              imageFile.file,
            ),
          );
        }

        for (ImageFile imageFile in event.jobOrder.machineAndCard!.rollSalesDraftImages) {
          rollSalesDraftImages.add(
            Uint8List.fromList(
              imageFile.file,
            ),
          );
        }

        for (ImageFile imageFile in event.jobOrder.machineAndCard!.trainingStatementLetterImages) {
          trainingStatementLetterImages.add(
            Uint8List.fromList(
              imageFile.file,
            ),
          );
        }

        for (ImageFile imageFile in event.jobOrder.machineAndCard!.edcAppImages) {
          edcAppImages.add(
            Uint8List.fromList(
              imageFile.file,
            ),
          );
        }

        for (ImageFile imageFile in event.jobOrder.machineAndCard!.otherImages) {
          otherImages.add(
            Uint8List.fromList(
              imageFile.file,
            ),
          );
        }
      }

      if (event.jobOrder.transactionTest != null) {
        for (ImageFile imageFile in event.jobOrder.transactionTest!.images) {
          transactionTestImages.add(
            Uint8List.fromList(
              imageFile.file,
            ),
          );
        }
      }

      if (event.jobOrder.qris != null) {
        for (ImageFile imageFile in event.jobOrder.qris!.qrisReceiptImages) {
          qrisReceiptImages.add(
            Uint8List.fromList(
              imageFile.file,
            ),
          );
        }

        for (ImageFile imageFile
            in event.jobOrder.qris!.brizziInstallmentReceiptImages) {
          brizziInstallmentReceiptImages.add(
            Uint8List.fromList(
              imageFile.file,
            ),
          );
        }
      }

      SendJobOrder sendJobOrder = SendJobOrder.build(event.jobOrder);

      Response response = await ApiManager().postJobOrders(
        merchantSignature: merchantSignature,
        merchantImages: merchantImages,
        machineImages: machineImages,
        machineSerialNumberPhotos: machineSerialNumberPhotos,
        transactionTestImages: transactionTestImages,
        qrisReceiptImages: qrisReceiptImages,
        brizziInstallmentReceiptImages: brizziInstallmentReceiptImages,
        sendJobOrder: sendJobOrder,
        picMerchantImages: picMerchantImages,
        rollSalesDraftImages: rollSalesDraftImages,
        trainingStatementLetterImages: trainingStatementLetterImages,
        edcAppImages: edcAppImages,
        otherImages: otherImages
      );

      if (response.statusCode == 200) {
        JobOrderDao.synced(event.jobOrder);

        emit(JobFormSubmitSuccess());
      } else {
        emit(JobFormSubmitFailed());
      }
    } catch (e) {
      print(e);

      emit(JobFormSubmitFailed());
    } finally {
      emit(JobFormSubmitFinished());
    }
  }
}
