import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:basic_utils/basic_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:rtracker/api/api_manager.dart';
import 'package:rtracker/api/endpoint/master/app_version/get_app_version_response.dart';
import 'package:rtracker/api/endpoint/master/base_office/get_base_office_response.dart';
import 'package:rtracker/api/endpoint/master/check_version/check_version_request.dart';
import 'package:rtracker/api/endpoint/master/check_version/check_version_response.dart';
import 'package:rtracker/api/endpoint/master/damage_type/get_damage_type_response.dart';
import 'package:rtracker/api/endpoint/master/document_status/get_document_status_response.dart';
import 'package:rtracker/api/endpoint/master/dor_menu/get_dor_menu_response.dart';
import 'package:rtracker/api/endpoint/master/edc_communication_type/get_edc_communication_type_response.dart';
import 'package:rtracker/api/endpoint/master/edc_equipment/get_edc_equipment_response.dart';
import 'package:rtracker/api/endpoint/master/edc_feature_test_case/get_edc_feature_test_case_response.dart';
import 'package:rtracker/api/endpoint/master/edc_type/get_edc_type_response.dart';
import 'package:rtracker/api/endpoint/master/eos_update_status/get_eos_update_status_response.dart';
import 'package:rtracker/api/endpoint/master/inbox/get_inbox_response.dart';
import 'package:rtracker/api/endpoint/master/job_category/get_job_category_response.dart';
import 'package:rtracker/api/endpoint/master/job_status/get_job_status_response.dart';
import 'package:rtracker/api/endpoint/master/job_status_category/get_job_status_category_response.dart';
import 'package:rtracker/api/endpoint/master/job_type/get_job_type_response.dart';
import 'package:rtracker/api/endpoint/master/marcoll_update_status/get_marcoll_update_status_response.dart';
import 'package:rtracker/api/endpoint/master/mms_status/get_mms_status_response.dart';
import 'package:rtracker/api/endpoint/master/non_sn_stock/get_non_sn_stock_response.dart';
import 'package:rtracker/api/endpoint/master/note/get_note_response.dart';
import 'package:rtracker/api/endpoint/master/os_patch/get_os_patch_response.dart';
import 'package:rtracker/api/endpoint/master/other_bank_edc/get_other_bank_edc_response.dart';
import 'package:rtracker/api/endpoint/master/provider/get_provider_response.dart';
import 'package:rtracker/api/endpoint/master/qris_menu/get_qris_menu_response.dart';
import 'package:rtracker/api/endpoint/master/replacement_type/get_replacement_type_response.dart';
import 'package:rtracker/api/endpoint/master/request_type/get_request_type_response.dart';
import 'package:rtracker/api/endpoint/master/service_point/get_service_point_response.dart';
import 'package:rtracker/api/endpoint/master/sn_stock/get_sn_stock_response.dart';
import 'package:rtracker/api/endpoint/master/sticker_bank/get_sticker_bank_response.dart';
import 'package:rtracker/api/endpoint/master/training_material/get_training_material_response.dart';
import 'package:rtracker/api/endpoint/master/transaction_test_case/get_transaction_test_case_response.dart';
import 'package:rtracker/api/endpoint/master/vendor/get_vendor_response.dart';
import 'package:rtracker/api/endpoint/send_location/send_location_request.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_response.dart';
import 'package:rtracker/api/endpoint/transaction/send_job_order.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/helper/locations.dart';
import 'package:rtracker/helper/preferences.dart';
import 'package:rtracker/module/synchronization/synchronization_bloc.dart';
import 'package:rtracker/module/synchronization/synchronization_event.dart';
import 'package:rtracker/realm/app_version_dao.dart';
import 'package:rtracker/realm/base_office_dao.dart';
import 'package:rtracker/realm/damage_type_dao.dart';
import 'package:rtracker/realm/document_status_dao.dart';
import 'package:rtracker/realm/dor_menu_dao.dart';
import 'package:rtracker/realm/edc_communication_type_dao.dart';
import 'package:rtracker/realm/edc_equipment_dao.dart';
import 'package:rtracker/realm/edc_feature_test_case_dao.dart';
import 'package:rtracker/realm/edc_type_dao.dart';
import 'package:rtracker/realm/eos_update_status_dao.dart';
import 'package:rtracker/realm/inbox_dao.dart';
import 'package:rtracker/realm/job_category_dao.dart';
import 'package:rtracker/realm/job_order_dao.dart';
import 'package:rtracker/realm/job_status_category_dao.dart';
import 'package:rtracker/realm/job_status_dao.dart';
import 'package:rtracker/realm/job_type_dao.dart';
import 'package:rtracker/realm/marcoll_update_status_dao.dart';
import 'package:rtracker/realm/mms_status_dao.dart';
import 'package:rtracker/realm/non_sn_stock_dao.dart';
import 'package:rtracker/realm/note_dao.dart';
import 'package:rtracker/realm/os_patch_dao.dart';
import 'package:rtracker/realm/other_bank_edc_dao.dart';
import 'package:rtracker/realm/provider_dao.dart';
import 'package:rtracker/realm/qris_menu_dao.dart';
import 'package:rtracker/realm/replacement_type_dao.dart';
import 'package:rtracker/realm/request_type_dao.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/service_point_dao.dart';
import 'package:rtracker/realm/sn_stock_dao.dart';
import 'package:rtracker/realm/sticker_bank_dao.dart';
import 'package:rtracker/realm/training_material_dao.dart';
import 'package:rtracker/realm/transaction_test_case_dao.dart';
import 'package:rtracker/realm/vendor_dao.dart';
import 'package:rtracker/realm/version_dao.dart';

enum BackgroundServiceCommand { FOREGROUND, BACKGROUND, STOP }

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();

  DartPluginRegistrant.ensureInitialized();

  var preferences = Preferences.getInstance();

  await preferences.reload();

  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  await Preferences.getInstance().init();

  initializeDateFormatting();

  if (service is AndroidServiceInstance) {
    service.on(BackgroundServiceCommand.FOREGROUND.name).listen((event) {
      service.setAsForegroundService();
    });

    service.on(BackgroundServiceCommand.BACKGROUND.name).listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on(BackgroundServiceCommand.STOP.name).listen((event) {
    service.stopSelf();
  });

  checkVersionJob();
  sendLocationJob();
  sendPendingJobOrderJob();
  markAsReadInboxJob();
}

void checkVersionJob() async {
  while (true) {
    if (Preferences.getInstance().getString(SharedPreferenceKey.SESSION_ID) !=
        null) {
      await BackgroundService.checkVersion(null);
    }

    await Future.delayed(
      Duration(
        minutes: Preferences.getInstance()
                .getInt(SharedPreferenceKey.CHECK_VERSION_INTERVAL, 1) ??
            1,
      ),
    );
  }
}

void markAsReadInboxJob() async {
  while (true) {
    if (Preferences.getInstance().getString(SharedPreferenceKey.SESSION_ID) !=
        null) {
      await BackgroundService.markAsReadInbox();
    }

    await Future.delayed(const Duration(minutes: 5));
  }
}

void sendLocationJob() async {
  while (true) {
    if (Preferences.getInstance().getString(SharedPreferenceKey.SESSION_ID) !=
        null) {
      await BackgroundService.sendLocation();
    }

    await Future.delayed(
      Duration(
        minutes: Preferences.getInstance()
                .getInt(SharedPreferenceKey.SEND_LOCATION_INTERVAL, 5) ??
            5,
      ),
    );
  }
}

void sendPendingJobOrderJob() async {
  while (true) {
    if (Preferences.getInstance().getString(SharedPreferenceKey.SESSION_ID) !=
        null) {
      await BackgroundService.sendPendingJobOrder();
    }

    await Future.delayed(
      Duration(
        minutes: Preferences.getInstance()
                .getInt(SharedPreferenceKey.SEND_JOB_ORDER_INTERVAL, 30) ??
            30,
      ),
    );
  }
}

class BackgroundService {
  static Future<void> initializeService() async {
    final flutterBackgroundService = FlutterBackgroundService();

    await flutterBackgroundService.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: false,
        isForegroundMode: false,
        notificationChannelId: 'Background Service',
        initialNotificationTitle: 'Background service is running',
        initialNotificationContent: 'Background service is running',
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: false,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );

    flutterBackgroundService.startService();
  }

  static Future<void> sendLocation() async {
    try {
      LongLat? longLat = await Locations.lastPosition();

      if (longLat != null) {
        SendLocationRequest sendLocationRequest = SendLocationRequest(
          longitude: longLat.longitude.toString(),
          latitude: longLat.latitude.toString(),
        );

        Response response = await ApiManager()
            .sendLocation(sendLocationRequest: sendLocationRequest);

        if (response.statusCode == 200) {
          print("Berhasil kirim lokasi...");
        } else {
          print("Gagal kirim lokasi...");
        }

        Preferences.getInstance()
            .setDouble(SharedPreferenceKey.LAST_LATITUDE, longLat.latitude);
        Preferences.getInstance()
            .setDouble(SharedPreferenceKey.LAST_LONGITUDE, longLat.longitude);
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> markAsReadInbox() async {
    try {
      List<Inbox> inboxes = InboxDao.getNotSentInboxes();

      for (Inbox inbox in inboxes) {
        Response response = await ApiManager().putMarkAsReadInbox(
          id: inbox.id,
        );

        if (response.statusCode == 200) {
          print("Berhasil update inbox...");
        } else {
          print("Gagal update inbox...");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> checkVersion(
    SynchronizationBloc? synchronizationBloc,
  ) async {
    try {
      if (synchronizationBloc != null) {
        synchronizationBloc.add(
          SynchronizationUpdateMessage(
            message: "Memeriksa versi data...",
          ),
        );
      }

      List<CheckVersionRequestDetail> checkVersionRequestDetails =
          VersionDao.check();

      CheckVersionRequest checkVersionRequest =
          CheckVersionRequest(versions: checkVersionRequestDetails);

      Response response = await ApiManager()
          .checkVersion(checkVersionRequest: checkVersionRequest);

      if (response.statusCode == 200) {
        CheckVersionResponse checkVersionResponse =
            CheckVersionResponse.fromJson(response.data);

        int completed = 0;

        for (String? version in checkVersionResponse.versions) {
          if (StringUtils.isNotNullOrEmpty(version)) {
            try {
              VersionKey versionKey = VersionKey.values.byName(version!);
              print(versionKey);

              int lastVersion = VersionDao.last(versionKey);

              if (versionKey == VersionKey.VENDOR) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data vendor...",
                    ),
                  );
                }

                Response response = await ApiManager().vendors();

                if (response.statusCode == 200 && response.data != null) {
                  VendorDao.insertOrUpdate(
                    versionKey: versionKey,
                    getVendorResponse:
                        GetVendorResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.BASE_OFFICE) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data base office...",
                    ),
                  );
                }

                Response response = await ApiManager().baseOffices();

                if (response.statusCode == 200 && response.data != null) {
                  BaseOfficeDao.insertOrUpdate(
                    versionKey: versionKey,
                    getBaseOfficeResponse:
                        GetBaseOfficeResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.SERVICE_POINT) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data service point...",
                    ),
                  );
                }

                Response response = await ApiManager().servicePoints();

                if (response.statusCode == 200 && response.data != null) {
                  ServicePointDao.insertOrUpdate(
                    versionKey: versionKey,
                    getServicePointResponse:
                        GetServicePointResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.JOB_TYPE) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data tipe pekerjaan...",
                    ),
                  );
                }

                Response response = await ApiManager().jobTypes();

                if (response.statusCode == 200 && response.data != null) {
                  JobTypeDao.insertOrUpdate(
                    versionKey: versionKey,
                    getJobTypeResponse:
                        GetJobTypeResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.DOCUMENT_STATUS) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data status dokumen...",
                    ),
                  );
                }

                Response response = await ApiManager().documentStatuses();

                if (response.statusCode == 200 && response.data != null) {
                  DocumentStatusDao.insertOrUpdate(
                    versionKey: versionKey,
                    getDocumentStatusResponse:
                        GetDocumentStatusResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.REQUEST_TYPE) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data tipe pengajuan...",
                    ),
                  );
                }

                Response response = await ApiManager().requestTypes();

                if (response.statusCode == 200 && response.data != null) {
                  RequestTypeDao.insertOrUpdate(
                    versionKey: versionKey,
                    getRequestTypeResponse:
                        GetRequestTypeResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.MMS_STATUS) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data status mms...",
                    ),
                  );
                }

                Response response = await ApiManager().mmsStatuses();

                if (response.statusCode == 200 && response.data != null) {
                  MmsStatusDao.insertOrUpdate(
                    versionKey: versionKey,
                    getMmsStatusResponse:
                        GetMmsStatusResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.PROVIDER) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data provider...",
                    ),
                  );
                }

                Response response = await ApiManager().providers();

                if (response.statusCode == 200 && response.data != null) {
                  ProviderDao.insertOrUpdate(
                    versionKey: versionKey,
                    getProviderResponse:
                        GetProviderResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.EDC_TYPE) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data tipe edc...",
                    ),
                  );
                }

                Response response = await ApiManager().edcTypes();

                if (response.statusCode == 200 && response.data != null) {
                  EdcTypeDao.insertOrUpdate(
                    versionKey: versionKey,
                    getEdcTypeResponse:
                        GetEdcTypeResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.APP_VERSION) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data app version...",
                    ),
                  );
                }

                Response response = await ApiManager().appVesion();
                // print("appVesion");
                // print(response.statusCode);
                // print(response.data);
                if (response.statusCode == 200 && response.data != null) {
                  AppVersionDao.insertOrUpdate(
                    versionKey: versionKey,
                    getAppVersionResponse:
                        GetAppVersionResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                  // if (synchronizationBloc != null) {
                  //   synchronizationBloc.add(
                  //     SynchronizationUpdateMessage(
                  //       message: throw Exception().toString(),
                  //     ),
                  //   );
                  // }
                }
              } else if (versionKey == VersionKey.OS_PATCH) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data os patch...",
                    ),
                  );
                }

                Response response = await ApiManager().osPatch();
                print("osPatch");
                print(response.statusCode);
                print(response.data);
                if (response.statusCode == 200 && response.data != null) {
                  OsPatchDao.insertOrUpdate(
                    versionKey: versionKey,
                    getOsPatchResponse:
                        GetOsPatchResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.STICKER_BANK) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data sticker bank...",
                    ),
                  );
                }

                Response response = await ApiManager().sitckerBank();
                print("sitckerBank");
                print(response.statusCode);
                print(response.data);
                if (response.statusCode == 200 && response.data != null) {
                  StickerBankDao.insertOrUpdate(
                    versionKey: versionKey,
                    getOsPatchResponse:
                        GetStickerBankResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.EDC_COMMUNICATION_TYPE) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data tipe komunikasi edc...",
                    ),
                  );
                }

                Response response = await ApiManager().edcCommunicationTypes();

                if (response.statusCode == 200 && response.data != null) {
                  EdcCommunicationTypeDao.insertOrUpdate(
                    versionKey: versionKey,
                    getEdcCommunicationTypeResponse:
                        GetEdcCommunicationTypeResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.REPLACEMENT_TYPE) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data tipe penggantian...",
                    ),
                  );
                }

                Response response = await ApiManager().replacementTypes();

                if (response.statusCode == 200 && response.data != null) {
                  ReplacementTypeDao.insertOrUpdate(
                    versionKey: versionKey,
                    getReplacementTypeResponse:
                        GetReplacementTypeResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.JOB_STATUS) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data status pekerjaan...",
                    ),
                  );
                }

                Response response = await ApiManager().jobStatuses();

                if (response.statusCode == 200 && response.data != null) {
                  JobStatusDao.insertOrUpdate(
                    versionKey: versionKey,
                    getJobStatusResponse:
                        GetJobStatusResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.JOB_STATUS_CATEGORY) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data kategori status pekerjaan...",
                    ),
                  );
                }

                Response response = await ApiManager().jobStatusCategories();

                if (response.statusCode == 200 && response.data != null) {
                  JobStatusCategoryDao.insertOrUpdate(
                    versionKey: versionKey,
                    getJobStatusCategoryResponse:
                        GetJobStatusCategoryResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.NOTE) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data catatan...",
                    ),
                  );
                }

                Response response = await ApiManager().notes();

                if (response.statusCode == 200 && response.data != null) {
                  NoteDao.insertOrUpdate(
                    versionKey: versionKey,
                    getNoteResponse: GetNoteResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.QRIS_MENU) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data menu qris...",
                    ),
                  );
                }

                Response response = await ApiManager().qrisMenus();

                if (response.statusCode == 200 && response.data != null) {
                  QrisMenuDao.insertOrUpdate(
                    versionKey: versionKey,
                    getQrisMenuResponse:
                        GetQrisMenuResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.EDC_EQUIPMENT) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data peralatan edc...",
                    ),
                  );
                }

                Response response = await ApiManager().edcEquipments();

                if (response.statusCode == 200 && response.data != null) {
                  EdcEquipmentDao.insertOrUpdate(
                    versionKey: versionKey,
                    getEdcEquipmentResponse:
                        GetEdcEquipmentResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.EDC_FEATURE_TEST_CASE) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data pengujian fitur edc...",
                    ),
                  );
                }

                Response response = await ApiManager().edcFeatureTestCases();

                if (response.statusCode == 200 && response.data != null) {
                  EdcFeatureTestCaseDao.insertOrUpdate(
                    versionKey: versionKey,
                    getEdcFeatureTestCaseResponse:
                        GetEdcFeatureTestCaseResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.JOB_CATEGORY) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data kategori pekerjaan...",
                    ),
                  );
                }

                Response response = await ApiManager().jobCategories();

                if (response.statusCode == 200 && response.data != null) {
                  JobCategoryDao.insertOrUpdate(
                    versionKey: versionKey,
                    getJobCategoryResponse:
                        GetJobCategoryResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.TRANSACTION_TEST_CASE) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data pengujian transaksi...",
                    ),
                  );
                }

                Response response = await ApiManager().transactionTestCases();

                if (response.statusCode == 200 && response.data != null) {
                  TransactionTestCaseDao.insertOrUpdate(
                    versionKey: versionKey,
                    getTransactionTestCaseResponse:
                        GetTransactionTestCaseResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.OTHER_BANK_EDC) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data edc bank lainnya...",
                    ),
                  );
                }

                Response response = await ApiManager().otherBankEdcs();

                if (response.statusCode == 200 && response.data != null) {
                  OtherBankEdcDao.insertOrUpdate(
                    versionKey: versionKey,
                    getOtherBankEdcResponse:
                        GetOtherBankEdcResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.DOR_MENU) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data menu dor...",
                    ),
                  );
                }

                Response response = await ApiManager().dorMenus();

                if (response.statusCode == 200 && response.data != null) {
                  DorMenuDao.insertOrUpdate(
                    versionKey: versionKey,
                    getDorMenuResponse:
                        GetDorMenuResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.MARCOLL_UPDATE_STATUS) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data status update marcoll...",
                    ),
                  );
                }

                Response response = await ApiManager().marcollUpdateStatuses();

                if (response.statusCode == 200 && response.data != null) {
                  MarcollUpdateStatusDao.insertOrUpdate(
                    versionKey: versionKey,
                    getMarcollUpdateStatusResponse:
                        GetMarcollUpdateStatusResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.EOS_UPDATE_STATUS) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data status update eos...",
                    ),
                  );
                }

                Response response = await ApiManager().eosUpdateStatuses();

                if (response.statusCode == 200 && response.data != null) {
                  EosUpdateStatusDao.insertOrUpdate(
                    versionKey: versionKey,
                    getEosUpdateStatusResponse:
                        GetEosUpdateStatusResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.TRAINING_MATERIAL) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data materi pelatihan...",
                    ),
                  );
                }

                Response response = await ApiManager().trainingMaterials();

                if (response.statusCode == 200 && response.data != null) {
                  TrainingMaterialDao.insertOrUpdate(
                    versionKey: versionKey,
                    getTrainingMaterialResponse:
                        GetTrainingMaterialResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.DAMAGE_TYPE) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data tipe kerusakan...",
                    ),
                  );
                }

                Response response = await ApiManager().damageTypes();

                if (response.statusCode == 200 && response.data != null) {
                  DamageTypeDao.insertOrUpdate(
                    versionKey: versionKey,
                    getDamageTypeResponse:
                        GetDamageTypeResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.SN_STOCK) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data stok sn...",
                    ),
                  );
                }

                Response response = await ApiManager().snStocks();

                if (response.statusCode == 200 && response.data != null) {
                  SnStockDao.insertOrUpdate(
                    versionKey: versionKey,
                    getSnStockResponse:
                        GetSnStockResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.NON_SN_STOCK) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data stok non sn...",
                    ),
                  );
                }

                Response response = await ApiManager().nonSnStocks();

                if (response.statusCode == 200 && response.data != null) {
                  NonSnStockDao.insertOrUpdate(
                    versionKey: versionKey,
                    getNonSnStockResponse:
                        GetNonSnStockResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.INBOX) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data pesan...",
                    ),
                  );
                }

                Response response =
                    await ApiManager().inboxes(version: lastVersion);

                if (response.statusCode == 200 && response.data != null) {
                  InboxDao.insertOrUpdate(
                    versionKey: versionKey,
                    getInboxResponse: GetInboxResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              } else if (versionKey == VersionKey.JOB_ORDER) {
                if (synchronizationBloc != null) {
                  synchronizationBloc.add(
                    SynchronizationUpdateMessage(
                      message: "Mengunduh data job order...",
                    ),
                  );
                }

                Response response =
                    await ApiManager().getJobOrders(version: lastVersion);

                if (response.statusCode == 200 && response.data != null) {
                  JobOrderDao.addJobOrder(
                    versionKey: versionKey,
                    getJobOrderResponse:
                        GetJobOrderResponse.fromJson(response.data),
                  );

                  completed++;
                } else {
                  throw Exception();
                }
              }

              if (synchronizationBloc != null) {
                synchronizationBloc.add(
                  SynchronizationUpdateProgress(
                    progress: completed,
                    total: checkVersionResponse.versions.length,
                    versionStatus: {
                      VersionKey.values.byName(version).alias: true
                    },
                  ),
                );
              }
            } catch (error, stacktrace) {
              print("error: $error, stacktrace: $stacktrace");

              if (synchronizationBloc != null) {
                completed++;

                synchronizationBloc.add(
                  SynchronizationUpdateProgress(
                    progress: completed,
                    total: checkVersionResponse.versions.length,
                    versionStatus: {
                      VersionKey.values.byName(version!).alias: false
                    },
                  ),
                );
              }
            }
          }
        }

        await updateLastSynchronization();
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> updateLastSynchronization() async {
    await Preferences.getInstance().reload();

    Preferences.getInstance().setString(
      SharedPreferenceKey.LAST_VERSIONING,
      DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
    );
  }

  static Future<void> sendPendingJobOrder() async {
    try {
      List<JobOrder> jobOrders = JobOrderDao.pendings();

      for (JobOrder jobOrder in jobOrders) {
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

        if (jobOrder.merchant != null) {
          if (jobOrder.merchant!.signature != null) {
            merchantSignature = Uint8List.fromList(
              jobOrder.merchant!.signature!.file,
            );
          }

          for (ImageFile imageFile in jobOrder.merchant!.images) {
            merchantImages.add(
              Uint8List.fromList(
                imageFile.file,
              ),
            );
          }
        }

        if (jobOrder.machineAndCard != null) {
          for (ImageFile imageFile
              in jobOrder.machineAndCard!.serialNumberPhotos) {
            machineSerialNumberPhotos.add(
              Uint8List.fromList(
                imageFile.file,
              ),
            );
          }

          for (ImageFile imageFile in jobOrder.machineAndCard!.images) {
            machineImages.add(
              Uint8List.fromList(
                imageFile.file,
              ),
            );
          }

          // Add here
          for (ImageFile imageFile in jobOrder.machineAndCard!.picMerchantImages) {
            picMerchantImages.add(
              Uint8List.fromList(
                imageFile.file,
              ),
            );
          }

          for (ImageFile imageFile in jobOrder.machineAndCard!.rollSalesDraftImages) {
            rollSalesDraftImages.add(
              Uint8List.fromList(
                imageFile.file,
              ),
            );
          }

          for (ImageFile imageFile in jobOrder.machineAndCard!.trainingStatementLetterImages) {
            trainingStatementLetterImages.add(
              Uint8List.fromList(
                imageFile.file,
              ),
            );
          }

          for (ImageFile imageFile in jobOrder.machineAndCard!.edcAppImages) {
            edcAppImages.add(
              Uint8List.fromList(
                imageFile.file,
              ),
            );
          }

          for (ImageFile imageFile in jobOrder.machineAndCard!.otherImages) {
            otherImages.add(
              Uint8List.fromList(
                imageFile.file,
              ),
            );
          }
        }

        if (jobOrder.transactionTest != null) {
          for (ImageFile imageFile in jobOrder.transactionTest!.images) {
            transactionTestImages.add(
              Uint8List.fromList(
                imageFile.file,
              ),
            );
          }
        }

        if (jobOrder.qris != null) {
          for (ImageFile imageFile in jobOrder.qris!.qrisReceiptImages) {
            qrisReceiptImages.add(
              Uint8List.fromList(
                imageFile.file,
              ),
            );
          }

          for (ImageFile imageFile
              in jobOrder.qris!.brizziInstallmentReceiptImages) {
            brizziInstallmentReceiptImages.add(
              Uint8List.fromList(
                imageFile.file,
              ),
            );
          }
        }

        SendJobOrder sendJobOrder = SendJobOrder.build(jobOrder);

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
          otherImages: otherImages,
        );

        if (response.statusCode == 200) {
          JobOrderDao.synced(jobOrder);
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
