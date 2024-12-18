import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rtracker/api/api_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rtracker/api/endpoint/master/inbox/get_inbox_response.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/helper/navigators.dart';
import 'package:rtracker/module/inbox/inbox_page.dart';
import 'package:rtracker/realm/inbox_dao.dart';
import 'package:rtracker/realm/version_dao.dart';

class Notifications {
  static void showNotification({
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    String? title,
    String? body,
    String? imageUrl,
    Map<String, dynamic>? data,
  }) async {
    ByteArrayAndroidBitmap? byteArrayAndroidBitmap;

    if (imageUrl != null) {
      byteArrayAndroidBitmap = ByteArrayAndroidBitmap(
        await ApiManager().download(
          url: imageUrl,
        ),
      );
    }

    AndroidNotificationDetails androidNotificationDetails;

    if (byteArrayAndroidBitmap != null) {
      androidNotificationDetails = AndroidNotificationDetails(
        "Umum",
        "Umum",
        channelDescription: "Notifikasi Umum",
        importance: Importance.max,
        playSound: true,
        priority: Priority.high,
        styleInformation: BigPictureStyleInformation(
          byteArrayAndroidBitmap,
          largeIcon: byteArrayAndroidBitmap,
          hideExpandedLargeIcon: true,
        ),
        largeIcon: byteArrayAndroidBitmap,
      );
    } else {
      androidNotificationDetails = const AndroidNotificationDetails(
        "Umum",
        "Umum",
        channelDescription: "Notifikasi Umum",
        importance: Importance.max,
        playSound: true,
        priority: Priority.high,
      );
    }

    DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails();

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: json.encode(data),
    );
  }

  static void onNotificationTapped(Map<String, dynamic>? data) async {
    if (data != null) {
      try {
        Response response = await ApiManager().inboxes(version: VersionDao.last(VersionKey.INBOX));

        if (response.statusCode == 200 && response.data != null) {
          InboxDao.insertOrUpdate(
            versionKey: VersionKey.INBOX,
            getInboxResponse: GetInboxResponse.fromJson(response.data),
          );
        }
      } catch (e) {
        print(e);
      }

      Navigators.push(
        Navigators.navigatorState.currentContext!,
        const InboxPage(),
      );
    }
  }
}
