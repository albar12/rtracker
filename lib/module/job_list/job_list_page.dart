import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:loader_overlay/loader_overlay.dart";
import "package:rtracker/constant.dart";
import "package:rtracker/helper/app_colors.dart";
import "package:rtracker/helper/bottom_sheets.dart";
import "package:rtracker/helper/dialogs.dart";
import "package:rtracker/helper/dimensions.dart";
import "package:rtracker/helper/extensions.dart";
import "package:rtracker/helper/job_order_filter.dart";
import "package:rtracker/helper/navigators.dart";
import "package:rtracker/helper/no_overscroll.dart";
import "package:rtracker/helper/preferences.dart";
import "package:rtracker/module/job_filter/job_filter_page.dart";
import "package:rtracker/module/job_form/required_job_bloc/required_job_bloc.dart";
import "package:rtracker/module/job_list/job_list_bloc.dart";
import "package:rtracker/module/job_list/job_list_event.dart";
import "package:rtracker/module/job_list/job_list_state.dart";
import "package:rtracker/realm/schemas.dart";
import "package:rtracker/widget/appbar/search_appbar.dart";
import "package:rtracker/widget/job_form/custom_list_job.dart";
import "package:rtracker/widget/text_sheet.dart";
import 'package:flutter/foundation.dart';

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
    ),
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

  void loadRequired(){
    if (!widget.finished){
      context.read<RequiredJobBloc>().add(LoadRequiredJob());
    }
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
              if (kDebugMode) {
                Dialogs.message(
                  context: context,
                  title: state.error,
                );
              }
            }
            if (state is FinishedSync){
              if (kDebugMode) {
                Dialogs.message(
                  context: context,
                  title: state.data.toString(),
                );
              }
              context.loaderOverlay.hide();
              reload();
            }
          },
        ),
        BlocListener<RequiredJobBloc, RequiredJobState>(
          listener: (context, state){
            if (state is RequiredJobLoading){
              context.loaderOverlay.show();
            }
            if (state is RequiredJobLoaded){
              context.loaderOverlay.hide();
              print("Count Job Order : ${state.data}");
              if (state.data.isNotEmpty){
                Dialogs.requiredJobInformation(
                  context: context,
                  data: state.data,
                  finished: widget.finished,
                  closedAction: (){
                    reload();
                  },
                  completeCommit: () => reload(),
                );
              }
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
                        List<String> ids = jobOrders
                            .where((e) => !e.synced)
                            .map((e) => e.id).toList();
                        if (ids.isNotEmpty) {
                          syncJoBloc.add(SyncFinishedJo(ids: ids));
                        }
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

              return CustomListWidget.show(
                context: context,
                finished: widget.finished,
                jobOrder: jobOrder,
                closedAction: (){
                  reload();
                },
                completeCommit: (){
                  reload();
                },
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
    if (!widget.finished){
      context.read<RequiredJobBloc>().add(LoadRequiredJob());
    }
  }
}
