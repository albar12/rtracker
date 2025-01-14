import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:basic_utils/basic_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rtracker/api/endpoint/login/login_response.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/helper/app_colors.dart';
import 'package:rtracker/helper/bottom_sheets.dart';
import 'package:rtracker/helper/dialogs.dart';
import 'package:rtracker/helper/dimensions.dart';
import 'package:rtracker/helper/extensions.dart';
import 'package:rtracker/helper/formats.dart';
import 'package:rtracker/helper/generals.dart';
import 'package:rtracker/helper/navigators.dart';
import 'package:rtracker/helper/notifications.dart';
import 'package:rtracker/helper/preferences.dart';
import 'package:rtracker/helper/strings.dart';
import 'package:rtracker/module/home/bloc/home_bloc.dart';
import 'package:rtracker/module/home/bloc/home_event.dart';
import 'package:rtracker/module/home/bloc/home_state.dart';
import 'package:rtracker/module/inbox/inbox_page.dart';
import 'package:rtracker/module/job_list/job_list_page.dart';
import 'package:rtracker/module/profile/profile_page.dart';
import 'package:rtracker/module/stok_barang/stok_barang_page.dart';
import 'package:rtracker/module/synchronization/synchronization_page.dart';
import 'package:rtracker/module/terima_barang/terima_barang_page.dart';
import 'package:rtracker/realm/job_order_dao.dart';
import 'package:rtracker/widget/text_sheet.dart';

class HomePage extends StatefulWidget {
  final LoginResponse loginResponse;
  final Map<String, bool> syncStatuses;

  const HomePage({
    Key? key,
    required this.loginResponse,
    this.syncStatuses = const {},
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  Timer? timer;
  DateTime? lastSynchronization;

  void checkPhoneNumber() async {
    var status = await Permission.phone.status;
    if (!status.isGranted) {
      status = await Permission.phone.request();
    }

    if (status.isGranted) {
      MobileNumber.getSimCards?.then((value) {
        for (SimCard simCard in value){
          var number = simCard.number;
          if (number != null){
          }
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkPhoneNumber();
    try {
      if (Preferences.getInstance()
          .contain(SharedPreferenceKey.LAST_VERSIONING)) {
        lastSynchronization = DateTime.parse(
          Preferences.getInstance()
                  .getString(SharedPreferenceKey.LAST_VERSIONING) ??
              "",
        );
      }
    } catch (ex) {
      print(ex);
    }

    timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      await Preferences.getInstance().reload();

      try {
        if (Preferences.getInstance()
            .contain(SharedPreferenceKey.LAST_VERSIONING)) {
          setState(() {
            lastSynchronization = DateTime.parse(
              Preferences.getInstance()
                      .getString(SharedPreferenceKey.LAST_VERSIONING) ??
                  "",
            );
          });
        }
      } catch (ex) {
        print(ex);
      }
    });

    if (widget.syncStatuses.isNotEmpty) {
      Future.delayed(
        Duration.zero,
        () {
          Dialogs.syncStatus(
            context: context,
            syncStatuses: widget.syncStatuses,
          );
        },
      );
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Handler ketika notifikasi diklik ketika aplikasi sudah diterminated
      RemoteMessage? remoteMessage =
          await FirebaseMessaging.instance.getInitialMessage();

      if (remoteMessage != null) {
        print("Mendapatkan firebase initial message: ${json.encode(
          remoteMessage.data,
        )}.");

        Notifications.onNotificationTapped(remoteMessage.data);
      }
    });

    context.read<HomeBloc>().add(HomeStarted());
  }

  @override
  void dispose() {
    super.dispose();

    if (timer != null) {
      timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeSignedOut) {
            Generals.signOut(buildContext: context);
          } else if (state is HomeError) {
            Dialogs.message(context: context, title: state.errorMsg);
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: Container(
            padding: EdgeInsets.all(Dimensions.width15),
            child: ListView(
              children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: const TextSheet(
                    'RTracker',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            widget.loginResponse.photo,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.person_outline,
                              color: Theme.of(context).colorScheme.primary,
                              size: 160,
                            ),
                            fit: BoxFit.cover,
                            width: 160,
                            height: 160,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(80),
                            onTap: () {
                              Navigators.push(
                                context,
                                ProfilePage(
                                  loginResponse: widget.loginResponse,
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.height10,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 24,
                      ),
                      children: [
                        const TextSpan(text: 'Hello, '),
                        TextSpan(
                          text: Strings.firstWord(
                            widget.loginResponse.name,
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height5),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.height5,
                    horizontal: Dimensions.width20,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextSheet(
                            'Sinkronisasi Terakhir',
                            fontWeight: FontWeight.w300,
                          ),
                          TextSheet(
                            Formats.convertToAgo(
                              lastSynchronization,
                            ),
                            fontWeight: FontWeight.bold,
                          )
                        ],
                      ),
                      SizedBox(width: Dimensions.width10),
                      TextButton(
                        onPressed: () {
                          Navigators.pushReplacement(
                            context,
                            const SynchronizationPage(),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.sync,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            SizedBox(width: Dimensions.width5),
                            const Text("Sinkron Sekarang"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height10),
                menu(
                  color: const Color(0xffF2994A),
                  onTap: () {
                    Navigators.push(
                      context,
                      const JobListPage(finished: false),
                    );
                  },
                  iconData: Icons.assignment,
                  name: "JO ACTIVE",
                ),
                menu(
                  color: const Color(0xff219653),
                  onTap: () {
                    Navigators.push(
                      context,
                      const JobListPage(finished: true),
                    );
                  },
                  iconData: Icons.assignment,
                  name: "PEKERJAAN SELESAI",
                ),
                menu(
                  color: const Color(0xff2F80ED),
                  onTap: () {
                    Navigators.push(context, const InboxPage());
                  },
                  iconData: Icons.notifications,
                  name: "PESAN",
                ),
                menu(
                  color: Colors.yellow,
                  onTap: () {
                    Navigators.push(context, const TerimaBarangPage());
                  },
                  iconData: Icons.download,
                  name: "TERIMA BARANG",
                ),
                menu(
                  color: Colors.cyan,
                  onTap: () {
                    Navigators.push(context, const StokBarangPage());
                  },
                  iconData: Icons.inventory,
                  name: "STOK BARANG",
                ),
                Visibility(
                  visible: StringUtils.isNotNullOrEmpty(
                    Preferences.getInstance()
                        .getString(SharedPreferenceKey.WEB_PORTAL_URL),
                  ),
                  child: menu(
                    color: Colors.deepPurple,
                    onTap: () {
                      BottomSheets.webView(
                        context: context,
                        url: Preferences.getInstance()
                            .getString(SharedPreferenceKey.WEB_PORTAL_URL)!,
                      );
                    },
                    iconData: Icons.http,
                    name: "LAIN-LAIN",
                  ),
                ),
                menu(
                  color: const Color(0xffEB5757),
                  onTap: () {
                    if (JobOrderDao.pendings().isNotEmpty) {
                      Dialogs.message(
                        context: context,
                        title: "Gagal Keluar",
                        message:
                            "Dikarenakan terdapat job order yang masih pending",
                      );
                    } else {
                      Dialogs.confirmation(
                        context: context,
                        title: "Apakah anda yakin ingin keluar?",
                        positive: "Keluar",
                        positiveCallback: () {
                          context.read<HomeBloc>().add(HomeSignOut());
                        },
                      );
                    }
                  },
                  iconData: Icons.logout,
                  name: "KELUAR",
                ),
                SizedBox(
                  height: Dimensions.height15,
                ),
                Center(
                  child: FutureBuilder<PackageInfo>(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          'v${snapshot.data!.version}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget menu({
    required ui.Color color,
    required GestureTapCallback onTap,
    required IconData iconData,
    required String name,
    String? badge,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.height5),
      child: InkWell(
        splashColor: color.lighten(50),
        radius: Dimensions.radius15,
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Ink(
          color: color.lighten(95),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width15,
              vertical: Dimensions.height20,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: color),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                SizedBox(width: Dimensions.width5),
                Icon(iconData, color: color, size: 30),
                SizedBox(width: Dimensions.width10),
                Expanded(
                  child: TextSheet(
                    name,
                    fontSize: 20,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                StringUtils.isNotNullOrEmpty(badge)
                    ? Card(
                        elevation: 0,
                        color: AppColors.alertShaded.lighten(80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(Dimensions.height5),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 18,
                                color: AppColors.alertShaded,
                              ),
                              SizedBox(width: 3),
                              TextSheet('3', color: AppColors.alertShaded)
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
