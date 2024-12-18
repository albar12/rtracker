import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:rtracker/api/api_manager.dart';
import 'package:rtracker/api/endpoint/login/login_response.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/helper/app_colors.dart';
import 'package:rtracker/helper/navigators.dart';
import 'package:rtracker/helper/notifications.dart';
import 'package:rtracker/helper/preferences.dart';
import 'package:rtracker/module/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:rtracker/module/home/bloc/home_bloc.dart';
import 'package:rtracker/module/home/home_page.dart';
import 'package:rtracker/module/inbox/bloc/inbox_bloc.dart';
import 'package:rtracker/module/job_filter/bloc/job_filter_bloc.dart';
import 'package:rtracker/module/job_form/bloc/job_form_bloc.dart';
import 'package:rtracker/module/job_list/job_list_bloc.dart';
import 'package:rtracker/module/profile/profile_bloc.dart';
import 'package:rtracker/module/sign_in/bloc/sign_in_bloc.dart';
import 'package:rtracker/module/sign_in/sign_in_page.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:dio/dio.dart' as dio;
import 'package:rtracker/module/stok_barang/stok_barang_bloc.dart';
import 'package:rtracker/module/synchronization/synchronization_bloc.dart';
import 'package:rtracker/module/terima_barang/terima_barang_bloc.dart';
import 'package:rtracker/service/background_service.dart';

Future<void> firebaseCloudMessagingInitialization() async {
  try {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: (details) {
        if (StringUtils.isNotNullOrEmpty(details.payload)) {
          Map<String, dynamic>? data = json.decode(details.payload!);

          Notifications.onNotificationTapped(data);
        }
      },
    );

    String? fcmToken = await FirebaseMessaging.instance.getToken();

    if (StringUtils.isNotNullOrEmpty(fcmToken)) {
      print("Mendapatkan fcm token baru: $fcmToken");

      if (Preferences.getInstance().contain(SharedPreferenceKey.SESSION_ID)) {
        try {
          dio.Response? response =
              await ApiManager().updateFcmToken(fcmToken: fcmToken!);

          if (response != null) {
            if (response.statusCode == 200) {
              print("Berhasil memperbarui fcm token.");
            } else {
              print("Gagal memperbarui fcm token.");
            }
          }
        } catch (e, stacktrace) {
          print("Error: $e");
          print("Stacktrace: $stacktrace");
        }
      }
    }

    FirebaseMessaging.instance.onTokenRefresh.listen((event) async {
      print("Mendapatkan fcm token baru: $event");

      if (Preferences.getInstance().contain(SharedPreferenceKey.SESSION_ID)) {
        try {
          dio.Response? response =
              await ApiManager().updateFcmToken(fcmToken: event);

          if (response != null) {
            if (response.statusCode == 200) {
              print("Berhasil memperbarui fcm token.");
            } else {
              print("Gagal memperbarui fcm token.");
            }
          }
        } catch (e, stacktrace) {
          print("Error: $e");
          print("Stacktrace: $stacktrace");
        }
      }
    });

    // Handler memunculkan notifikasi ketika aplikasi sedang diforeground
    FirebaseMessaging.onMessage.listen((event) {
      if (event.notification != null) {
        String? imageUrl;

        if (event.notification!.android != null) {
          imageUrl = event.notification!.android!.imageUrl;
        }

        Notifications.showNotification(
          flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
          title: event.notification!.title,
          body: event.notification!.body,
          imageUrl: imageUrl,
          data: event.data,
        );
      }
    });

    // Handler ketika notifikasi diklik ketika aplikasi sedang dibackground
    FirebaseMessaging.onMessageOpenedApp
        .listen((event) => Notifications.onNotificationTapped(event.data));
  } catch (ex) {
    print(ex);
  }
}

@pragma('vm:entry-point')
Future<void> firebaseCloudMessagingBackgroundHandler(
  RemoteMessage remoteMessage,
) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await BackgroundService.initializeService();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }

  initializeDateFormatting();

  await Preferences.getInstance().init();

  // if (!Preferences.getInstance().contain(SharedPreferenceKey.MOCK)) {
  //   Preferences.getInstance().setBool(SharedPreferenceKey.MOCK, true);
  // }

  FirebaseMessaging.onBackgroundMessage(
    firebaseCloudMessagingBackgroundHandler,
  );

  await firebaseCloudMessagingInitialization();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignInBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => ForgotPasswordBloc()),
        BlocProvider(create: (context) => JobListBloc()),
        BlocProvider(create: (context) => JobFilterBloc()),
        BlocProvider(create: (context) => JobFormBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(create: (context) => SynchronizationBloc()),
        BlocProvider(create: (context) => InboxBloc()),
        BlocProvider(create: (context) => TerimaBarangBloc()),
        BlocProvider(create: (context) => StokBarangBloc()),
      ],
      child: GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: const Center(
          child: SpinKitFadingCube(
            color: AppColors.primary,
            size: 50,
          ),
        ),
        overlayColor: Colors.black,
        overlayOpacity: 0.8,
        child: DismissibleKeyboard(
          widget: GetMaterialApp(
            title: 'RTracker',
            navigatorKey: Navigators.navigatorState,
            theme: ThemeData(
              fontFamily: 'Droid Sans',
              primarySwatch: AppColors.primarySwatch,
              primaryColor: AppColors.primary,
              brightness: Brightness.light,
              scaffoldBackgroundColor: AppColors.primary,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primarySwatch,
              ),
              textTheme: const TextTheme(
                bodyMedium: TextStyle(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            darkTheme: ThemeData(
              fontFamily: 'Droid Sans',
              brightness: Brightness.dark,
              textTheme: const TextTheme(
                bodyLarge: TextStyle(
                  color: AppColors.textPrimaryDark,
                ),
                bodyMedium: TextStyle(
                  color: AppColors.textPrimaryDark,
                ),
              ).apply(
                bodyColor: AppColors.textPrimaryDark,
                displayColor: AppColors.textPrimaryDark,
              ),
              colorScheme: const ColorScheme.dark(primary: AppColors.base),
            ),
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child ?? Container(),
              );
            },
            home: home(),
          ),
        ),
      ),
    );
  }

  Widget home() {
    if (Preferences.getInstance().contain(SharedPreferenceKey.SESSION_ID)) {
      String loginResponse = Preferences.getInstance()
              .getString(SharedPreferenceKey.LOGIN_RESPONSE) ??
          '{}';

      return HomePage(
        loginResponse: LoginResponse.fromJson(jsonDecode(loginResponse)),
      );
    } else {
      return const SignInPage();
    }
  }
}

class DismissibleKeyboard extends StatelessWidget {
  final Widget widget;

  const DismissibleKeyboard({
    Key? key,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode focusScopeNode = FocusScope.of(context);

        if (!focusScopeNode.hasPrimaryFocus &&
            focusScopeNode.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: widget,
    );
  }
}
