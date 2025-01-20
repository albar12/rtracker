import 'package:basic_utils/basic_utils.dart';
import 'package:datetime_setting/datetime_setting.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/helper/app_colors.dart';
import 'package:rtracker/helper/dialogs.dart';
import 'package:rtracker/helper/dimensions.dart';
import 'package:rtracker/helper/extensions.dart';
import 'package:rtracker/helper/formats.dart';
import 'package:rtracker/helper/navigators.dart';
import 'package:rtracker/helper/preferences.dart';
import 'package:rtracker/module/job_form/job_form_page.dart';
import 'package:rtracker/realm/job_order_dao.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/vendor_dao.dart';
import 'package:rtracker/widget/custom_chips.dart';
import 'package:rtracker/widget/text_sheet.dart';

class CustomListWidget {
  static Widget show({
    required BuildContext context,
    required bool finished,
    required JobOrder jobOrder,
    required Function closedAction,
    required Function completeCommit,
  }){
    String due = Formats.due(
      finished ? jobOrder.timing!.finish : DateTime.now(),
      jobOrder.endSla,);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          Dimensions.radius10,
        ),
      ),
      color: Colors.blue.lighten(90),
      child: InkWell(
        onTap: () async {
          if (finished) {
            Navigators.push(
              context,
              JobFormPage(
                jobOrder: jobOrder,
                readOnly: finished,
              ),
            ).then((_) {
              closedAction();
            });
          } else {
            if (JobOrderDao.hasOngoingJob(jobOrder.id)) {
              Dialogs.message(
                context: context,
                title:
                "Tidak dapat mengerjakan tugas ini, dikarenakan terdapat tugas lain yang masih dikerjakan.",
              );
            } else if (JobOrderDao.pauseJobs(jobOrder.id) >=
                (Preferences.getInstance()
                    .getInt(SharedPreferenceKey.PAUSE_MAX, 5) ??
                    5)) {
              Dialogs.message(
                context: context,
                title:
                "Tidak dapat mengerjakan tugas ini, dikarenakan tugas yang dilakukan PAUSE sudah melewati batas.",
              );
            } else {
              bool timeAuto = await DatetimeSetting.timeIsAuto();
              bool timezoneAuto =
              await DatetimeSetting.timeZoneIsAuto();

              if (timezoneAuto && timeAuto) {
                Dialogs.confirmation(
                  context: context,
                  title:
                  "Apakah anda yakin ingin mengerjakan tugas ini?",
                  positive: "Kerjakan",
                  positiveCallback: () async {
                    context.loaderOverlay.show();
                    bool success = true;
                    await JobOrderDao.execute(jobOrder, locationNull: (status, message) async {
                      if (status){
                        context.loaderOverlay.hide();
                        success = false;
                        await Dialogs.message(
                          context: context,
                          title: message,
                        );
                      }
                    }).whenComplete(() async {
                      if (success) {
                        context.loaderOverlay.hide();
                        await Navigators.push(
                          context,
                          JobFormPage(
                            jobOrder: jobOrder,
                            readOnly: finished,
                          ),
                        );
                        completeCommit();
                      }
                    });
                  },
                );
              } else {
                await Dialogs.message(
                  context: context,
                  title:
                  "Harap untuk merubah settingan tanggal dan waktu anda menjadi otomatis.",
                );

                DatetimeSetting.openSetting();
              }
            }
          }
        },
        child: Container(
          padding: EdgeInsets.all(Dimensions.width15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextSheet(
                          "(${VendorDao.name(jobOrder.vendorId)}) ${StringUtils.defaultString(jobOrder.caseId)}",
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: Dimensions.height5,
                        ),
                        TextSheet(
                          jobOrder.merchant != null
                              ? StringUtils.defaultString(
                            jobOrder.merchant!.name,
                          )
                              : "",
                          fontWeight: FontWeight.normal,
                        ),
                        SizedBox(
                          height: Dimensions.height5,
                        ),
                        TextSheet(
                          jobOrder.servicePoint != null
                              ? StringUtils.defaultString(
                            jobOrder.servicePoint!.name,
                          )
                              : "",
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _endWidget(finished, jobOrder),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Dialogs.jobOrderListInformation(
                            context: context,
                            jobOrder: jobOrder,
                          );
                        },
                        icon: const Icon(Icons.info_outline),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: Dimensions.height5,
              ),
              DottedLine(
                dashGapLength: 2,
                dashColor: AppColors.textSheet.lighten(50),
              ),
              SizedBox(
                height: Dimensions.height5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 0,
                        children: [
                          CustomChip(
                            label: Text(
                              jobOrder.jobType != null
                                  ? StringUtils.defaultString(
                                jobOrder.jobType!.name,
                              )
                                  : "",
                              style: const TextStyle(
                                color: Color(0xff2F80ED),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor:
                            const Color(0xff2F80ED).withOpacity(0.2),
                          ),
                          CustomChip(
                            label: RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "MID ",
                                    style: TextStyle(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: jobOrder.mid,
                                    style: const TextStyle(
                                      color: Color(0xff219653),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            backgroundColor:
                            const Color(0xffC0FFDB).withOpacity(0.5),
                          ),
                          CustomChip(
                            label: RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "TID ",
                                    style: TextStyle(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: jobOrder.tid,
                                    style: const TextStyle(
                                      color: Colors.purple,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            backgroundColor: Colors.purple.lighten(70),
                          ),
                          Visibility(
                            visible: jobOrder.status != null &&
                                StringUtils.isNotNullOrEmpty(
                                  jobOrder.status!.name,
                                ),
                            child: CustomChip(
                              label: RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Status ",
                                      style: TextStyle(
                                        color: AppColors.textPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: jobOrder.status?.name,
                                      style: TextStyle(
                                        color: Colors.amber.darken(20),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              backgroundColor:
                              Colors.amber.withOpacity(0.2),
                            ),
                          ),
                        ],
                      ),),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: Dimensions.height5,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                          Dimensions.width5,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              Dimensions.radius10,
                            ),
                          ),
                          border: Border.all(
                            color: Colors.green,
                            width: 1,
                          ),
                        ),
                        child: TextSheet(
                          DateFormat("dd-MMM", "id")
                              .format(jobOrder.receivedDate!),
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height5,
                      ),
                      Visibility(
                          visible: jobOrder.endSla != null,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.end,
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(
                                  Dimensions.width5,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      Dimensions.radius10,
                                    ),
                                  ),
                                  border: Border.all(
                                    color: Colors.red,
                                    width: 1,
                                  ),
                                ),
                                child: TextSheet(
                                  DateFormat("dd-MMM", "id").format(
                                      (jobOrder.endSla ??
                                          DateTime.now())
                                          .toLocal(),
                                  ),
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height5,
                              ),
                              Container(
                                padding: EdgeInsets.all(
                                  Dimensions.width5,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: due.contains("Out")
                                      ? Colors.red
                                      : Colors.blue,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      Dimensions.radius10,
                                    ),
                                  ),
                                ),
                                child: TextSheet(
                                  due,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                      ),
                      SizedBox(
                        height: Dimensions.height5,
                      ),
                      Visibility(
                        visible: jobOrder.latitude != null,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              child: Container(
                                  padding: EdgeInsets.all(
                                    Dimensions.width5,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        Dimensions.radius10,
                                      ),
                                    ),
                                  ),
                                  child: const Icon(Icons.gps_fixed),
                              ),
                              onTap: () {
                                MapsLauncher.launchQuery(
                                    '${jobOrder.latitude}, ${jobOrder.longitude}',
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height5,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _endWidget(bool finished, JobOrder jobOrder) {
    if (!finished) {
      return TextSheet(
        jobOrder.documentStatus != null
            ? StringUtils.defaultString(jobOrder.documentStatus!.name)
            : "",
        color: _getStatusColor(
          jobOrder.documentStatus != null
              ? StringUtils.defaultString(jobOrder.documentStatus!.id)
              : "0",
        ),
        fontWeight: FontWeight.bold,
      );
    } else {
      return CustomChip(
        label: Text(
          jobOrder.synced ? "SYNCED" : "NOT SYNCED",
          style: TextStyle(
            color: jobOrder.synced ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: jobOrder.synced
            ? Colors.green.withOpacity(0.2)
            : Colors.red.withOpacity(0.2),
      );
    }
  }

  static Color _getStatusColor(String id) {
    if (id == "2") {
      return Colors.grey.shade800;
    } else if (id == "6") {
      return Colors.blue;
    } else if (id == "1") {
      return Colors.purple;
    } else if (id == "4") {
      return Colors.green;
    } else if (id == "3") {
      return Colors.amber;
    } else {
      return Colors.red;
    }
  }
}