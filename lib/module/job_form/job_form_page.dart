// ignore_for_file: use_build_context_synchronously

import "dart:typed_data";
import "dart:ui";
import 'dart:ui' as ui;

import "package:basic_utils/basic_utils.dart";
import "package:datetime_setting/datetime_setting.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:loader_overlay/loader_overlay.dart";
import "package:rtracker/constant.dart";
import "package:rtracker/helper/app_colors.dart";
import "package:rtracker/helper/bottom_sheets.dart";
import "package:rtracker/helper/dialogs.dart";
import "package:rtracker/helper/dimensions.dart";
import "package:rtracker/helper/extensions.dart";
import "package:rtracker/helper/navigators.dart";
import "package:rtracker/helper/no_overscroll.dart";
import "package:rtracker/helper/strings.dart";
import "package:rtracker/module/job_form/bloc/job_form_bloc.dart";
import "package:rtracker/module/job_form/bloc/job_form_event.dart";
import "package:rtracker/module/job_form/bloc/job_form_state.dart";
import "package:rtracker/module/job_form/start_job_bloc/start_job_bloc.dart";
import "package:rtracker/realm/job_order_dao.dart";
import "package:rtracker/realm/non_sn_stock_dao.dart";
import "package:rtracker/realm/realms.dart";
import "package:rtracker/realm/schemas.dart";
import "package:rtracker/realm/sn_stock_dao.dart";
import "package:rtracker/widget/appbar/standard_appbar.dart";
import "package:rtracker/widget/job_form/input_periferal.dart";
import "package:rtracker/widget/job_form/paraf_pic_data_merchant.dart";
import "package:rtracker/widget/job_form/penggantian_komponen.dart";
import "package:rtracker/widget/job_form/rangkuman_pekerjaan.dart";
import "package:rtracker/widget/job_form/rincian_pekerjaan.dart";
import "package:rtracker/widget/job_form/unggah_foto_mesin.dart";
import "package:rtracker/widget/job_form/unggah_foto_struk.dart";
import "package:timelines/timelines.dart";

class JobFormPage extends StatefulWidget {
  final JobOrder jobOrder;
  final bool readOnly;

  const JobFormPage({
    Key? key,
    required this.jobOrder,
    required this.readOnly,
  }) : super(key: key);

  @override
  State<JobFormPage> createState() => JobFormPageState();
}

class JobFormPageState extends State<JobFormPage>
    with SingleTickerProviderStateMixin {
  String errorMessage = "";
  List<Provider> providers = [];
  List<EdcType> edcTypes = [];
  List<AppVersion> appVersion = [];
  List<OsPatch> osPatch = [];
  List<StickerBank> stickerBank = [];
  List<EdcCommunicationType> edcCommunicationTypes = [];
  List<ReplacementType> replacementTypes = [];
  List<JobStatus> jobStatuses = [];
  List<JobStatusCategory> jobStatusCategories = [];
  List<Note> notes = [];
  List<QrisMenu> qrisMenus = [];
  List<EdcEquipment> edcEquipments = [];
  List<EdcFeatureTestCase> edcFeatureTestCases = [];
  List<JobCategory> jobCategories = [];
  List<TransactionTestCase> transactionTestCases = [];
  List<OtherBankEdc> otherBankEdcs = [];
  List<DorMenu> dorMenus = [];
  List<MarcollUpdateStatus> marcollUpdateStatuses = [];
  List<EosUpdateStatus> eosUpdateStatuses = [];
  List<TrainingMaterial> trainingMaterials = [];
  List<DamageType> damageTypes = [];
  List<JobFormStep> jobFormSteps = [];

  SpinnerItem? selectedJobStatus;
  List<GlobalKey<FormState>> formStates =
      List.generate(7, (index) => GlobalKey<FormState>());
  List<GlobalKey<State>> widgetStates =
      List.generate(7, (index) => GlobalKey<State>());

  late TabController tabController;

  var isLoading = false;

  @override
  void initState() {
    context.read<JobFormBloc>().add(
          JobFormStarted(
            widget.jobOrder.vendorId!,
            widget.jobOrder,
          ),
        );

    String progress = "";
    if (widget.jobOrder.documentStatus != null){
      progress = widget.jobOrder.documentStatus!.id;
    }
    context.read<StartJobBloc>().add(
      ChangeStatus(
        readOnly: widget.readOnly,
        status: progress,
      ),
    );
    tabController = TabController(length: 7, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setupStep();

    return BlocListener<JobFormBloc, JobFormState>(
      listener: (context, state) {
        if (state is JobFormLoaded) {
          providers = state.providers;
          edcTypes = state.edcTypes;
          appVersion = state.appVersion;
          osPatch = state.osPatch;
          stickerBank = state.stickerBank;
          edcCommunicationTypes = state.edcCommunicationTypes;
          replacementTypes = state.replacementTypes;
          jobStatuses = state.jobStatuses;
          jobStatusCategories = state.jobStatusCategories;
          notes = state.notes;
          qrisMenus = state.qrisMenus;
          edcEquipments = state.edcEquipments;
          edcFeatureTestCases = state.edcFeatureTestCases;
          jobCategories = state.jobCategories;
          otherBankEdcs = state.otherBankEdcs;
          dorMenus = state.dorMenus;
          marcollUpdateStatuses = state.marcollUpdateStatuses;
          eosUpdateStatuses = state.eosUpdateStatuses;
          trainingMaterials = state.trainingMaterials;
          damageTypes = state.damageTypes;
          transactionTestCases = state.transactionTestCases;

          setState(() {});
        } else if (state is JobFormJobStatusCategorySuccess) {
          jobStatusCategories = state.jobStatusCategories;

          setState(() {});
        } else if (state is JobFormSubmitLoading) {
          context.loaderOverlay.show();
        } else if (state is JobFormSubmitSuccess) {
          if (state.data.isNotEmpty){
            Dialogs.message(
              context: context,
              title: state.data,
            );
          } else {
            if (widget.readOnly) {
              Dialogs.message(
                context: context,
                title: "Data job order berhasil terkirim",
              );
            } else {
              Dialogs.message(
                context: context,
                title: "Data job order berhasil tersimpan dan terkirim",
              ).whenComplete(() => Navigators.pop(context));
            }
          }
        } else if (state is JobFormSubmitFailed) {
          if (widget.readOnly) {
            Dialogs.message(
              context: context,
              title: "Job order gagal terkirim",
            );
          } else {
            Dialogs.message(
              context: context,
              title: "Job order berhasil tersimpan namun gagal terkirim",
              message:
                  "Aplikasi akan terus mencoba mengirim data job order yang belum terkirim ke server bahkan ketika aplikasi tidak sedang dibuka.",
            ).whenComplete(() => Navigators.pop(context));
          }
        } else if (state is JobFormSubmitFinished) {
          context.loaderOverlay.hide();
        }
      },
      child: WillPopScope(
        child: Scaffold(
          appBar: StandardAppBar(
            height: 160,
            title: const Text(
              "Formulir Pekerjaan",
            ),
            actions: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Dialogs.jobOrderFormInformation(
                    context: context,
                    jobOrder: widget.jobOrder,
                  );
                },
                icon: const Icon(Icons.info_outline),
              ),
            ],
            bottomWidget: [
              Container(
                constraints: BoxConstraints(
                  maxHeight: Dimensions.height50 * 2,
                ),
                child: Timeline.tileBuilder(
                  theme: TimelineThemeData(
                    direction: Axis.horizontal,
                    nodePosition: 0,
                    connectorTheme: const ConnectorThemeData(
                      space: 30,
                      thickness: 5,
                    ),
                  ),
                  shrinkWrap: true,
                  builder: TimelineTileBuilder.connected(
                    itemCount: jobFormSteps.length,
                    connectionDirection: ConnectionDirection.before,
                    itemExtent: MediaQuery.of(context).size.width * 0.35,
                    indicatorBuilder: (context, index) {
                      return InkWell(
                        key: jobFormSteps[index].globalKey,
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: Dimensions.height10,
                            horizontal: Dimensions.width5,
                          ),
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: tabController.index == index
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.3),
                                foregroundColor: Theme.of(context).primaryColor,
                                radius: 12,
                                child: Text(
                                  (index + 1).toString(),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: Dimensions.height5,
                                ),
                                constraints: BoxConstraints(
                                  maxWidth: Dimensions.width30 * 3.6,
                                  minHeight: Dimensions.height50,
                                ),
                                child: Text(
                                  jobFormSteps[index].title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    connectorBuilder: (context, index, type) {
                      double padding = 5;
                      if (type == ConnectorType.end) {
                        return Padding(
                          padding: EdgeInsets.only(left: padding),
                          child: SolidLineConnector(
                            color: AppColors.textSheet.withOpacity(0.5),
                            thickness: 1,
                          ),
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsets.only(right: padding),
                          child: SolidLineConnector(
                            color: AppColors.textSheet.withOpacity(0.5),
                            thickness: 1,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ScrollConfiguration(
                  behavior: NoOverscrollBehavior(),
                  child: ListView(
                    children: [jobFormSteps[tabController.index].form],
                  ),
                ),
              )
            ],
          ),
          bottomNavigationBar: Card(
            margin: EdgeInsets.zero,
            elevation: 10,
            color: Colors.blue.lighten(98),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width10,
                vertical: Dimensions.height10,
              ),
              child: Row(
                children: [
                  Visibility(
                    visible: tabController.index != 0,
                    maintainSize: true,
                    maintainState: true,
                    maintainAnimation: true,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: EdgeInsets.zero,
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.3),
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        elevation: 0,
                      ),
                      onPressed: () {
                        setState(() {
                          if (tabController.index != 0) {
                            changeTabIndex(tabController.index - 1);
                          }
                        });
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 25,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.width10,
                  ),
                  Expanded(
                    child: actionButton(),
                  ),
                  SizedBox(
                    width: Dimensions.width10,
                  ),
                  endButton(),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          if (!widget.readOnly) {
            bool result = false;

            await Dialogs.confirmation(
              context: context,
              title: "Apakah anda yakin ingin keluar?",
              positive: "Keluar",
              positiveCallback: () {
                result = true;
              },
            );

            return result;
          } else {
            return true;
          }
        },
      ),
    );
  }

  void setupStep() {
    jobFormSteps.clear();

    // jobFormSteps.add(
    //   JobFormStep(
    //     title: 'Rincian Pekerjaan',
    //     form: Form(
    //       key: formStates[0],
    //       child: RincianPekerjaan(
    //         key: widgetStates[3],
    //         jobFormPageState: this,
    //       ),
    //     ),
    //     globalKey: GlobalKey(),
    //   ),
    // );
    jobFormSteps.add(
      //awalnya ini
      JobFormStep(
        title: "Rangkuman Pekerjaan",
        form: Form(
          key: formStates[0],
          child: RangkumanPekerjaan(
            key: widgetStates[0],
            jobFormPageState: this,
          ),
        ),
        globalKey: GlobalKey(),
      ),
    );

    jobFormSteps.add(
      JobFormStep(
        title: "Penggantian Komponen",
        form: Form(
          key: formStates[1],
          child: PenggantianKomponen(
            key: widgetStates[1],
            jobFormPageState: this,
          ),
        ),
        globalKey: GlobalKey(),
      ),
    );

    jobFormSteps.add(
      JobFormStep(
        title: "Input Periferal",
        form: Form(
          key: formStates[2],
          child: InputPeriferal(
            key: widgetStates[2],
            jobFormPageState: this,
          ),
        ),
        globalKey: GlobalKey(),
      ),
    );

    jobFormSteps.add(
      JobFormStep(
        title: 'Rincian Pekerjaan',
        form: Form(
          key: formStates[3],
          child: RincianPekerjaan(
            key: widgetStates[3],
            jobFormPageState: this,
          ),
        ),
        globalKey: GlobalKey(),
      ),
    );

    jobFormSteps.add(
      JobFormStep(
        title: 'Unggah Foto Mesin',
        form: Form(
          key: formStates[4],
          child: UnggahFotoMesin(
            key: widgetStates[4],
            jobFormPageState: this,
          ),
        ),
        globalKey: GlobalKey(),
      ),
    );

    jobFormSteps.add(
      JobFormStep(
        title: 'Unggah Foto Struk',
        form: Form(
          key: formStates[5],
          child: UnggahFotoStruk(
            key: widgetStates[5],
            jobFormPageState: this,
          ),
        ),
        globalKey: GlobalKey(),
      ),
    );

    jobFormSteps.add(
      JobFormStep(
        title: 'Paraf PIC & Data Merchant',
        form: Form(
          key: formStates[6],
          child: ParafPicDataMerchant(
            key: widgetStates[6],
            jobFormPageState: this,
          ),
        ),
        globalKey: GlobalKey(),
      ),
    );
  }

  Widget actionButton() {
    if (widget.readOnly) {
      return FilledButton(
        onPressed: () {
          Dialogs.confirmation(
            context: context,
            title: "Apakah anda yakin ingin mengirim job order ini?",
            positive: "Kirim",
            positiveCallback: () async {
              context.read<JobFormBloc>().add(
                    JobFormSubmitted(
                      jobOrder: widget.jobOrder,
                    ),
                  );
            },
          );
        },
        style: FilledButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.send),
            SizedBox(width: Dimensions.width5),
            const Text(
              "KIRIM KE SERVER",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    } else {
      if (widget.jobOrder.documentStatus != null) {
        if (widget.jobOrder.documentStatus!.id == Progress.visit ||
            widget.jobOrder.documentStatus!.id == Progress.pause) {
          return FilledButton(
            onPressed: () async {
              bool timeAuto = await DatetimeSetting.timeIsAuto();
              bool timezoneAuto = await DatetimeSetting.timeZoneIsAuto();

              if (timezoneAuto && timeAuto) {
                Dialogs.confirmation(
                  context: context,
                  title: "Apakah anda yakin ingin memulai tugas ini?",
                  positive: "Mulai",
                  positiveCallback: () async {
                    await JobOrderDao.start(widget.jobOrder);
                    setState(() {});
                    context.read<StartJobBloc>().add(
                      ChangeStatus(
                        readOnly: widget.readOnly,
                        status: Progress.start,
                      ),
                    );
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
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              "MULAI",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else if (widget.jobOrder.documentStatus!.id == Progress.start) {
          return FilledButton(
            onPressed: () async {
              bool timeAuto = await DatetimeSetting.timeIsAuto();
              bool timezoneAuto = await DatetimeSetting.timeZoneIsAuto();

              if (timezoneAuto && timeAuto) {
                Dialogs.confirmation(
                  context: context,
                  title:
                      "Apakah anda yakin ingin berhenti sejenak dari tugas ini?",
                  positive: "Berhenti Sejenak",
                  positiveCallback: () async {
                    await JobOrderDao.pause(widget.jobOrder);
                    setState(() {});
                    context.read<StartJobBloc>().add(
                      ChangeStatus(
                        readOnly: widget.readOnly,
                        status: Progress.pause,
                      ),
                    );
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
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.amber,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              "BERHENTI SEJENAK",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
      }
    }

    return FilledButton(
      onPressed: () async {
        bool timeAuto = await DatetimeSetting.timeIsAuto();
        bool timezoneAuto = await DatetimeSetting.timeZoneIsAuto();

        if (timezoneAuto && timeAuto) {
          Dialogs.confirmation(
            context: context,
            title: "Apakah anda yakin ingin berkunjung ke tugas ini?",
            positive: "Berkunjung",
            positiveCallback: () async {
              await JobOrderDao.visit(widget.jobOrder);
              setState(() {});
              context.read<StartJobBloc>().add(
                ChangeStatus(
                  readOnly: widget.readOnly,
                  status: Progress.visit,
                ),
              );
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
      },
      style: FilledButton.styleFrom(
        backgroundColor: Colors.purple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text(
        "BERKUNJUNG",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void reloadJobStatusCategory({
    required String jobStatusId,
    required String vendorId,
    required String jobTypeId,
  }) {
    context.read<JobFormBloc>().add(
          JobFormJobStatusSelected(
            jobStatusId: jobStatusId,
            vendorId: vendorId,
            jobTypeId: jobTypeId,
          ),
        );
  }

  void changeTabIndex(int newIndex) {
    if (!widget.readOnly) {
      if (newIndex > 0) {
        if (widget.jobOrder.documentStatus!.id != "4") {
          Dialogs.message(
            context: context,
            title: "Harap untuk memulai pekerjaan terlebih dahulu.",
          );

          return;
        }
      }

      if (newIndex > tabController.index) {
        if (formStates[tabController.index].currentState != null) {
          if (formStates[tabController.index].currentState!.validate()) {
            formStates[tabController.index].currentState!.save();

            tabController.index = newIndex;
          } else {
            Dialogs.message(
              context: context,
              title: errorMessage.isEmpty ? "Mohon pastikan data yang dimasukkan sudah sesuai." : errorMessage,
            );
            errorMessage = "";
          }
        }
      } else {
        tabController.index = newIndex;
      }
    } else {
      tabController.index = newIndex;
    }

    Scrollable.ensureVisible(
      jobFormSteps[tabController.index].globalKey.currentContext!,
      duration: const Duration(milliseconds: 500),
    );

    setState(() {});
  }

  Widget endButton() {
    //tombol save kirim server
    if (tabController.index < jobFormSteps.length - 1) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
          backgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.3),
          foregroundColor: Theme.of(context).colorScheme.primary,
          elevation: 0,
        ),
        onPressed: () {
          setState(() {
            changeTabIndex(tabController.index + 1);
          });
        },
        child: const Icon(
          Icons.arrow_forward_ios,
          size: 25,
        ),
      );
    } else {
      if (!widget.readOnly) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: EdgeInsets.zero,
            backgroundColor: Colors.green.withOpacity(0.3),
            foregroundColor: Colors.green,
            elevation: 0,
          ),
          onPressed: () async {
            bool timeAuto = await DatetimeSetting.timeIsAuto();
            bool timezoneAuto = await DatetimeSetting.timeZoneIsAuto();

            if (timezoneAuto && timeAuto) {
              setState(() {
                if (formStates[tabController.index].currentState != null) {
                  if (formStates[tabController.index]
                      .currentState!
                      .validate()) {
                    if (widget.jobOrder.status != null &&
                        widget.jobOrder.status!.id == "9") {
                      if (Strings.equalsAny(
                        widget.jobOrder.jobType!.id,
                        ["7", "23"],
                      )) {
                        if (widget.jobOrder.replacements.isEmpty) {
                          Dialogs.message(
                            context: context,
                            title: "Data penggantian komponen harus diisi.",
                          );

                          return;
                        }
                      }
                    }

                    Dialogs.confirmation(
                      context: context,
                      title:
                          "Apakah anda yakin ingin menyelesaikan pekerjaan ini dengan status ${selectedJobStatus!.description}?",
                      message:
                          "Anda tidak bisa melakukan perubahan data setelah pekerjaan ini selesai.",
                      positive: "Selesai",
                      positiveCallback: () async {
                        formStates[tabController.index].currentState!.save();

                        if (widget.jobOrder.status != null &&
                            widget.jobOrder.status!.id == "9") {
                          Realms.get().write(() {
                            if (StringUtils.isNotNullOrEmpty(
                              widget.jobOrder.scannedSerialNumber,
                            )) {
                              SnStockDao.used(
                                widget.jobOrder.scannedSerialNumber!,
                              );
                            }

                            if (StringUtils.isNotNullOrEmpty(
                              widget.jobOrder.machineAndCard!.simCard,
                            )) {
                              SnStockDao.used(
                                widget.jobOrder.machineAndCard!.simCard!,
                              );
                            }

                            if (StringUtils.isNotNullOrEmpty(
                              widget.jobOrder.machineAndCard!.sam,
                            )) {
                              SnStockDao.used(
                                widget.jobOrder.machineAndCard!.sam!,
                              );
                            }

                            if (StringUtils.isNotNullOrEmpty(
                              widget.jobOrder.machineAndCard!.sam2,
                            )) {
                              SnStockDao.used(
                                widget.jobOrder.machineAndCard!.sam2!,
                              );
                            }

                            if (StringUtils.isNotNullOrEmpty(
                              widget.jobOrder.machineAndCard!.sam3,
                            )) {
                              SnStockDao.used(
                                widget.jobOrder.machineAndCard!.sam3!,
                              );
                            }

                            if (StringUtils.isNotNullOrEmpty(
                              widget.jobOrder.machineAndCard!.sam4,
                            )) {
                              SnStockDao.used(
                                widget.jobOrder.machineAndCard!.sam4!,
                              );
                            }

                            if (StringUtils.isNotNullOrEmpty(
                              widget.jobOrder.machineAndCard!.sam5,
                            )) {
                              SnStockDao.used(
                                widget.jobOrder.machineAndCard!.sam5!,
                              );
                            }

                            if (StringUtils.isNotNullOrEmpty(
                              widget.jobOrder.machineAndCard!.sam6,
                            )) {
                              SnStockDao.used(
                                widget.jobOrder.machineAndCard!.sam6!,
                              );
                            }

                            if (StringUtils.isNotNullOrEmpty(
                              widget.jobOrder.machineAndCard!.sam7,
                            )) {
                              SnStockDao.used(
                                widget.jobOrder.machineAndCard!.sam7!,
                              );
                            }

                            for (JobOrderReplacement jobOrderReplacement
                                in widget.jobOrder.replacements) {
                              SnStockDao.used(
                                jobOrderReplacement.newSerialNumber,
                              );
                            }
                          });
                        } else {
                          // Retur thermal jika status bukan selesai
                          Realms.get().write(() {
                            for (JobOrderInputPeripheral jobOrderInputPeripheral
                            in widget.jobOrder.inputPeripherals){
                              NonSnStockDao.increaseQuantity(
                                id: jobOrderInputPeripheral.id,
                                quantity: jobOrderInputPeripheral.quantity,
                                servicePointId: jobOrderInputPeripheral.servicePoint,
                              );
                            }
                          });
                        }

                        ParafPicDataMerchantState parafPicDataMerchantState =
                            widgetStates[tabController.index].currentState
                                as ParafPicDataMerchantState;

                        if (parafPicDataMerchantState
                                .gkSignaturePadState.currentState !=
                            null) {
                          if (widget.jobOrder.merchant != null) {
                            ui.Image image = await parafPicDataMerchantState
                                .gkSignaturePadState.currentState!
                                .toImage();

                            ByteData? byteData = await image.toByteData(
                              format: ImageByteFormat.png,
                            );

                            if (byteData != null) {
                              Realms.get().write(() {
                                widget.jobOrder.merchant!.signature = ImageFile(
                                  file: byteData.buffer.asUint8List(),
                                );
                              });
                            }
                          }
                        }

                        await JobOrderDao.finish(widget.jobOrder);

                        context.read<JobFormBloc>().add(
                              JobFormSubmitted(
                                jobOrder: widget.jobOrder,
                              ),
                            );
                      },
                    );
                  } else {
                    Dialogs.message(
                      context: context,
                      title:
                          "Mohon pastikan data yang dimasukkan sudah sesuai.",
                    );
                  }
                }
              });
            } else {
              await Dialogs.message(
                context: context,
                title:
                    "Harap untuk merubah settingan tanggal dan waktu anda menjadi otomatis.",
              );

              DatetimeSetting.openSetting();
            }
          },
          child: const Icon(
            Icons.save,
            size: 25,
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    }
  }
}

class JobFormStep {
  final String title;
  final Form form;
  final GlobalKey globalKey;

  JobFormStep({
    required this.title,
    required this.form,
    required this.globalKey,
  });
}
