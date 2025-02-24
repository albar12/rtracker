// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:photo_view/photo_view.dart';
import 'package:rtracker/api/api_manager.dart';
import 'package:rtracker/api/endpoint/login/login_response.dart';
import 'package:rtracker/helper/dialogs.dart';
import 'package:rtracker/helper/dimensions.dart';
import 'package:rtracker/helper/formats.dart';
import 'package:rtracker/helper/navigators.dart';
import 'package:rtracker/module/profile/profile_bloc.dart';
import 'package:rtracker/module/profile/profile_state.dart';
import 'package:rtracker/module/synchronization/synchronization_page.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/widget/information/information.dart';
import 'package:rtracker/widget/text_sheet.dart';

import '../../helper/app_colors.dart';

class ProfilePage extends StatefulWidget {
  final LoginResponse loginResponse;

  const ProfilePage({Key? key, required this.loginResponse}) : super(key: key);

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {},
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: kToolbarHeight),
              Stack(
                children: [
                  Center(
                    child: Container(
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
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: IconButton(
                      onPressed: () {
                        Navigators.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  )
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextSheet(
                  widget.loginResponse.name,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              DualInformation(
                firstTitle: 'NIK',
                firstSubtitle: widget.loginResponse.nik,
                secondTitle: 'Phone',
                secondSubtitle: widget.loginResponse.phone,
              ),
              DualInformation(
                firstTitle: 'Working Start Date',
                firstSubtitle:
                    Formats.date(widget.loginResponse.workingStartDate),
                secondTitle: 'Working End Date',
                secondSubtitle:
                    Formats.date(widget.loginResponse.workingEndDate),
              ),
              SizedBox(height: Dimensions.height10),
              Visibility(
                visible: StringUtils.isNotNullOrEmpty(
                  widget.loginResponse.letterOfAssignmentPcs,
                ),
                child: Container(
                  height: 45,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(
                    vertical: Dimensions.height10,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      Uint8List uint8List = await ApiManager().download(
                        url: widget.loginResponse.letterOfAssignmentPcs,
                      );

                      if (uint8List.isNotEmpty) {
                        Navigators.push(
                          context,
                          PhotoView(
                            imageProvider: MemoryImage(uint8List),
                            backgroundDecoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        );
                      }
                    },
                    child: const TextSheet(
                      'SHOW PCS LETTER OF ASSIGNMENT',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: StringUtils.isNotNullOrEmpty(
                  widget.loginResponse.letterOfAssignmentMti,
                ),
                child: Container(
                  height: 45,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      Uint8List uint8List = await ApiManager().download(
                        url: widget.loginResponse.letterOfAssignmentMti,
                      );

                      if (uint8List.isNotEmpty) {
                        Navigators.push(
                          context,
                          PhotoView(
                            imageProvider: MemoryImage(uint8List),
                            backgroundDecoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        );
                      }
                    },
                    child: const TextSheet(
                      'SHOW MTI LETTER OF ASSIGNMENT',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: AppColors.alert,
                    ),
                    onPressed: () {
                      Dialogs.confirmation(
                        context: context,
                        title:
                            "Apakah anda yakin ingin membersihkan data dan melakukan sinkronisasi ulang?",
                        positive: "Bersihkan Data",
                        positiveCallback: () {
                          Realms.clear();
                          Navigators.pop(context);
                          Navigators.push(context, const SynchronizationPage());
                        },
                      );
                    },
                    child: const TextSheet(
                      textAlign: TextAlign.center,
                      'Bersihkan data dan sinkronisasi ulang',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      'v${snapshot.data!.version}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
