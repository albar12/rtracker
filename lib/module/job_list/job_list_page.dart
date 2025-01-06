import "dart:convert";

import "package:basic_utils/basic_utils.dart";
import "package:datetime_setting/datetime_setting.dart";
import "package:dotted_line/dotted_line.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:intl/intl.dart";
import "package:loader_overlay/loader_overlay.dart";
import "package:maps_launcher/maps_launcher.dart";
import "package:rtracker/constant.dart";
import "package:rtracker/helper/app_colors.dart";
import "package:rtracker/helper/bottom_sheets.dart";
import "package:rtracker/helper/dialogs.dart";
import "package:rtracker/helper/dimensions.dart";
import "package:rtracker/helper/extensions.dart";
import "package:rtracker/helper/formats.dart";
import "package:rtracker/helper/job_order_filter.dart";
import "package:rtracker/helper/navigators.dart";
import "package:rtracker/helper/no_overscroll.dart";
import "package:rtracker/helper/preferences.dart";
import "package:rtracker/module/job_filter/job_filter_page.dart";
import "package:rtracker/module/job_form/job_form_page.dart";
import "package:rtracker/module/job_list/job_list_bloc.dart";
import "package:rtracker/module/job_list/job_list_event.dart";
import "package:rtracker/module/job_list/job_list_state.dart";
import "package:rtracker/realm/job_order_dao.dart";
import "package:rtracker/realm/schemas.dart";
import "package:rtracker/realm/vendor_dao.dart";
import "package:rtracker/widget/appbar/search_appbar.dart";
import "package:rtracker/widget/custom_chips.dart";
import "package:rtracker/widget/text_sheet.dart";

class JobListPage extends StatefulWidget {
  final bool finished;

  const JobListPage({
    Key? key,
    required this.finished,
  }) : super(key: key);

  @override
  State<JobListPage> createState() => JobListPageState();
}

class JobListPageState extends State<JobListPage> {
  JobOrderFilter jobOrderFilter = JobOrderFilter();
  JobListBloc syncJoBloc = JobListBloc();

  final TextEditingController textEditingController = TextEditingController();
  final List<JobOrder> jobOrders = [];
  final List<SpinnerItem> sortOptions = [
    SpinnerItem(
      identity: "mid",
      description: "MID",
    ),
    SpinnerItem(
      identity: "vendorId",
      description: "Vendor",
    ),
    SpinnerItem(
      identity: "servicePoint.name",
      description: "Service Point",
    ),
    SpinnerItem(
      identity: "caseId",
      description: "Case ID",
    ),
    SpinnerItem(
      identity: "status.name",
      description: "Status",
    ),
    SpinnerItem(
      identity: "endSla",
      description: "Tanggal SLA",
    )
  ];

  @override
  void initState() {
    super.initState();

    try {
      if (Preferences.getInstance()
          .contain(SharedPreferenceKey.JOB_ORDER_FILTER)) {
        jobOrderFilter = JobOrderFilter.fromJson(
          json.decode(
            Preferences.getInstance()
                .getString(SharedPreferenceKey.JOB_ORDER_FILTER)!,
          ),
        );
      }
    } catch (e) {
      jobOrderFilter = JobOrderFilter();
    } finally {
      jobOrderFilter.sortBy ??= sortOptions[0].identity;
    }

    reload();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<JobListBloc, JobListState>(
          listener: (context, state) {
            if (state is JobListLoaded) {
              setState(() {
                jobOrders.clear();
                jobOrders.addAll(state.jobOrders);

                Preferences.getInstance().setString(
                  SharedPreferenceKey.JOB_ORDER_FILTER,
                  json.encode(jobOrderFilter.toJson()),
                );
              });
            }
          },
        ),
        BlocListener(
          bloc: syncJoBloc,
          listener: (context, state){
            if (state is LoadingSync){
              context.loaderOverlay.show();
            }
            if (state is FailedSync){
              context.loaderOverlay.hide();
            }
            if (state is FinishedSync){
              context.loaderOverlay.hide();
              reload();
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: SearchAppBar(
          title: Text("Daftar Pekerjaan ${widget.finished ? "Selesai" : ""}"),
          height: MediaQuery.of(context).size.height * 0.2,
          suffix: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.height10,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: jobOrderFilter.sortBy,
                icon: const Icon(Icons.sort),
                alignment: AlignmentDirectional.centerEnd,
                selectedItemBuilder: (context) {
                  return sortOptions.map((e) {
                    return Center(
                      child: Container(
                        margin: EdgeInsets.only(
                          right: Dimensions.width5,
                        ),
                        child: Text(
                          e.description,
                        ),
                      ),
                    );
                  }).toList();
                },
                onChanged: (value) {
                  setState(() {
                    jobOrderFilter.sortBy = value;

                    reload();
                  });
                },
                items: sortOptions.map<DropdownMenuItem<String>>((e) {
                  return DropdownMenuItem<String>(
                    value: e.identity,
                    child: Text(e.description),
                  );
                }).toList(),
              ),
            ),
          ),
          bottomWidget: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.height5,
                horizontal: Dimensions.width15,
              ),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigators.push(
                        context,
                        JobFilterPage(
                          jobOrderFilters: jobOrderFilter,
                        ),
                      ).then((value) => reload());
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.filter_list,
                        ),
                        SizedBox(
                          width: Dimensions.width5,
                        ),
                        const TextSheet(
                          "FILTER",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 2),
                  Visibility(
                    visible: widget.finished,
                    child: ElevatedButton(
                      onPressed: () {
                        syncJoBloc.add(SyncFinishedJo(ids: jobOrders.map((e) => e.id).toList()));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.sync,
                          ),
                          SizedBox(
                            width: Dimensions.width5,
                          ),
                          const TextSheet(
                            "SYNC",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Visibility(
                      visible: jobOrderFilter.count() > 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(
                              Dimensions.width5,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            child: Text(
                              jobOrderFilter.count().toString(),
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.width5,
                          ),
                          const TextSheet(
                            "filter items activated",
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xffF2994A).lighten(85),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: () {
                      jobOrderFilter.clear();

                      reload();
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.clear_all,
                          size: 18,
                          color: AppColors.alertShaded,
                        ),
                        SizedBox(
                          width: Dimensions.width5,
                        ),
                        const TextSheet(
                          "CLEAR",
                          color: AppColors.alertShaded,
                          fontWeight: FontWeight.normal,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
          controller: textEditingController,
          onChanged: (p0) {
            setState(() {});
          },
        ),
        body: ScrollConfiguration(
          behavior: NoOverscrollBehavior(),
          child: ListView.separated(
            itemCount: jobOrders.where((element) {
              String pattern =
                  "${element.caseId}${element.merchant != null ? element.merchant!.name : ""}${element.servicePoint != null ? element.servicePoint!.name : ""}${element.jobType != null ? element.jobType!.name : ""}${element.mid}${element.tid}${element.merchant?.city ?? ""}${element.merchant?.shortName ?? ""}${element.merchant?.address ?? ""}${element.merchant?.phoneNumber ?? ""}${element.merchant?.assignedPicName ?? ""}"
                      .toLowerCase();

              return pattern.contains(textEditingController.text.toLowerCase());
            }).length,
            padding: EdgeInsets.all(Dimensions.width15),
            separatorBuilder: (context, index) {
              return SizedBox(
                height: Dimensions.height10,
              );
            },
            itemBuilder: (context, index) {
              JobOrder jobOrder = jobOrders.where((element) {
                String pattern =
                    "${element.caseId}${element.merchant != null ? element.merchant!.name : ""}${element.servicePoint != null ? element.servicePoint!.name : ""}${element.jobType != null ? element.jobType!.name : ""}${element.mid}${element.tid}${element.merchant?.city ?? ""}${element.merchant?.shortName ?? ""}${element.merchant?.address ?? ""}${element.merchant?.phoneNumber ?? ""}${element.merchant?.assignedPicName ?? ""}"
                        .toLowerCase();

                return pattern
                    .contains(textEditingController.text.toLowerCase());
              }).toList()[index];

              String due = Formats.due(
                  widget.finished ? jobOrder.timing!.finish : DateTime.now(),
                  jobOrder.endSla);

              print("list page alif");
              print(due);

              return Card(
                margin: EdgeInsets.zero,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    Dimensions.radius10,
                  ),
                ),
                color: Colors.blue.lighten(90),
                child: InkWell(
                  onTap: () async {
                    if (widget.finished) {
                      Navigators.push(
                        context,
                        JobFormPage(
                          jobOrder: jobOrder,
                          readOnly: widget.finished,
                        ),
                      ).then((_) {
                        reload();
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
                              await JobOrderDao.execute(jobOrder);

                              await Navigators.push(
                                context,
                                JobFormPage(
                                  jobOrder: jobOrder,
                                  readOnly: widget.finished,
                                ),
                              );

                              reload();
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
                                  )
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                endWidget(jobOrder),
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
                            )
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
                                        )
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
                                        )
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
                                          )
                                        ],
                                      ),
                                    ),
                                    backgroundColor:
                                        Colors.amber.withOpacity(0.2),
                                  ),
                                )
                              ],
                            )),
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
                                                    .toLocal()),
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
                                    )),
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
                                            child: Icon(Icons.gps_fixed)),
                                        // child: Text(
                                        //     "${jobOrder.latitude},${jobOrder.longitude}")),
                                        onTap: () {
                                          // MapsLauncher.launchCoordinates(
                                          //   37.4220041,
                                          //   -122.0862462,
                                          //   'Google Headquarters are here',
                                          // );
                                          MapsLauncher.launchQuery(
                                              '${jobOrder.latitude}, ${jobOrder.longitude}');
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: Dimensions.height5,
                                ),
                                // Text("${Formats.isoDateTime(jobOrder.endSla)}"),
                                // Text(
                                //     "${DateTime.parse(Formats.isoDateTime(jobOrder.endSla).toString())}"),
                                // Text("${jobOrder.timing!.finish}"),
                                // Text("${DateTime.now()}"),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void reload() {
    context.read<JobListBloc>().add(
          JobListLoad(
            finished: widget.finished,
            jobOrderFilter: jobOrderFilter,
          ),
        );
  }

  Widget endWidget(JobOrder jobOrder) {
    if (!widget.finished) {
      return TextSheet(
        jobOrder.documentStatus != null
            ? StringUtils.defaultString(jobOrder.documentStatus!.name)
            : "",
        color: getStatusColor(
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

  Color getStatusColor(String id) {
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
