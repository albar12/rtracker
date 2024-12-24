// ignore_for_file: invalid_use_of_protected_member

import "package:basic_utils/basic_utils.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:rtracker/helper/bottom_sheets.dart";
import "package:rtracker/helper/dimensions.dart";
import "package:rtracker/helper/strings.dart";
import "package:rtracker/helper/widgets.dart";
import "package:rtracker/module/job_form/job_form_page.dart";
import "package:rtracker/realm/realms.dart";
import "package:rtracker/realm/schemas.dart";
import "package:rtracker/widget/custom_checklist_field.dart";
import "package:rtracker/widget/custom_date_field.dart";
import "package:rtracker/widget/custom_number_list_field.dart";
import "package:rtracker/widget/custom_spinner_field.dart";
import "package:rtracker/widget/custom_text_field.dart";
import "package:rtracker/widget/custom_time_field.dart";
import "package:rtracker/widget/information/custom_information.dart";
import "package:rtracker/widget/text_sheet.dart";

class RincianPekerjaan extends StatefulWidget {
  final JobFormPageState jobFormPageState;

  const RincianPekerjaan({
    Key? key,
    required this.jobFormPageState,
  }) : super(key: key);

  @override
  State<RincianPekerjaan> createState() => RincianPekerjaanState();
}

class RincianPekerjaanState extends State<RincianPekerjaan>
    with AutomaticKeepAliveClientMixin {
  bool hasQris = false;
  bool qrisCheckResult = false;

  TextEditingController tecJobStatusCategory = TextEditingController();
  TextEditingController tecNewVisitDate = TextEditingController();
  TextEditingController tecOpen = TextEditingController();
  TextEditingController edcCount = TextEditingController();
  TextEditingController tecPatchOs = TextEditingController();

  GlobalKey<FormFieldState> ffsJobStatusCategory = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> ffsNewVisitDate = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> ffsOpen = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> ffsPatchOs = GlobalKey<FormFieldState>();

  String? versiEdcId;

  String? versiEdcAndroid;

  List<Map<String, dynamic>> cleanEdc = [
    {"id": 1, "name": "Yes"},
    {"id": 2, "name": "No"},
  ];

  @override
  void initState() {
    super.initState();

    JobOrder jobOrder = widget.jobFormPageState.widget.jobOrder;

    if (jobOrder.status != null) {
      JobStatus? jobStatus = widget.jobFormPageState.jobStatuses
          .firstWhereOrNull((element) => element.id == jobOrder.status!.id);

      if (jobStatus != null) {
        widget.jobFormPageState.selectedJobStatus = SpinnerItem(
          identity: jobStatus.id,
          description: jobStatus.name,
          tag: jobStatus,
        );
      }
    }

    if (jobOrder.qris != null) {
      hasQris = jobOrder.qris!.exist;
      qrisCheckResult = jobOrder.qris!.testResult;
    }

    if (jobOrder.edcCount != null) {
      edcCount.text = jobOrder.edcCount.toString();
    }

    if (jobOrder.edcUpdate!.appVersion != null) {
      setState(() {
        versiEdcId = jobOrder.edcUpdate!.appVersion!.id.toString();
        versiEdcAndroid =
            jobOrder.edcUpdate!.appVersion!.id_tipe_edc.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    JobOrder jobOrder = widget.jobFormPageState.widget.jobOrder;

    return Padding(
      padding: EdgeInsets.all(
        Dimensions.width15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextSheet(
            "RINCIAN STATUS PEKERJAAN",
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomSpinnerField(
            labelText: "Status Pekerjaan",
            initialValue: widget.jobFormPageState.selectedJobStatus,
            readOnly: widget.jobFormPageState.widget.readOnly,
            validator: (value) {
              if (value == null) {
                return "Kolom ini harus diisi.";
              }

              return null;
            },
            onSaved: (value) {
              if (value != null) {
                Realms.get().write(() {
                  jobOrder.status ??= JobOrderStatus();
                  jobOrder.status!.id = value.identity;
                  jobOrder.status!.name = value.description;
                });
              }
            },
            onChanged: (newValue) {
              setState(() {
                widget.jobFormPageState.selectedJobStatus = newValue;

                if (ffsJobStatusCategory.currentState != null) {
                  tecJobStatusCategory.text = "";
                  ffsJobStatusCategory.currentState!.setValue(null);
                }

                if (ffsNewVisitDate.currentState != null) {
                  tecNewVisitDate.text = "";
                  ffsNewVisitDate.currentState!.setValue(null);
                }

                widget.jobFormPageState.reloadJobStatusCategory(
                  jobStatusId: newValue.identity,
                  vendorId: widget.jobFormPageState.widget.jobOrder.vendorId!,
                  jobTypeId:
                      widget.jobFormPageState.widget.jobOrder.jobType!.id,
                );
              });
            },
            spinnerItems: widget.jobFormPageState.jobStatuses
                .map(
                  (e) => SpinnerItem(
                    identity: e.id,
                    description: e.name,
                    tag: e,
                  ),
                )
                .toList(),
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomSpinnerField(
            textEditingController: tecJobStatusCategory,
            fieldKey: ffsJobStatusCategory,
            labelText: "Kategori Status Pekerjaan",
            initialValue: jobOrder.status != null
                ? SpinnerItem(
                    identity: jobOrder.status!.categoryId,
                    description: StringUtils.defaultString(
                      jobOrder.status!.categoryName,
                    ),
                  )
                : null,
            readOnly: widget.jobFormPageState.widget.readOnly,
            validator: (value) {
              if (value == null) {
                return "Kolom ini harus diisi.";
              }

              return null;
            },
            onSaved: (value) {
              if (value != null) {
                Realms.get().write(() {
                  jobOrder.status ??= JobOrderStatus();
                  jobOrder.status!.categoryId = value.identity;
                  jobOrder.status!.categoryName = value.description;
                });
              }
            },
            spinnerItems: widget.jobFormPageState.jobStatusCategories
                .where((element) {
                  if (widget.jobFormPageState.selectedJobStatus != null) {
                    if (element.jobStatusAliasId ==
                        (widget.jobFormPageState.selectedJobStatus!.tag
                                as JobStatus)
                            .aliasId) {
                      return true;
                    }
                  }

                  return false;
                })
                .map(
                  (e) => SpinnerItem(
                    identity: e.id,
                    description: e.name,
                  ),
                )
                .toList(),
          ),
          Visibility(
            visible: widget.jobFormPageState.selectedJobStatus != null &&
                (widget.jobFormPageState.selectedJobStatus!.tag as JobStatus)
                        .aliasId ==
                    "2",
            child: Column(
              children: [
                SizedBox(
                  height: Dimensions.height15,
                ),
                CustomDateField(
                  textEditingController: tecNewVisitDate,
                  fieldKey: ffsNewVisitDate,
                  labelText: "Tanggal Kunjungan Baru",
                  initialValue: jobOrder.status != null &&
                          jobOrder.status!.newVisitDate != null
                      ? jobOrder.status!.newVisitDate
                      : null,
                  readOnly: widget.jobFormPageState.widget.readOnly,
                  validator: (value) {
                    if (value == null) {
                      return "Kolom ini harus diisi.";
                    }

                    return null;
                  },
                  onSaved: (value) {
                    if (value != null) {
                      Realms.get().write(() {
                        jobOrder.status ??= JobOrderStatus();
                        jobOrder.status!.newVisitDate = value.toUtc();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomInformation(
            title: "KETERANGAN LANJUTAN",
            content: TextSheet(
              StringUtils.defaultString(jobOrder.description),
            ),
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          Visibility(
            visible: Strings.equalsAny(jobOrder.vendorId, ["3","2"]),
            child: CustomTimeField(
              labelText: "Jam Buka Toko",
              initialValue:
                  jobOrder.jamBukaToko != null ? jobOrder.jamBukaToko : null,
              readOnly: widget.jobFormPageState.widget.readOnly,
              validator: (value) {
                if (value == null) {
                  return "Kolom ini harus diisi.";
                }

                return null;
              },
              onSaved: (value) {
                if (value != null) {
                  Realms.get().write(() {
                    // jobOrder.jamBukaToko ??= jamBukaToko();
                    // if (jobOrder.jamBukaToko != null) {
                    jobOrder.jamBukaToko = value.toString();
                    // }
                  });
                }
              },
            ),
          ),
          Visibility(
            visible: Strings.equalsAny(jobOrder.vendorId, ["3","2"]),
            child: CustomTimeField(
              labelText: "Jam Tutup Toko",
              initialValue:
                  jobOrder.jamTutupToko != null ? jobOrder.jamTutupToko : null,
              readOnly: widget.jobFormPageState.widget.readOnly,
              validator: (value) {
                if (value == null) {
                  return "Kolom ini harus diisi.";
                }

                return null;
              },
              onSaved: (value) {
                if (value != null) {
                  Realms.get().write(() {
                    // if (jobOrder.jamTutupToko != null) {
                    jobOrder.jamTutupToko = value.toString();
                    // }
                  });
                }
              },
            ),
          ),
          Visibility(
            visible: Strings.equalsAny(jobOrder.vendorId, ["3","2"]),
            child: CustomTextField(
              controller: edcCount,
              label: 'EDC Count',
              readOnly: widget.jobFormPageState.widget.readOnly,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (StringUtils.isNullOrEmpty(value)) {
                  return "Kolom ini harus diisi.";
                }

                if (value!.length > 2) {
                  return "Maksimal 2 digit.";
                }
                return null;
              },
              onSaved: (value) {
                Realms.get().write(() {
                  jobOrder.edcCount = int.parse(value!);
                });
              },
            ),
          ),
          ...requiredThermalCount(),
          ...checklistNotes(),
          ...qris(),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomInformation(
            title: "KELENGKAPAN EDC",
            content: CustomNumberListField(
              readOnly: widget.jobFormPageState.widget.readOnly,
              onSaved: (value) {
                if (value != null) {
                  Realms.get().write(() {
                    jobOrder.edcEquipments.clear();

                    for (NumberItem numberItem in value) {
                      jobOrder.edcEquipments.add(
                        JobOrderEdcEquipment(
                          numberItem.identity,
                          numberItem.value,
                        ),
                      );
                    }
                  });
                }
              },
              numberItems: widget.jobFormPageState.edcEquipments.map((e) {
                JobOrderEdcEquipment? jobOrderEdcEquipment = jobOrder
                    .edcEquipments
                    .firstWhereOrNull((element) => element.name == e.name);

                return NumberItem(
                  identity: e.name,
                  description: Strings.pretty(e.name),
                  tag: e,
                  value: jobOrderEdcEquipment != null
                      ? jobOrderEdcEquipment.quantity
                      : 0,
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          // CustomInformation(
          //   title: "Jml",
          //   content: CustomNumberListField(
          //     readOnly: widget.jobFormPageState.widget.readOnly,
          //     onSaved: (value) {
          //       if (value != null) {
          //         // Realms.get().write(() {
          //         //   jobOrder.edcEquipments.clear();

          //         //   for (NumberItem numberItem in value) {
          //         //     jobOrder.edcEquipments.add(
          //         //       JobOrderEdcEquipment(
          //         //         numberItem.identity,
          //         //         numberItem.value,
          //         //       ),
          //         //     );
          //         //   }
          //         // });
          //       }
          //     },
          //     numberItems: widget.jobFormPageState.edcEquipments.map((e) {
          //       JobOrderEdcEquipment? jobOrderEdcEquipment = jobOrder
          //           .edcEquipments
          //           .firstWhereOrNull((element) => element.name == e.name);

          //       return NumberItem(
          //         identity: e.name,
          //         description: Strings.pretty(e.name),
          //         tag: e,
          //         value: jobOrderEdcEquipment != null
          //             ? jobOrderEdcEquipment.quantity
          //             : 0,
          //       );
          //     }).toList(),
          //   ),
          // ),
          ...edcFeatureTest(),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomCheckListField(
            title: "DAFTAR PERIKSA KATEGORI PEKERJAAN",
            readOnly: widget.jobFormPageState.widget.readOnly,
            validator: (value) {
              if (value != null) {
                if (widget.jobFormPageState.selectedJobStatus != null &&
                    widget.jobFormPageState.selectedJobStatus!.identity ==
                        "9") {
                  CheckItem? checkItem =
                      value.firstWhereOrNull((element) => element.value);

                  if (checkItem == null) {
                    return "Silahkan pilih minimal satu.";
                  }
                }
              }

              return null;
            },
            onSaved: (value) {
              if (value != null) {
                Realms.get().write(() {
                  jobOrder.jobCategories.clear();

                  for (CheckItem checkItem in value) {
                    jobOrder.jobCategories.add(
                      JobOrderJobCategory(
                        checkItem.identity,
                        checkItem.description,
                        checkItem.value,
                      ),
                    );
                  }
                });
              }
            },
            checkItems: widget.jobFormPageState.jobCategories.map((e) {
              JobOrderJobCategory? jobOrderJobCategory = jobOrder.jobCategories
                  .firstWhereOrNull((element) => element.id == e.id);

              return CheckItem(
                identity: e.id,
                description: e.name,
                tag: e,
                value: jobOrderJobCategory != null
                    ? jobOrderJobCategory.value
                    : false,
              );
            }).toList(),
          ),
          ...trainingMaterial(),
          ...otherBankEdc(),
          ...edcUpdate(),
          ...vendorMtiOnly(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  List<Widget> requiredThermalCount() {
    JobOrder jobOrder = widget.jobFormPageState.widget.jobOrder;

    if (jobOrder.jobType != null) {
      if (Strings.equalsAny(jobOrder.jobType!.id, ["6", "9", "20"])) {
        return [
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomInformation(
            title: "Jumlah Thermal Yang Dibutuhkan",
            content: TextSheet(
              StringUtils.defaultString(jobOrder.requiredThermalCount),
            ),
          )
        ];
      }
    }

    return [];
  }

  List<Widget> checklistNotes() {
    JobOrder jobOrder = widget.jobFormPageState.widget.jobOrder;

    if (Strings.equalsAny(jobOrder.vendorId, ["3"])) {
      return [
        SizedBox(
          height: Dimensions.height15,
        ),
        CustomCheckListField(
          title: "DAFTAR PERIKSA CATATAN",
          readOnly: widget.jobFormPageState.widget.readOnly,
          validator: (value) {
            if (value != null) {
              if (widget.jobFormPageState.selectedJobStatus != null &&
                  widget.jobFormPageState.selectedJobStatus!.identity == "9") {
                CheckItem? checkItem =
                    value.firstWhereOrNull((element) => element.value);

                if (checkItem == null) {
                  return "Silahkan pilih minimal satu.";
                }
              }
            }

            return null;
          },
          onSaved: (value) {
            if (value != null) {
              Realms.get().write(() {
                jobOrder.notes.clear();

                for (CheckItem checkItem in value) {
                  jobOrder.notes.add(
                    JobOrderNote(
                      checkItem.identity,
                      checkItem.description,
                      checkItem.value,
                    ),
                  );
                }
              });
            }
          },
          checkItems: widget.jobFormPageState.notes.map((e) {
            JobOrderNote? jobOrderNote = jobOrder.notes
                .firstWhereOrNull((element) => element.id == e.id);

            return CheckItem(
              identity: e.id,
              description: e.name,
              tag: e,
              value: jobOrderNote != null ? jobOrderNote.value : false,
            );
          }).toList(),
        )
      ];
    }

    return [];
  }

  List<Widget> qris() {
    JobOrder jobOrder = widget.jobFormPageState.widget.jobOrder;

    if (Strings.equalsAny(jobOrder.vendorId, ["3"])) {
      return [
        SizedBox(
          height: Dimensions.height15,
        ),
        CustomInformation(
          content: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: TextSheet(
                      "QRIS",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FormField<bool>(
                    onSaved: (value) {
                      if (value != null) {
                        Realms.get().write(() {
                          jobOrder.qris ??= JobOrderQris(false, false);
                          jobOrder.qris!.exist = value;
                        });
                      }
                    },
                    initialValue: hasQris,
                    builder: (field) => CupertinoSwitch(
                      value: field.value ?? false,
                      onChanged: widget.jobFormPageState.widget.readOnly
                          ? null
                          : (value) {
                              setState(() {
                                field.setValue(value);

                                hasQris = value;
                              });
                            },
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
              Visibility(
                visible: hasQris,
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimensions.height5,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: TextSheet(
                            "Hasil Pengecekan",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FormField<List<bool>>(
                          onSaved: (value) {
                            if (value != null) {
                              Realms.get().write(() {
                                jobOrder.qris ??= JobOrderQris(false, false);
                                jobOrder.qris!.testResult = value[1];
                              });
                            }
                          },
                          initialValue: [!qrisCheckResult, qrisCheckResult],
                          builder: (field) => ToggleButtons(
                            isSelected: [field.value![0], field.value![1]],
                            onPressed: (int index) {
                              if (!widget.jobFormPageState.widget.readOnly) {
                                setState(() {
                                  field.value![0] = !field.value![0];
                                  field.value![1] = !field.value![0];
                                });
                              }
                            },
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.width5,
                                ),
                                child: const Text("Tidak Berhasil"),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.width5,
                                ),
                                child: const Text("Berhasil"),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height5,
                    ),
                    CustomCheckListField(
                      title: "Menu QRIS",
                      readOnly: widget.jobFormPageState.widget.readOnly,
                      validator: (value) {
                        if (value != null) {
                          if (widget.jobFormPageState.selectedJobStatus !=
                                  null &&
                              widget.jobFormPageState.selectedJobStatus!
                                      .identity ==
                                  "9") {
                            CheckItem? checkItem = value
                                .firstWhereOrNull((element) => element.value);

                            if (checkItem == null) {
                              return "Silahkan pilih minimal satu.";
                            }
                          }
                        }

                        return null;
                      },
                      onSaved: (value) {
                        if (value != null) {
                          Realms.get().write(() {
                            jobOrder.qris ??= JobOrderQris(false, false);
                            jobOrder.qris!.menus.clear();

                            for (CheckItem checkItem in value) {
                              jobOrder.qris!.menus.add(
                                JobOrderQrisMenu(
                                  checkItem.identity,
                                  checkItem.description,
                                  checkItem.value,
                                ),
                              );
                            }
                          });
                        }
                      },
                      checkItems: widget.jobFormPageState.qrisMenus.map((e) {
                        JobOrderQrisMenu? jobOrderQrisMenu;

                        if (jobOrder.qris != null) {
                          jobOrderQrisMenu =
                              jobOrder.qris!.menus.firstWhereOrNull(
                            (element) => element.id == e.id,
                          );
                        }

                        return CheckItem(
                          identity: e.id,
                          description: e.name,
                          tag: e,
                          value: jobOrderQrisMenu != null
                              ? jobOrderQrisMenu.value
                              : false,
                        );
                      }).toList(),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ];
    }

    return [];
  }

  List<Widget> edcFeatureTest() {
    JobOrder jobOrder = widget.jobFormPageState.widget.jobOrder;

    if (Strings.equalsAny(jobOrder.vendorId, ["3"])) {
      return [
        SizedBox(
          height: Dimensions.height15,
        ),
        CustomCheckListField(
          title: "DAFTAR PENGUJIAN FITUR EDC",
          readOnly: widget.jobFormPageState.widget.readOnly,
          validator: (value) {
            if (value != null) {
              if (widget.jobFormPageState.selectedJobStatus != null &&
                  widget.jobFormPageState.selectedJobStatus!.identity == "9") {
                CheckItem? checkItem =
                    value.firstWhereOrNull((element) => element.value);

                if (checkItem == null) {
                  return "Silahkan pilih minimal satu.";
                }
              }
            }

            return null;
          },
          onSaved: (value) {
            if (value != null) {
              Realms.get().write(() {
                jobOrder.edcFeatureTestCases.clear();

                for (CheckItem checkItem in value) {
                  jobOrder.edcFeatureTestCases.add(
                    JobOrderEdcFeatureTestCase(
                      checkItem.identity,
                      checkItem.description,
                      checkItem.value,
                    ),
                  );
                }
              });
            }
          },
          checkItems: widget.jobFormPageState.edcFeatureTestCases.map((e) {
            JobOrderEdcFeatureTestCase? jobOrderEdcFeatureTestCase = jobOrder
                .edcFeatureTestCases
                .firstWhereOrNull((element) => element.id == e.id);

            return CheckItem(
              identity: e.id,
              description: e.name,
              groupBy: e.type,
              tag: e,
              value: jobOrderEdcFeatureTestCase != null
                  ? jobOrderEdcFeatureTestCase.value
                  : false,
            );
          }).toList(),
        )
      ];
    }

    return [];
  }

  List<Widget> trainingMaterial() {
    JobOrder jobOrder = widget.jobFormPageState.widget.jobOrder;

    if (Strings.equalsAny(jobOrder.vendorId, ["2"])) {
      return [
        SizedBox(
          height: Dimensions.height15,
        ),
        CustomCheckListField(
          title: "DAFTAR MATERI PELATIHAN",
          readOnly: widget.jobFormPageState.widget.readOnly,
          validator: (value) {
            if (value != null) {
              if (widget.jobFormPageState.selectedJobStatus != null &&
                  widget.jobFormPageState.selectedJobStatus!.identity == "9") {
                CheckItem? checkItem =
                    value.firstWhereOrNull((element) => element.value);

                if (checkItem == null) {
                  return "Silahkan pilih minimal satu.";
                }
              }
            }

            return null;
          },
          onSaved: (value) {
            if (value != null) {
              Realms.get().write(() {
                jobOrder.trainingMaterials.clear();

                for (CheckItem checkItem in value) {
                  jobOrder.trainingMaterials.add(
                    JobOrderTrainingMaterial(
                      checkItem.identity,
                      checkItem.description,
                      checkItem.value,
                    ),
                  );
                }
              });
            }
          },
          checkItems: widget.jobFormPageState.trainingMaterials.map((e) {
            JobOrderTrainingMaterial? jobOrderTrainingMaterial = jobOrder
                .trainingMaterials
                .firstWhereOrNull((element) => element.id == e.id);

            return CheckItem(
              identity: e.id,
              description: e.name,
              tag: e,
              value: jobOrderTrainingMaterial != null
                  ? jobOrderTrainingMaterial.value
                  : false,
            );
          }).toList(),
        ),
      ];
    }

    return [];
  }

  List<Widget> otherBankEdc() {
    JobOrder jobOrder = widget.jobFormPageState.widget.jobOrder;

    if (jobOrder.jobType != null) {
      if (Strings.equalsAny(jobOrder.vendorId, ["2"])) {
        return [
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomCheckListField(
            title: "DAFTAR EDC BANK LAIN",
            readOnly: widget.jobFormPageState.widget.readOnly,
            validator: (value) {
              if (value != null) {
                if (widget.jobFormPageState.selectedJobStatus != null &&
                    widget.jobFormPageState.selectedJobStatus!.identity ==
                        "9") {
                  CheckItem? checkItem =
                      value.firstWhereOrNull((element) => element.value);

                  if (checkItem == null) {
                    return "Silahkan pilih minimal satu.";
                  }
                }
              }

              return null;
            },
            onSaved: (value) {
              if (value != null) {
                Realms.get().write(() {
                  jobOrder.otherBankEdcs.clear();

                  for (CheckItem checkItem in value) {
                    jobOrder.otherBankEdcs.add(
                      JobOrderOtherBankEdc(
                        checkItem.identity,
                        checkItem.description,
                        checkItem.value,
                      ),
                    );
                  }
                });
              }
            },
            checkItems: widget.jobFormPageState.otherBankEdcs.map((e) {
              JobOrderOtherBankEdc? jobOrderOtherBankEdc = jobOrder
                  .otherBankEdcs
                  .firstWhereOrNull((element) => element.id == e.id);

              return CheckItem(
                identity: e.id,
                description: e.name,
                tag: e,
                value: jobOrderOtherBankEdc != null
                    ? jobOrderOtherBankEdc.value
                    : false,
              );
            }).toList(),
          ),
        ];
      }
    }

    return [];
  }

  List<Widget> edcUpdate() {
    JobOrder jobOrder = widget.jobFormPageState.widget.jobOrder;

    List<Map<String, dynamic>> versiEdc = [
      {"id": 1, "name": "data1"},
      {"id": 2, "name": "data2"},
      {"id": 3, "name": "data3"}
    ];

    List<Map<String, dynamic>> patchOS = [
      {
        "id": 1,
        "name": "patchOS1",
        "versiEdc": "1",
      },
      {
        "id": 2,
        "name": "patchOS2",
        "versiEdc": "2",
      },
      {
        "id": 3,
        "name": "patchOS3",
        "versiEdc": "3",
      },
    ];

    if (jobOrder.jobType != null) {
      if (Strings.equalsAny(jobOrder.jobType!.id, ["6", "20"])) {
        return [
          SizedBox(
            height: Dimensions.height15,
          ),
          const TextSheet(
            "EDC UPDATES",
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomSpinnerField(
            labelText: "Check Stiker EDC",
            initialValue: jobOrder.edcUpdate != null &&
                    jobOrder.edcUpdate!.dorMenu != null
                ? SpinnerItem(
                    identity: jobOrder.edcUpdate!.dorMenu!.id,
                    description: StringUtils.defaultString(
                      jobOrder.edcUpdate!.dorMenu!.name,
                    ),
                  )
                : null,
            readOnly: widget.jobFormPageState.widget.readOnly,
            validator: (value) {
              if (value == null) {
                return "Kolom ini harus diisi.";
              }

              return null;
            },
            onSaved: (value) {
              if (value != null) {
                Realms.get().write(() {
                  jobOrder.edcUpdate ??= JobOrderEdcUpdate();

                  if (jobOrder.edcUpdate!.dorMenu == null) {
                    jobOrder.edcUpdate!.dorMenu = JobOrderDorMenu(
                      value.identity,
                      value.description,
                    );
                  } else {
                    jobOrder.edcUpdate!.dorMenu!.id = value.identity;
                    jobOrder.edcUpdate!.dorMenu!.name = value.description;
                  }
                });
              }
            },
            spinnerItems: widget.jobFormPageState.dorMenus
                .map(
                  (e) => SpinnerItem(
                    identity: e.id,
                    description: e.name,
                    tag: e,
                  ),
                )
                .toList(),
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomSpinnerField(
            labelText: "Update Marcoll",
            initialValue: jobOrder.edcUpdate != null &&
                    jobOrder.edcUpdate!.marcollUpdateStatus != null
                ? SpinnerItem(
                    identity: jobOrder.edcUpdate!.marcollUpdateStatus!.id,
                    description: StringUtils.defaultString(
                      jobOrder.edcUpdate!.marcollUpdateStatus!.name,
                    ),
                  )
                : null,
            readOnly: widget.jobFormPageState.widget.readOnly,
            validator: (value) {
              if (value == null) {
                return "Kolom ini harus diisi.";
              }

              return null;
            },
            onSaved: (value) {
              if (value != null) {
                Realms.get().write(() {
                  jobOrder.edcUpdate ??= JobOrderEdcUpdate();

                  if (jobOrder.edcUpdate!.marcollUpdateStatus == null) {
                    jobOrder.edcUpdate!.marcollUpdateStatus =
                        JobOrderMarcollUpdateStatus(
                      value.identity,
                      value.description,
                    );
                  } else {
                    jobOrder.edcUpdate!.marcollUpdateStatus!.id =
                        value.identity;
                    jobOrder.edcUpdate!.marcollUpdateStatus!.name =
                        value.description;
                  }
                });
              }
            },
            spinnerItems: widget.jobFormPageState.marcollUpdateStatuses
                .map(
                  (e) => SpinnerItem(
                    identity: e.id,
                    description: e.name,
                    tag: e,
                  ),
                )
                .toList(),
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomSpinnerField(
            labelText: "Update EOS",
            initialValue: jobOrder.edcUpdate != null &&
                    jobOrder.edcUpdate!.eosUpdateStatus != null
                ? SpinnerItem(
                    identity: jobOrder.edcUpdate!.eosUpdateStatus!.id,
                    description: StringUtils.defaultString(
                      jobOrder.edcUpdate!.eosUpdateStatus!.name,
                    ),
                  )
                : null,
            readOnly: widget.jobFormPageState.widget.readOnly,
            validator: (value) {
              if (value == null) {
                return "Kolom ini harus diisi.";
              }

              return null;
            },
            onSaved: (value) {
              if (value != null) {
                Realms.get().write(() {
                  jobOrder.edcUpdate ??= JobOrderEdcUpdate();

                  if (jobOrder.edcUpdate!.eosUpdateStatus == null) {
                    jobOrder.edcUpdate!.eosUpdateStatus =
                        JobOrderEosUpdateStatus(
                      value.identity,
                      value.description,
                    );
                  } else {
                    jobOrder.edcUpdate!.eosUpdateStatus!.id = value.identity;
                    jobOrder.edcUpdate!.eosUpdateStatus!.name =
                        value.description;
                  }
                });
              }
            },
            spinnerItems: widget.jobFormPageState.eosUpdateStatuses
                .map(
                  (e) => SpinnerItem(
                    identity: e.id,
                    description: e.name,
                    tag: e,
                  ),
                )
                .toList(),
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomSpinnerField(
            labelText: "App Version",
            initialValue: jobOrder.edcUpdate != null &&
                    jobOrder.edcUpdate!.appVersion != null &&
                    versiEdcAndroid ==
                        widget.jobFormPageState.widget.jobOrder.machineAndCard!
                            .edcType!.id
                            .toString()
                ? SpinnerItem(
                    identity: jobOrder.edcUpdate!.appVersion!.id,
                    description: StringUtils.defaultString(
                      jobOrder.edcUpdate!.appVersion!.name,
                    ),
                  )
                : null,
            readOnly: widget.jobFormPageState.widget.readOnly,
            validator: (value) {
              if (value == null) {
                return "Kolom ini harus diisi.";
              }

              return null;
            },
            onSaved: (value) {
              if (value != null) {
                Realms.get().write(() {
                  jobOrder.edcUpdate ??= JobOrderEdcUpdate();

                  if (jobOrder.edcUpdate!.appVersion == null) {
                    jobOrder.edcUpdate!.appVersion = JobOrderAppVersion(
                      value.identity.toString(),
                      value.description,
                      versiEdcAndroid.toString(),
                    );
                  } else {
                    jobOrder.edcUpdate!.appVersion = JobOrderAppVersion(
                      value.identity.toString(),
                      value.description,
                      versiEdcAndroid.toString(),
                    );
                  }
                });
              }
            },
            onChanged: (newValue) {
              setState(() {
                versiEdcId = newValue.identity.toString();
                versiEdcAndroid =
                    (newValue.tag as AppVersion).id_tipe_dc.toString();
                if (ffsPatchOs.currentState != null) {
                  tecPatchOs.clear();
                  ffsPatchOs.currentState!.setValue(null);
                }
              });
            },
            spinnerItems: widget.jobFormPageState.appVersion
                .where((element) {
                  if (element.id_tipe_dc.toString() ==
                      widget.jobFormPageState.widget.jobOrder.machineAndCard!
                          .edcType!.id
                          .toString()) {
                    return true;
                  }
                  return false;
                })
                .map((e) => SpinnerItem(
                      identity: e.id_versi_aplikasi,
                      description: e.versi_aplikasi,
                      tag: e,
                    ),)
                .toList(),
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomSpinnerField(
            textEditingController: tecPatchOs,
            fieldKey: ffsPatchOs,
            labelText: "OS Patch",
            initialValue: jobOrder.edcUpdate != null &&
                    jobOrder.edcUpdate!.osPatch != null &&
                    versiEdcAndroid ==
                        widget.jobFormPageState.widget.jobOrder.machineAndCard!
                            .edcType!.id
                            .toString()
                ? SpinnerItem(
                    identity: jobOrder.edcUpdate!.osPatch!.id,
                    description: StringUtils.defaultString(
                      jobOrder.edcUpdate!.osPatch!.name,
                    ),
                  )
                : null,
            readOnly: widget.jobFormPageState.widget.readOnly,
            validator: (value) {
              if (value == null) {
                return "Kolom ini harus diisi.";
              }

              return null;
            },
            onSaved: (value) {
              if (value != null) {
                Realms.get().write(() {
                  jobOrder.edcUpdate ??= JobOrderEdcUpdate();

                  if (jobOrder.edcUpdate!.osPatch == null) {
                    jobOrder.edcUpdate!.osPatch = JobOrderOsPatch(
                      value.identity.toString(),
                      value.description,
                    );
                  } else {
                    jobOrder.edcUpdate!.osPatch = JobOrderOsPatch(
                      value.identity.toString(),
                      value.description,
                    );
                  }
                });
              }
            },
            spinnerItems: widget.jobFormPageState.osPatch
                .where((element) {
                  if (element.id_versi_aplikasi.toString() == versiEdcId &&
                      element.id_tipe_edc.toString() ==
                          widget.jobFormPageState.widget.jobOrder
                              .machineAndCard!.edcType!.id
                              .toString()) {
                    return true;
                  }
                  return false;
                })
                .map((e) => SpinnerItem(
                      identity: e.id_os_patch,
                      description: e.os_patch_name,
                      tag: e,
                    ))
                .toList(),
          ),
        ];
      }
    }

    return [];
  }

  List<Widget> vendorMtiOnly() {
    JobOrder jobOrder = widget.jobFormPageState.widget.jobOrder;
    List<Widget> widgets = [];
    if (Strings.equalsAny(jobOrder.vendorId, ["2"])) {
      widgets.add(
        SizedBox(
          height: Dimensions.height15,
        ),
      );
      widgets.add(
        CustomSpinnerField(
          labelText: "Cleaning EDC",
          initialValue: jobOrder.edcUpdate != null &&
              jobOrder.edcUpdate!.cleaningEdc != null
              ? SpinnerItem(
            identity: jobOrder.edcUpdate!.cleaningEdc!.id,
            description: StringUtils.defaultString(
              jobOrder.edcUpdate!.cleaningEdc!.name,
            ),
          )
              : null,
          readOnly: widget.jobFormPageState.widget.readOnly,
          validator: (value) {
            if (value == null) {
              return "Kolom ini harus diisi.";
            }

            return null;
          },
          onSaved: (value) {
            if (value != null) {
              Realms.get().write(() {
                jobOrder.edcUpdate ??= JobOrderEdcUpdate();

                if (jobOrder.edcUpdate!.cleaningEdc == null) {
                  jobOrder.edcUpdate!.cleaningEdc = JobOrderCleaningEdc(
                    value.identity.toString(),
                    value.description,
                  );
                } else {
                  jobOrder.edcUpdate!.cleaningEdc!.id =
                      value.identity.toString();
                  jobOrder.edcUpdate!.cleaningEdc!.name = value.description;
                }
              });
            }
          },
          spinnerItems: cleanEdc
              .map((e) => SpinnerItem(
            identity: e['id'],
            description: e['name'],
            tag: e,
          ))
              .toList(),
        ),
      );
      widgets.add(
        SizedBox(
          height: Dimensions.height15,
        ),
      );
      widgets.add(
        CustomSpinnerField(
          labelText: "Sticker Bank",
          initialValue: jobOrder.edcUpdate != null &&
              jobOrder.edcUpdate!.stickerBank != null
              ? SpinnerItem(
            identity: jobOrder.edcUpdate!.stickerBank!.id,
            description: StringUtils.defaultString(
              jobOrder.edcUpdate!.stickerBank!.name,
            ),
          )
              : null,
          readOnly: widget.jobFormPageState.widget.readOnly,
          validator: (value) {
            if (value == null) {
              return "Kolom ini harus diisi.";
            }

            return null;
          },
          onSaved: (value) {
            if (value != null) {
              Realms.get().write(() {
                jobOrder.edcUpdate ??= JobOrderEdcUpdate();

                if (jobOrder.edcUpdate!.stickerBank == null) {
                  jobOrder.edcUpdate!.stickerBank = JobOrderStickerBank(
                    value.identity.toString(),
                    value.description,
                  );
                } else {
                  jobOrder.edcUpdate!.stickerBank!.id =
                      value.identity.toString();
                  jobOrder.edcUpdate!.stickerBank!.name = value.description;
                }
              });
            }
          },
          spinnerItems: widget.jobFormPageState.stickerBank
              .map((e) => SpinnerItem(
            identity: e.idx,
            description: e.nama_sticker_bank,
            tag: e,
          ))
              .toList(),
        ),
      );
    }
    return widgets;
  }
}
