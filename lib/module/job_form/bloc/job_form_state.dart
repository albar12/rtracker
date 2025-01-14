import 'package:flutter/material.dart';
import 'package:rtracker/realm/schemas.dart';

@immutable
abstract class JobFormState {}

class JobFormInitial extends JobFormState {}

class JobFormLoaded extends JobFormState {
  final List<Provider> providers;
  final List<EdcType> edcTypes;
  final List<AppVersion> appVersion;
  final List<OsPatch> osPatch;
  final List<StickerBank> stickerBank;
  final List<EdcCommunicationType> edcCommunicationTypes;
  final List<JobStatus> jobStatuses;
  final List<JobStatusCategory> jobStatusCategories;
  final List<Note> notes;
  final List<QrisMenu> qrisMenus;
  final List<EdcEquipment> edcEquipments;
  final List<EdcFeatureTestCase> edcFeatureTestCases;
  final List<JobCategory> jobCategories;
  final List<TransactionTestCase> transactionTestCases;
  final List<ReplacementType> replacementTypes;
  final List<OtherBankEdc> otherBankEdcs;
  final List<DorMenu> dorMenus;
  final List<MarcollUpdateStatus> marcollUpdateStatuses;
  final List<EosUpdateStatus> eosUpdateStatuses;
  final List<TrainingMaterial> trainingMaterials;
  final List<DamageType> damageTypes;

  JobFormLoaded({
    required this.providers,
    required this.edcTypes,
    required this.appVersion,
    required this.osPatch,
    required this.stickerBank,
    required this.edcCommunicationTypes,
    required this.jobStatuses,
    required this.jobStatusCategories,
    required this.notes,
    required this.qrisMenus,
    required this.edcEquipments,
    required this.edcFeatureTestCases,
    required this.jobCategories,
    required this.transactionTestCases,
    required this.replacementTypes,
    required this.otherBankEdcs,
    required this.dorMenus,
    required this.marcollUpdateStatuses,
    required this.eosUpdateStatuses,
    required this.trainingMaterials,
    required this.damageTypes,
  });
}

class JobFormJobStatusCategorySuccess extends JobFormState {
  final List<JobStatusCategory> jobStatusCategories;

  JobFormJobStatusCategorySuccess({
    required this.jobStatusCategories,
  });
}

class JobFormSubmitLoading extends JobFormState {}

class JobFormSubmitSuccess extends JobFormState {
  final String data;
  JobFormSubmitSuccess(this.data);
}

class JobFormSubmitFailed extends JobFormState {
  final String message;
  JobFormSubmitFailed(this.message);
}

class JobFormSubmitFinished extends JobFormState {}
