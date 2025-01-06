import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/io.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rtracker/api/endpoint/forgot_password/forgot_password_request.dart';
import 'package:rtracker/api/endpoint/master/check_version/check_version_request.dart';
import 'package:rtracker/api/endpoint/send_location/send_location_request.dart';
import 'package:rtracker/api/endpoint/transaction/send_job_order.dart';
import 'package:rtracker/api/interceptor/authorization_interceptor.dart';
import 'package:rtracker/api/interceptor/custom_log_interceptor.dart';
import 'package:rtracker/api/interceptor/logging_interceptor.dart';
import 'package:rtracker/constant.dart';
import 'package:dio/dio.dart';
import 'package:rtracker/helper/locations.dart';
import 'package:rtracker/helper/preferences.dart';
import 'package:http_parser/http_parser.dart';

import 'endpoint/login/login_request.dart';

class ApiManager {
  static Map<String, dynamic> setupVersionParams(int version) =>
      {'version': version};

  static Future<Options> httpOptions() async {
    int offset = DateTime.now().timeZoneOffset.inHours;

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    Map<String, dynamic> headers = {
      'X-RTracker-Version': packageInfo.version,
      'X-RTracker-Timezone': 'GMT+$offset'
    };

    try {
      LongLat? longLat = await Locations.lastPosition();

      if (longLat != null) {
        headers["X-RTracker-Latitude"] = longLat.latitude;
        headers["X-RTracker-Longitude"] = longLat.longitude;
      }
    } catch (e) {
      print(e);
    }

    return Options(
      headers: headers,
    );
  }

  static Future<Dio> getDio({
    bool withoutAuthorizationInterceptor = false,
    bool plain = false,
  }) async {
    String baseUrl = ApiUrl.MAIN_BASE;

    if (Preferences.getInstance().getBool(SharedPreferenceKey.MOCK) ?? false) {
      baseUrl = ApiUrl.MOCK_BASE;
    }

    print(Preferences.getInstance().getString(SharedPreferenceKey.SESSION_ID));

    Dio dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        contentType: Headers.jsonContentType,
        responseDecoder: (responseBytes, options, responseBody) {
          if (plain || responseBody.statusCode != 200) {
            options.responseType = ResponseType.plain;
          }

          return utf8.decode(responseBytes, allowMalformed: true);
        },
      ),
    );

    if (!withoutAuthorizationInterceptor) {
      dio.interceptors.add(AuthorizationInterceptor());
    }

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    // dio.interceptors.add(CustomLogInterceptor());
    dio.interceptors.add(LoggingInterceptor());

    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback = (cert, host, port) => true;

      return client;
    };

    return dio;
  }

  Future<Uint8List> download({
    required String url,
  }) async {
    try {
      Dio dio = Dio();

      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;

        return client;
      };

      Response response = await dio.get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );

      return response.data;
    } catch (error, stacktrace) {
      print("error: $error, stacktrace: $stacktrace");
    }

    return Uint8List(0);
  }

  Future<Response?> updateFcmToken({
    required String fcmToken,
  }) async {
    return null;
  }

  Future<Response> login({
    required LoginRequest loginRequest,
  }) async {
    Dio dio = await getDio();

    Response response = await dio.post(
      ApiUrl.LOGIN,
      data: loginRequest,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> forgotPassword({
    required ForgotPasswordRequest forgotPasswordRequest,
  }) async {
    Dio dio = await getDio();

    Response response = await dio.post(
      ApiUrl.FORGOT_PASSWORD,
      data: forgotPasswordRequest,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> logout() async {
    Dio dio = await getDio();

    Response response = await dio.delete(
      ApiUrl.LOGOUT,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> sendLocation({
    required SendLocationRequest sendLocationRequest,
  }) async {
    Dio dio = await getDio();

    Response response = await dio.post(
      ApiUrl.SEND_LOCATION,
      data: sendLocationRequest,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> checkVersion({
    required CheckVersionRequest checkVersionRequest,
  }) async {
    Dio dio = await getDio();

    Response response = await dio.post(
      ApiUrl.CHECK_VERSION,
      data: checkVersionRequest,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> vendors() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.VENDORS,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> baseOffices() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.BASE_OFFICES,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> servicePoints() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.SERVICE_POINTS,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> jobTypes() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.JOB_TYPES,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> documentStatuses() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.DOCUMENT_STATUSES,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> requestTypes() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.REQUEST_TYPES,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> mmsStatuses() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.MMS_STATUSES,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> providers() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.PROVIDERS,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> edcTypes() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.EDC_TYPES,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> appVesion() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.APP_VERSION,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> osPatch() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.OS_PATCH,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> sitckerBank() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.STICKER_BANK,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> edcCommunicationTypes() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.EDC_COMMUNICATION_TYPES,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> replacementTypes() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.REPLACEMENT_TYPES,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> jobStatuses() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.JOB_STATUSES,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> jobStatusCategories() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.JOB_STATUS_CATEGORIES,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> notes() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.NOTES,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> qrisMenus() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.QRIS_MENUS,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> edcEquipments() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.EDC_EQUIPMENTS,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> edcFeatureTestCases() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.EDC_FEATURE_TEST_cASES,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> jobCategories() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.JOB_CATEGORIES,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> transactionTestCases() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.TRANSACTION_TEST_CASES,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> otherBankEdcs() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.OTHER_BANK_EDCS,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> dorMenus() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.DOR_MENUS,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> marcollUpdateStatuses() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.MARCOLL_UPDATE_STATUSES,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> eosUpdateStatuses() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.EOS_UPDATE_STATUSES,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> trainingMaterials() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.TRAINING_MATERIALS,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> damageTypes() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.DAMAGE_TYPES,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> snStocks() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.SN_STOCKS,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> nonSnStocks() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.NON_SN_STOCKS,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> inboxes({
    required int version,
  }) async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.INBOXES,
      queryParameters: setupVersionParams(version),
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> putMarkAsReadInbox({
    required String id,
  }) async {
    Dio dio = await getDio();

    Response response = await dio.put(
      '${ApiUrl.INBOXES}/$id/mark-as-read',
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> getJobOrders({
    required int version,
  }) async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.JOB_ORDERS,
      queryParameters: setupVersionParams(version),
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> postJobOrders({
    Uint8List? merchantSignature,
    required List<Uint8List> merchantImages,
    required List<Uint8List> machineImages,
    required List<Uint8List> machineSerialNumberPhotos,
    required List<Uint8List> transactionTestImages,
    required List<Uint8List> qrisReceiptImages,
    required List<Uint8List> brizziInstallmentReceiptImages,
    required SendJobOrder sendJobOrder,
    required List<Uint8List> picMerchantImages,
    required List<Uint8List> rollSalesDraftImages,
    required List<Uint8List> trainingStatementLetterImages,
    required List<Uint8List> edcAppImages,
    required List<Uint8List> otherImages,
  }) async {
    Dio dio = await getDio();

    FormData formData = FormData();

    if (merchantSignature != null && merchantSignature.isNotEmpty) {
      formData.files.add(
        MapEntry(
          'merchantSignature',
          MultipartFile.fromBytes(
            merchantSignature,
            filename: "image.png",
            contentType: MediaType('image', 'png'),
          ),
        ),
      );
    }

    for (Uint8List merchantImage in merchantImages) {
      formData.files.add(
        MapEntry(
          'merchantImages[]',
          MultipartFile.fromBytes(
            merchantImage,
            filename: "image.png",
            contentType: MediaType('image', 'png'),
          ),
        ),
      );
    }

    for (Uint8List machineImage in machineImages) {
      formData.files.add(
        MapEntry(
          'machineImages[]',
          MultipartFile.fromBytes(
            machineImage,
            filename: "image.png",
            contentType: MediaType('image', 'png'),
          ),
        ),
      );
    }

    for (Uint8List machineSerialNumberPhoto in machineSerialNumberPhotos) {
      formData.files.add(
        MapEntry(
          'machineSerialNumberPhotos[]',
          MultipartFile.fromBytes(
            machineSerialNumberPhoto,
            filename: "image.png",
            contentType: MediaType('image', 'png'),
          ),
        ),
      );
    }

    for (Uint8List transactionTestImage in transactionTestImages) {
      formData.files.add(
        MapEntry(
          'transactionTestImages[]',
          MultipartFile.fromBytes(
            transactionTestImage,
            filename: "image.png",
            contentType: MediaType('image', 'png'),
          ),
        ),
      );
    }

    for (Uint8List qrisReceiptImage in qrisReceiptImages) {
      formData.files.add(
        MapEntry(
          'qrisReceiptImages[]',
          MultipartFile.fromBytes(
            qrisReceiptImage,
            filename: "image.png",
            contentType: MediaType('image', 'png'),
          ),
        ),
      );
    }

    for (Uint8List brizziInstallmentReceiptImage
        in brizziInstallmentReceiptImages) {
      formData.files.add(
        MapEntry(
          'brizziInstallmentReceiptImages[]',
          MultipartFile.fromBytes(
            brizziInstallmentReceiptImage,
            filename: "image.png",
            contentType: MediaType('image', 'png'),
          ),
        ),
      );
    }

    // Add new Image
    for (Uint8List image in picMerchantImages) {
      formData.files.add(
        MapEntry(
          'picMerchantImages[]',
          MultipartFile.fromBytes(
            image,
            filename: "image.png",
            contentType: MediaType('image', 'png'),
          ),
        ),
      );
    }

    for (Uint8List image in rollSalesDraftImages) {
      formData.files.add(
        MapEntry(
          'rollSalesDraftImages[]',
          MultipartFile.fromBytes(
            image,
            filename: "image.png",
            contentType: MediaType('image', 'png'),
          ),
        ),
      );
    }

    for (Uint8List image in trainingStatementLetterImages) {
      formData.files.add(
        MapEntry(
          'trainingStatementLetterImages[]',
          MultipartFile.fromBytes(
            image,
            filename: "image.png",
            contentType: MediaType('image', 'png'),
          ),
        ),
      );
    }

    for (Uint8List image in edcAppImages) {
      formData.files.add(
        MapEntry(
          'edcAppImages[]',
          MultipartFile.fromBytes(
            image,
            filename: "image.png",
            contentType: MediaType('image', 'png'),
          ),
        ),
      );
    }

    for (Uint8List image in otherImages) {
      formData.files.add(
        MapEntry(
          'otherImages[]',
          MultipartFile.fromBytes(
            image,
            filename: "image.png",
            contentType: MediaType('image', 'png'),
          ),
        ),
      );
    }

    formData.files.add(
      MapEntry(
        'data',
        MultipartFile.fromString(
          jsonEncode(sendJobOrder.toJson()),
          contentType: MediaType('application', 'json'),
        ),
      ),
    );

    Response response = await dio.post(
      ApiUrl.JOB_ORDERS,
      data: formData,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> sendTerimaSnStock({
    required String serialNumber,
  }) async {
    Dio dio = await getDio(plain: true);

    Response response = await dio.post(
      ApiUrl.SEND_TERIMA_SN_STOCK,
      data: {"serialNumber": serialNumber},
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> terimaSnStock() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.TERIMA_SN_STOCK,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> sendTerimaNonSnStock({
    required String id,
    required String productId,
    required String quantity,
  }) async {
    Dio dio = await getDio(plain: true);

    Response response = await dio.post(
      ApiUrl.SEND_TERIMA_NON_SN_STOCK,
      data: {"id": id, "productId": productId, "quantityInput": quantity},
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> terimaNonSnStock() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.TERIMA_SN_NON_STOCK,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> snStockPortal() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.SN_STOCK_PORTAL,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> nonSnStockPortal() async {
    Dio dio = await getDio();

    Response response = await dio.get(
      ApiUrl.NON_SN_STOCK_PORTAL,
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> sendSnRequestRetur({
    required String id,
    required String condition,
    required String serialNumber,
    required String note,
  }) async {
    Dio dio = await getDio(plain: true);

    Response response = await dio.post(
      ApiUrl.SEND_SN_REQUEST_RETUR,
      data: {
        "id": id,
        "kondisi": condition,
        "serialNumber": serialNumber,
        "keterangan": note
      },
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> sendNonSnRequestRetur({
    required String id,
    required String condition,
    required String productId,
    required String quantity,
    required String note,
  }) async {
    Dio dio = await getDio(plain: true);

    Response response = await dio.post(
      ApiUrl.SEND_NON_SN_REQUEST_RETUR,
      data: {
        "id": id,
        "kondisi": condition,
        "productId": productId,
        "quantityRetur": quantity,
        "keterangan": note,
      },
      options: await httpOptions(),
    );

    return response;
  }

  Future<Response> syncFinishedJo({
    required List<String> ids,
  }) async {
    Dio dio = await getDio(plain: true);

    Response response = await dio.post(
      ApiUrl.SYNC_FINISHED_JO,
      data: {
        "data": ids,
      },
      options: await httpOptions(),
    );

    return response;
  }
}
