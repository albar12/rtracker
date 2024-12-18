import 'package:realm/realm.dart';
import 'package:rtracker/realm/schemas.dart';

class Realms {
  static Realm? realm;

  static Realm get() {
    realm ??= Realm(
      Configuration.local([
        ImageFile.schema,
        Version.schema,
        Vendor.schema,
        BaseOffice.schema,
        ServicePoint.schema,
        JobType.schema,
        DocumentStatus.schema,
        RequestType.schema,
        MmsStatus.schema,
        Provider.schema,
        EdcType.schema,
        AppVersion.schema,
        OsPatch.schema,
        StickerBank.schema,
        EdcCommunicationType.schema,
        ReplacementType.schema,
        JobStatus.schema,
        JobStatusCategory.schema,
        Note.schema,
        QrisMenu.schema,
        EdcEquipment.schema,
        EdcFeatureTestCase.schema,
        JobCategory.schema,
        TransactionTestCase.schema,
        OtherBankEdc.schema,
        DorMenu.schema,
        MarcollUpdateStatus.schema,
        EosUpdateStatus.schema,
        TrainingMaterial.schema,
        DamageType.schema,
        SnStock.schema,
        NonSnStock.schema,
        JobOrderDocumentStatus.schema,
        JobOrderDamageType.schema,
        JobOrderBaseOffice.schema,
        JobOrderServicePoint.schema,
        JobOrderJobType.schema,
        JobOrderTiming.schema,
        JobOrderStatus.schema,
        JobOrderRequestType.schema,
        JobOrderMerchant.schema,
        JobOrderProvider.schema,
        JobOrderEdcType.schema,
        JobOrderEdcCommunicationType.schema,
        JobOrderMachineAndCard.schema,
        JobOrderReplacementType.schema,
        JobOrderReplacement.schema,
        JobOrderInputPeripheral.schema,
        JobOrderNote.schema,
        JobOrderQrisMenu.schema,
        JobOrderQris.schema,
        JobOrderEdcEquipment.schema,
        JobOrderEdcFeatureTestCase.schema,
        JobOrderJobCategory.schema,
        JobOrderTransactionTestCase.schema,
        JobOrderTransactionTest.schema,
        JobOrderOtherBankEdc.schema,
        JobOrderDorMenu.schema,
        JobOrderMarcollUpdateStatus.schema,
        JobOrderEosUpdateStatus.schema,
        JobOrderAppVersion.schema,
        JobOrderOsPatch.schema,
        JobOrderStickerBank.schema,
        JobOrderCleaningEdc.schema,
        JobOrderEdcUpdate.schema,
        JobOrderTrainingMaterial.schema,
        JobOrder.schema,
        Inbox.schema,
      ],
        schemaVersion: 2,
        migrationCallback: (migration, oldVersion) {
          if (oldVersion < 2){

          }
        },
      ),
    );

    return realm!;
  }

  static void clear() {
    var realm = get();
    realm.write(() {
      realm.deleteAll<ImageFile>();
      realm.deleteAll<Version>();
      realm.deleteAll<Vendor>();
      realm.deleteAll<BaseOffice>();
      realm.deleteAll<ServicePoint>();
      realm.deleteAll<JobType>();
      realm.deleteAll<DocumentStatus>();
      realm.deleteAll<RequestType>();
      realm.deleteAll<MmsStatus>();
      realm.deleteAll<Provider>();
      realm.deleteAll<EdcType>();
      realm.deleteAll<AppVersion>();
      realm.deleteAll<OsPatch>();
      realm.deleteAll<StickerBank>();
      realm.deleteAll<EdcCommunicationType>();
      realm.deleteAll<ReplacementType>();
      realm.deleteAll<JobStatus>();
      realm.deleteAll<JobStatusCategory>();
      realm.deleteAll<Note>();
      realm.deleteAll<QrisMenu>();
      realm.deleteAll<EdcEquipment>();
      realm.deleteAll<EdcFeatureTestCase>();
      realm.deleteAll<JobCategory>();
      realm.deleteAll<TransactionTestCase>();
      realm.deleteAll<OtherBankEdc>();
      realm.deleteAll<DorMenu>();
      realm.deleteAll<MarcollUpdateStatus>();
      realm.deleteAll<EosUpdateStatus>();
      realm.deleteAll<TrainingMaterial>();
      realm.deleteAll<DamageType>();
      realm.deleteAll<SnStock>();
      realm.deleteAll<NonSnStock>();
      realm.deleteAll<JobOrderDocumentStatus>();
      realm.deleteAll<JobOrderDamageType>();
      realm.deleteAll<JobOrderBaseOffice>();
      realm.deleteAll<JobOrderServicePoint>();
      realm.deleteAll<JobOrderJobType>();
      realm.deleteAll<JobOrderTiming>();
      realm.deleteAll<JobOrderStatus>();
      realm.deleteAll<JobOrderRequestType>();
      realm.deleteAll<JobOrderMerchant>();
      realm.deleteAll<JobOrderProvider>();
      realm.deleteAll<JobOrderEdcType>();
      realm.deleteAll<JobOrderEdcCommunicationType>();
      realm.deleteAll<JobOrderMachineAndCard>();
      realm.deleteAll<JobOrderReplacementType>();
      realm.deleteAll<JobOrderReplacement>();
      realm.deleteAll<JobOrderInputPeripheral>();
      realm.deleteAll<JobOrderNote>();
      realm.deleteAll<JobOrderQrisMenu>();
      realm.deleteAll<JobOrderQris>();
      realm.deleteAll<JobOrderEdcEquipment>();
      realm.deleteAll<JobOrderEdcFeatureTestCase>();
      realm.deleteAll<JobOrderJobCategory>();
      realm.deleteAll<JobOrderTransactionTestCase>();
      realm.deleteAll<JobOrderTransactionTest>();
      realm.deleteAll<JobOrderOtherBankEdc>();
      realm.deleteAll<JobOrderDorMenu>();
      realm.deleteAll<JobOrderMarcollUpdateStatus>();
      realm.deleteAll<JobOrderEosUpdateStatus>();
      realm.deleteAll<JobOrderAppVersion>();
      realm.deleteAll<JobOrderOsPatch>();
      realm.deleteAll<JobOrderStickerBank>();
      realm.deleteAll<JobOrderCleaningEdc>();
      realm.deleteAll<JobOrderEdcUpdate>();
      realm.deleteAll<JobOrderTrainingMaterial>();
      realm.deleteAll<JobOrder>();
      realm.deleteAll<Inbox>();
    });
  }
}
