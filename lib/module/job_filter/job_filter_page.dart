import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:rtracker/helper/app_colors.dart';
import 'package:rtracker/helper/bottom_sheets.dart';
import 'package:rtracker/helper/extensions.dart';
import 'package:rtracker/helper/formats.dart';
import 'package:rtracker/helper/job_order_filter.dart';
import 'package:rtracker/helper/navigators.dart';
import 'package:rtracker/module/job_filter/bloc/job_filter_bloc.dart';
import 'package:rtracker/module/job_filter/bloc/job_filter_event.dart';
import 'package:rtracker/module/job_filter/bloc/job_filter_state.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/widget/appbar/standard_appbar.dart';
import 'package:rtracker/widget/custom_textfield.dart';
import 'package:rtracker/widget/text_sheet.dart';

class JobFilterPage extends StatefulWidget {
  const JobFilterPage({Key? key, required this.jobOrderFilters})
      : super(key: key);
  final JobOrderFilter jobOrderFilters;

  @override
  State<JobFilterPage> createState() => _JobFilterPageState();
}

class _JobFilterPageState extends State<JobFilterPage> {
  final tempController = TextEditingController();
  final tempDropdownController = TextEditingController();
  List<TextEditingController> controller =
      List.generate(10, (index) => TextEditingController());
  List<Vendor> vendors = [];
  List<BaseOffice> baseOffice = [];
  List<DocumentStatus> status = [];
  List<ServicePoint> servicePoint = [];
  List<JobType> jobType = [];
  Vendor? selectedVendor;
  BaseOffice? selectedOffice;
  ServicePoint? selectedServicePoint;
  DocumentStatus? selectedDocumentStatus;
  JobType? selectedJobType;
  DateTime? selectedReceivedDate;

  @override
  void initState() {
    super.initState();

    context.read<JobFilterBloc>().add(JobFilterStarted());

    var filters = widget.jobOrderFilters;

    controller[4].text = StringUtils.defaultString(filters.caseId);
    controller[5].text = StringUtils.defaultString(filters.mid);
    controller[6].text = StringUtils.defaultString(filters.tid);
    controller[7].text = StringUtils.defaultString(filters.merchantName);
    controller[8].text = Formats.date(filters.receivedDate);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<JobFilterBloc, JobFilterState>(
      listener: (context, state) {
        if (state is JobFilterLoaded) {
          vendors = state.vendors;
          baseOffice = state.office;
          status = state.status;

          setState(() {
            if (StringUtils.isNotNullOrEmpty(widget.jobOrderFilters.vendorId)) {
              selectedVendor = vendors.firstWhereOrNull(
                (element) => element.id == widget.jobOrderFilters.vendorId,
              );

              if (selectedVendor != null) {
                controller[0].text = selectedVendor!.name;
              }

              context.read<JobFilterBloc>().add(
                    JobFilterVendorBaseOfficeSelected(
                      widget.jobOrderFilters.vendorId.toString(),
                      widget.jobOrderFilters.baseOfficeId,
                    ),
                  );
            }

            if (StringUtils.isNotNullOrEmpty(
              widget.jobOrderFilters.baseOfficeId,
            )) {
              selectedOffice = baseOffice.firstWhereOrNull(
                (element) => element.id == widget.jobOrderFilters.baseOfficeId,
              );

              if (selectedOffice != null) {
                controller[1].text = selectedOffice!.name;
              }
            }

            if (StringUtils.isNotNullOrEmpty(
              widget.jobOrderFilters.documentStatusId,
            )) {
              selectedDocumentStatus = status.firstWhereOrNull(
                (element) =>
                    element.id == widget.jobOrderFilters.documentStatusId,
              );

              if (selectedDocumentStatus != null) {
                controller[9].text = selectedDocumentStatus!.name;
              }
            }
          });
        } else if (state is JobFilterOthersLoaded) {
          servicePoint = state.servicePoints;
          jobType = state.jobType;

          setState(() {
            if (StringUtils.isNotNullOrEmpty(
              widget.jobOrderFilters.servicePointId,
            )) {
              selectedServicePoint = servicePoint.firstWhereOrNull(
                (element) =>
                    element.id == widget.jobOrderFilters.servicePointId,
              );

              if (selectedServicePoint != null) {
                controller[2].text = selectedServicePoint!.name;
              }
            }

            if (StringUtils.isNotNullOrEmpty(
              widget.jobOrderFilters.jobTypeId,
            )) {
              selectedJobType = jobType.firstWhereOrNull(
                (element) => element.id == widget.jobOrderFilters.jobTypeId,
              );

              if (selectedJobType != null) {
                controller[3].text = selectedJobType!.name;
              }
            }
          });
        }
      },
      child: Scaffold(
        appBar: StandardAppBar(
          title: const Text('Job Filter'),
          actions: [
            Container(
              margin: const EdgeInsets.all(12),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xffF2994A).lighten(85),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: () {
                  widget.jobOrderFilters.clear();
                  selectedVendor = null;
                  selectedOffice = null;
                  selectedServicePoint = null;
                  selectedDocumentStatus = null;
                  selectedJobType = null;
                  selectedReceivedDate = null;
                  for (var e in controller) {
                    e.text = '';
                  }
                  setState(() {});
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.clear_all,
                      size: 18,
                      color: AppColors.alertShaded,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    TextSheet(
                      'CLEAR',
                      color: AppColors.alertShaded,
                      fontWeight: FontWeight.normal,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 5),
          child: ListView(
            children: [
              CustomTextFieldOld(
                controller: controller[0],
                label: 'Vendor',
                onTap: () {
                  List<SpinnerItem> spinnerItems = [];
                  for (var e in vendors) {
                    spinnerItems
                        .add(SpinnerItem(identity: e, description: e.name));
                  }
                  BottomSheets.spinner(
                    context: context,
                    title: 'Vendor',
                    spinnerItems: spinnerItems,
                    onSelected: (selected) {
                      selectedVendor = selected.identity;
                      controller[0].text = selected.description;
                      //Reset service point dan job type
                      selectedServicePoint = null;
                      controller[2].text = '';
                      selectedJobType = null;
                      controller[3].text = '';
                      context.read<JobFilterBloc>().add(
                            JobFilterVendorBaseOfficeSelected(
                              selectedVendor!.id,
                              selectedOffice?.id,
                            ),
                          );
                      setState(() {});
                    },
                  );
                },
              ),
              CustomTextFieldOld(
                controller: controller[1],
                label: 'Base Kantor SP',
                onTap: () {
                  List<SpinnerItem> spinnerItems = [];
                  for (var e in baseOffice) {
                    spinnerItems
                        .add(SpinnerItem(identity: e, description: e.name));
                  }
                  BottomSheets.spinner(
                    context: context,
                    title: 'Base Kantor SP',
                    spinnerItems: spinnerItems,
                    onSelected: (selected) {
                      selectedOffice = selected.identity;
                      controller[1].text = selected.description;
                      //Reset service point
                      selectedServicePoint = null;
                      controller[2].text = '';
                      context.read<JobFilterBloc>().add(
                            JobFilterVendorBaseOfficeSelected(
                              selectedVendor!.id,
                              selectedOffice?.id,
                            ),
                          );
                      setState(() {});
                    },
                  );
                },
              ),
              CustomTextFieldOld(
                controller: controller[2],
                label: 'Service Point',
                onTap: () {
                  List<SpinnerItem> spinnerItems = [];
                  for (var e in servicePoint) {
                    spinnerItems
                        .add(SpinnerItem(identity: e, description: e.name));
                  }
                  BottomSheets.spinner(
                    context: context,
                    title: 'Service Points',
                    spinnerItems: spinnerItems,
                    onSelected: (selected) {
                      selectedServicePoint = selected.identity;
                      controller[2].text = selected.description;
                    },
                  );
                },
              ),
              CustomTextFieldOld(
                controller: controller[3],
                label: 'Jenis Job',
                onTap: () {
                  List<SpinnerItem> spinnerItems = [];
                  for (var e in jobType) {
                    spinnerItems
                        .add(SpinnerItem(identity: e, description: e.name));
                  }
                  BottomSheets.spinner(
                    context: context,
                    title: 'Job Type',
                    spinnerItems: spinnerItems,
                    onSelected: (selected) {
                      selectedJobType = selected.identity;
                      controller[3].text = selected.description;
                    },
                  );
                },
              ),
              CustomTextFieldOld(controller: controller[4], label: 'Case ID'),
              CustomTextFieldOld(controller: controller[5], label: 'MID'),
              CustomTextFieldOld(controller: controller[6], label: 'TID'),
              CustomTextFieldOld(
                controller: controller[7],
                label: 'Nama Merchant',
              ),
              CustomTextFieldOld(
                controller: controller[8],
                label: 'Tanggal Terima JO',
                suffixIcon: const Icon(Icons.event),
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 3),
                    lastDate: DateTime(DateTime.now().year + 3),
                    currentDate: selectedReceivedDate,
                  ).then((value) {
                    if (value != null) {
                      selectedReceivedDate = value;
                      controller[8].text = Formats.date(selectedReceivedDate!);
                      setState(() {});
                    }
                  });
                },
              ),
              CustomTextFieldOld(
                controller: controller[9],
                label: 'Status',
                onTap: () {
                  List<SpinnerItem> spinnerItems = [];
                  for (var e in status) {
                    spinnerItems
                        .add(SpinnerItem(identity: e, description: e.name));
                  }
                  BottomSheets.spinner(
                    context: context,
                    title: 'Status',
                    spinnerItems: spinnerItems,
                    onSelected: (selected) {
                      selectedDocumentStatus = selected.identity;
                      controller[9].text = selected.description;
                    },
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: InkWell(
          onTap: () {
            if (selectedVendor != null) {
              widget.jobOrderFilters.vendorId = selectedVendor!.id;
            }

            if (selectedOffice != null) {
              widget.jobOrderFilters.baseOfficeId = selectedOffice!.id;
            }

            if (selectedServicePoint != null) {
              widget.jobOrderFilters.servicePointId = selectedServicePoint!.id;
            }

            if (selectedJobType != null) {
              widget.jobOrderFilters.jobTypeId = selectedJobType!.id;
            }

            widget.jobOrderFilters.caseId = controller[4].text;
            widget.jobOrderFilters.mid = controller[5].text;
            widget.jobOrderFilters.tid = controller[6].text;
            widget.jobOrderFilters.merchantName = controller[7].text;
            widget.jobOrderFilters.receivedDate = selectedReceivedDate;

            if (selectedDocumentStatus != null) {
              widget.jobOrderFilters.documentStatusId =
                  selectedDocumentStatus!.id;
            }

            Navigators.pop(context);
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.05,
            color: Theme.of(context).colorScheme.primary,
            alignment: Alignment.center,
            child: TextSheet(
              'TERAPKAN',
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}
