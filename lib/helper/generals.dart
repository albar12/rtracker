import 'dart:convert';
import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/helper/navigators.dart';
import 'package:rtracker/helper/preferences.dart';
import 'package:flutter/material.dart';
import 'package:rtracker/module/sign_in/sign_in_page.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/service/background_service.dart';

import 'package:rtracker/api/endpoint/login/login_response.dart';

class Generals {
  static Future<String> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      return "0000000000000000";
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;

      return androidDeviceInfo.id;
    }
  }

  static void signOut({
    required BuildContext buildContext,
  }) async {
    Preferences.getInstance().clear();

    Realms.clear();

    FlutterBackgroundService flutterBackgroundService = FlutterBackgroundService();

    flutterBackgroundService.invoke(BackgroundServiceCommand.STOP.name);

    Navigators.pushAndRemoveAll(buildContext, const SignInPage());
  }

  static void signIn({
    required LoginResponse loginResponse,
  }) {
    Preferences.getInstance().setString(SharedPreferenceKey.SESSION_ID, loginResponse.sessionId);
    Preferences.getInstance().setString(
      SharedPreferenceKey.LOGIN_RESPONSE,
      jsonEncode(loginResponse),
    );
    Preferences.getInstance().setBool(
      SharedPreferenceKey.MERCHANT_IMAGE_ALLOW_GALLERY,
      loginResponse.merchantImageAllowGallery,
    );
    Preferences.getInstance().setBool(
      SharedPreferenceKey.MACHINE_IMAGE_ALLOW_GALLERY,
      loginResponse.machineImageAllowGallery,
    );
    Preferences.getInstance().setBool(
      SharedPreferenceKey.MACHINE_SERIAL_NUMBER_PHOTO_ALLOW_GALLERY,
      loginResponse.machineSerialNumberPhotoAllowGallery,
    );
    Preferences.getInstance().setBool(
      SharedPreferenceKey.TRANSACTION_TEST_IMAGE_ALLOW_GALLERY,
      loginResponse.transactionTestImageAllowGallery,
    );
    Preferences.getInstance().setBool(
      SharedPreferenceKey.QRIS_RECEIPT_IMAGE_ALLOW_GALLERY,
      loginResponse.qrisReceiptImageAllowGallery,
    );
    Preferences.getInstance().setBool(
      SharedPreferenceKey.BRIZZI_INSTALLMENT_RECEIPT_IMAGE_ALLOW_GALLERY,
      loginResponse.brizziInstallmentReceiptImageAllowGallery,
    );

    Preferences.getInstance().setInt(
      SharedPreferenceKey.CHECK_VERSION_INTERVAL,
      loginResponse.checkVersionInterval ?? 1,
    );
    Preferences.getInstance().setInt(
      SharedPreferenceKey.SEND_LOCATION_INTERVAL,
      loginResponse.sendLocationInterval ?? 5,
    );
    Preferences.getInstance().setInt(
      SharedPreferenceKey.SEND_JOB_ORDER_INTERVAL,
      loginResponse.sendJobOrderInterval ?? 30,
    );
    Preferences.getInstance().setInt(SharedPreferenceKey.PAUSE_MAX, loginResponse.pauseMax ?? 5);
    // New Allow Gallery
    Preferences.getInstance().setBool(
      SharedPreferenceKey.PIC_MERCHANT_IMAGE_ALLOW_GALLERY,
      loginResponse.picMerchantImagesAllowGallery,
    );
    Preferences.getInstance().setBool(
      SharedPreferenceKey.ROLL_SALES_DRAFT_IMAGE_ALLOW_GALLERY,
      loginResponse.rollSalesDraftImagesAllowGallery,
    );
    Preferences.getInstance().setBool(
      SharedPreferenceKey.TRAINING_STATEMENT_LETTER_IMAGE_ALLOW_GALLERY,
      loginResponse.trainingStatementLetterImagesAllowGallery,
    );
    Preferences.getInstance().setBool(
      SharedPreferenceKey.EDC_APP_IMAGE_ALLOW_GALLERY,
      loginResponse.edcAppImagesAllowGallery,
    );
    Preferences.getInstance().setBool(
      SharedPreferenceKey.OTHER_IMAGE_ALLOW_GALLERY,
      loginResponse.otherImagesAllowGallery,
    );
    if (StringUtils.isNotNullOrEmpty(loginResponse.webPortalUrl)) {
      Preferences.getInstance().setString(
        SharedPreferenceKey.WEB_PORTAL_URL,
        loginResponse.webPortalUrl,
      );
    }
  }
}
