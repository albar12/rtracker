import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rtracker/helper/app_colors.dart';
import 'package:rtracker/helper/dimensions.dart';
import 'package:rtracker/helper/navigators.dart';
import 'package:rtracker/helper/no_overscroll.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/vendor_dao.dart';
import 'package:rtracker/widget/camera_page.dart';
import 'package:rtracker/widget/information/basic_information.dart';
import 'package:rtracker/widget/text_sheet.dart';

class Dialogs {
  static Future<void> message({
    required BuildContext context,
    required String title,
    String? message,
    String? dismiss,
    bool cancelable = true,
  }) {
    Widget? content;

    if (message != null) {
      content = SingleChildScrollView(
        child: Text(message),
      );
    }

    return showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              child: Text(dismiss ?? "Mengerti"),
              onPressed: () => Navigators.pop(buildContext),
            )
          ],
        );
      },
    );
  }

  static Future<void> confirmation({
    required BuildContext context,
    required String title,
    String? message,
    String? negative,
    String? positive,
    bool cancelable = true,
    VoidCallback? negativeCallback,
    VoidCallback? positiveCallback,
  }) {
    Widget? content;

    if (message != null) {
      content = SingleChildScrollView(
        child: Text(message),
      );
    }

    return showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              child: Text(negative ?? "Tidak"),
              onPressed: () {
                Navigator.of(buildContext).pop();

                if (negativeCallback != null) {
                  negativeCallback.call();
                }
              },
            ),
            TextButton(
              child: Text(positive ?? "Iya"),
              onPressed: () {
                Navigator.of(buildContext).pop();

                if (positiveCallback != null) {
                  positiveCallback.call();
                }
              },
            )
          ],
        );
      },
    );
  }

  static Future<void> image({
    required BuildContext context,
    required String title,
    required bool multiple,
    required bool allowGallery,
    required void Function(List<Uint8List> files) callback,
  }) async {
    if (allowGallery) {
      List<Widget> actions = [
        TextButton(
          child: const Text('Tutup'),
          onPressed: () => Navigator.of(context).pop(),
        )
      ];

      BoxDecoration boxDecoration = BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(8),
      );

      await showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: const Text('Pilih sumber foto'),
            content: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: boxDecoration,
                    child: InkWell(
                      onTap: () async {
                        List<Uint8List> files = [];

                        // List<XFile> xFiles = await ImagePicker().pickMultiImage(
                        //   imageQuality: 20,
                        // );

                        List<XFile> xFiles =
                            await ImagePicker().pickMultiImage();

                        for (XFile xFile in xFiles) {
                          Uint8List bytesFile =
                              Uint8List.fromList(await xFile.readAsBytes());

                          files.add(
                            bytesFile,
                          );
                        }

                        Navigators.pop(context);

                        callback.call(files);
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.photo),
                            TextSheet('Gallery')
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Dimensions.height10,
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: boxDecoration,
                    child: InkWell(
                      onTap: () async {
                        List<Uint8List> byteList = [];

                        await availableCameras().then((value) {
                          Navigators.push(
                            context,
                            CameraPage(
                              cameraDescriptions: value,
                              callback: (bytes) async {
                                byteList.add(
                                  bytes,
                                );

                                Navigators.pop(context);

                                callback.call(byteList);
                              },
                            ),
                          );
                        });
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.camera_alt),
                            TextSheet('Kamera')
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            actions: actions,
          );
        },
      );
    } else {
      List<Uint8List> byteList = [];

      await availableCameras().then((value) {
        // List<CameraDescription> swappedDescriptions = value.swap(0, 1);

        // for (int i = 0; i < value.length; i++) {
        //   print(value[i]);
        //   value[i] = CameraDescription(
        //     name: value[i].name == '0' ? '1' : '0',
        //     lensDirection: value[i].lensDirection == CameraLensDirection.back
        //         ? CameraLensDirection.front
        //         : CameraLensDirection.back,
        //     sensorOrientation: value[i].sensorOrientation,
        //   );
        // }aa
        Navigators.push(
          context,
          CameraPage(
            cameraDescriptions: value,
            callback: (bytes) async {
              byteList.add(
                bytes,
              );

              callback.call(byteList);
            },
          ),
        );
      });
    }
  }

  static Future<void> syncStatus({
    required BuildContext context,
    required Map<String, bool> syncStatuses,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: const Text('Status Sinkronisasi'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: ScrollConfiguration(
              behavior: NoOverscrollBehavior(),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: syncStatuses.entries.length,
                itemBuilder: (context, index) {
                  var status = syncStatuses.entries.toList()[index];

                  return Row(
                    children: [
                      Expanded(child: TextSheet(status.key)),
                      TextSheet(
                        status.value ? "BERHASIL" : "GAGAL",
                        color:
                            status.value ? AppColors.success : AppColors.alert,
                      )
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 5,
                  );
                },
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigators.pop(context);
              },
              child: const Text('Tutup'),
            )
          ],
        );
      },
    );
  }

  static Future<void> jobOrderListInformation({
    required BuildContext context,
    required JobOrder jobOrder,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: const Text('Informasi Pekerjaan'),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BasicInformation(
                  title: 'Nama Merchant',
                  subtitle: jobOrder.merchant?.name ?? "",
                ),
                SizedBox(
                  height: Dimensions.height15,
                ),
                BasicInformation(
                  title: 'Nama Pendek Merchant',
                  subtitle: jobOrder.merchant?.shortName ?? "",
                ),
                SizedBox(
                  height: Dimensions.height15,
                ),
                BasicInformation(
                  title: 'Kota',
                  subtitle: jobOrder.merchant?.city ?? "",
                ),
                SizedBox(
                  height: Dimensions.height15,
                ),
                BasicInformation(
                  title: 'Alamat',
                  subtitle: jobOrder.merchant?.address ?? "",
                ),
                SizedBox(
                  height: Dimensions.height15,
                ),
                BasicInformation(
                  title: 'Nomor Ponsel',
                  subtitle: jobOrder.merchant?.phoneNumber ?? "",
                ),
                SizedBox(
                  height: Dimensions.height15,
                ),
                BasicInformation(
                  title: 'PIC',
                  subtitle: jobOrder.merchant?.assignedPicName ?? "",
                ),
                SizedBox(
                  height: Dimensions.height15,
                ),
                BasicInformation(
                  title: 'Keterangan',
                  subtitle: jobOrder.description ?? "",
                ),
                SizedBox(
                  height: Dimensions.height15,
                ),
                SizedBox(
                  width: Dimensions.screenWidth,
                  height: Dimensions.height50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigators.pop(context);
                    },
                    child: const Text('Tutup'),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> jobOrderFormInformation({
    required BuildContext context,
    required JobOrder jobOrder,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: const Text('Informasi Pekerjaan'),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BasicInformation(
                  title: 'Vendor',
                  subtitle: VendorDao.name(jobOrder.vendorId),
                ),
                SizedBox(
                  height: Dimensions.height15,
                ),
                BasicInformation(
                  title: 'ID Lapor',
                  subtitle: jobOrder.caseId ?? "",
                ),
                SizedBox(
                  height: Dimensions.height15,
                ),
                BasicInformation(
                  title: 'MID',
                  subtitle: jobOrder.mid ?? "",
                ),
                SizedBox(
                  height: Dimensions.height15,
                ),
                BasicInformation(
                  title: 'TID',
                  subtitle: jobOrder.tid ?? "",
                ),
                SizedBox(
                  height: Dimensions.height15,
                ),
                BasicInformation(
                  title: 'Job',
                  subtitle: jobOrder.jobType != null
                      ? StringUtils.defaultString(jobOrder.jobType!.name)
                      : "",
                ),
                SizedBox(
                  height: Dimensions.height15,
                ),
                SizedBox(
                  width: Dimensions.screenWidth,
                  height: Dimensions.height50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigators.pop(context);
                    },
                    child: const Text('Tutup'),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
