import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/helper/bottom_sheets.dart';
import 'package:rtracker/helper/dimensions.dart';
import 'package:rtracker/helper/formats.dart';
import 'package:rtracker/helper/navigators.dart';
import 'package:rtracker/helper/preferences.dart';
import 'package:rtracker/helper/strings.dart';
import 'package:rtracker/helper/widgets.dart';
import 'package:rtracker/module/job_form/job_form_page.dart';
import 'package:rtracker/module/scan_sn/scan_sn.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/sn_stock_dao.dart';
import 'package:rtracker/widget/custom_alt_text_field.dart';
import 'package:rtracker/widget/custom_image_field.dart';
import 'package:rtracker/widget/custom_scan_field.dart';
import 'package:rtracker/widget/custom_spinner_field.dart';
import 'package:rtracker/widget/custom_text_field.dart';
import 'package:rtracker/widget/information/basic_information.dart';
import 'package:rtracker/widget/information/custom_information.dart';
import 'package:rtracker/widget/information/dual_information.dart';
import 'package:rtracker/widget/text_sheet.dart';

class RangkumanPekerjaan extends StatefulWidget {
  final JobFormPageState jobFormPageState;

  const RangkumanPekerjaan({
    Key? key,
    required this.jobFormPageState,
  }) : super(key: key);

  @override
  State<RangkumanPekerjaan> createState() => RangkumanPekerjaanState();
}

class RangkumanPekerjaanState extends State<RangkumanPekerjaan>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController tecSimCard = TextEditingController();
  final TextEditingController tecSam = TextEditingController();
  final TextEditingController tecSam2 = TextEditingController();
  final TextEditingController tecSam3 = TextEditingController();
  final TextEditingController tecSam4 = TextEditingController();
  final TextEditingController tecSam5 = TextEditingController();
  final TextEditingController tecSam6 = TextEditingController();
  final TextEditingController tecSam7 = TextEditingController();

  GlobalKey<FormFieldState> ffsSimCard = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> ffsSam = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> ffsSam2 = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> ffsSam3 = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> ffsSam4 = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> ffsSam5 = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> ffsSam6 = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> ffsSam7 = GlobalKey<FormFieldState>();

  bool machineConditionNormal = false;

  List<Uint8List> merchantImages = [];

  int? testFlagAndroid;

  @override
  void initState() {
    super.initState();
    print("flag_android");
    print(widget.jobFormPageState.widget.jobOrder.machineAndCard?.edcType
        ?.flag_android);

    if (widget.jobFormPageState.widget.jobOrder.machineAndCard?.edcType
            ?.flag_android !=
        null) {
      setState(() {
        testFlagAndroid = int.parse(widget.jobFormPageState.widget.jobOrder
            .machineAndCard!.edcType!.flag_android);
      });
    }
    fill();
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
            'INFORMASI PEKERJAAN',
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          BasicInformation(
            title: 'Jenis Pekerjaan',
            subtitle: jobOrder.jobType != null
                ? StringUtils.defaultString(jobOrder.jobType!.name)
                : "",
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          BasicInformation(
            title: 'Merchant',
            subtitle: jobOrder.merchant != null
                ? StringUtils.defaultString(jobOrder.merchant!.name)
                : "",
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          DualInformation(
            firstTitle: 'CASE/FMS/ID',
            firstSubtitle: StringUtils.defaultString(jobOrder.caseId),
            secondTitle: 'MID',
            secondSubtitle: StringUtils.defaultString(jobOrder.mid),
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          DualInformation(
            firstTitle: 'TID',
            firstSubtitle: StringUtils.defaultString(jobOrder.tid),
            secondTitle: 'POI',
            secondSubtitle: StringUtils.defaultString(jobOrder.poi),
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          DualInformation(
            firstTitle: 'ICCID',
            firstSubtitle: StringUtils.defaultString(jobOrder.iccid),
            secondTitle: 'MSISDN',
            secondSubtitle: StringUtils.defaultString(jobOrder.msisdn),
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          DualInformation(
            firstTitle: 'Provider',
            firstSubtitle: StringUtils.defaultString(jobOrder.provider),
            secondTitle: 'Simcard',
            secondSubtitle: StringUtils.defaultString(jobOrder.simCard),
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          BasicInformation(
            title: 'Serial Number',
            subtitle: StringUtils.defaultString(jobOrder.serialNumber),
          ),
          ...remarkCM(),
          SizedBox(
            height: Dimensions.height15,
          ),
          const TextSheet(
            'KETERANGAN WAKTU',
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          DualInformation(
            firstTitle: 'Berangkat',
            firstSubtitle: jobOrder.timing != null
                ? Formats.dateTime(jobOrder.timing!.departure)
                : "",
            secondTitle: 'Kunjungan',
            secondSubtitle: jobOrder.timing != null
                ? Formats.dateTime(jobOrder.timing!.visit)
                : "",
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          DualInformation(
            firstTitle: 'Mulai',
            firstSubtitle: jobOrder.timing != null
                ? Formats.dateTime(jobOrder.timing!.start)
                : "",
            secondTitle: 'Jeda',
            secondSubtitle: jobOrder.timing != null
                ? Formats.dateTime(jobOrder.timing!.pause)
                : "",
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          DualInformation(
            firstTitle: 'Selesai',
            firstSubtitle: jobOrder.timing != null
                ? Formats.dateTime(jobOrder.timing!.finish)
                : "",
            secondTitle: 'Unggah',
            secondSubtitle: Formats.dateTime(jobOrder.uploadDate),
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomImageField(
            title: "FOTO PLANG MERCHANT",
            subtitle: "Silahkan unggah foto plang merchant",
            allowGallery: Preferences.getInstance().getBool(
                  SharedPreferenceKey.MERCHANT_IMAGE_ALLOW_GALLERY,
                ) ??
                false,
            validator: (value) {
              if (jobOrder.imageMandatoryType[1] == "1") {
                if (value == null || value.isEmpty) {
                  return "Kolom ini harus diisi.";
                }
              }

              if (value != null && value.length > 3) {
                return "Gambar maksimal 3";
              }

              return null;
            },
            readOnly: widget.jobFormPageState.widget.readOnly,
            initialValue: jobOrder.merchant != null
                ? jobOrder.merchant!.images
                    .map((e) => Uint8List.fromList(e.file))
                    .toList()
                : [],
            onSaved: (newValue) {
              if (newValue != null && jobOrder.merchant != null) {
                Realms.get().write(() {
                  jobOrder.merchant!.images.clear();

                  for (Uint8List uint8List in newValue) {
                    jobOrder.merchant!.images.add(
                      ImageFile(file: uint8List),
                    );
                  }
                });
              }
            },
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          Visibility(
            visible: jobOrder.serialNumberMandatoryType[0] == "1",
            child: CustomScanField(
              title: "PINDAI NOMOR SERI",
              readOnly: widget.jobFormPageState.widget.readOnly,
              validator: (value) {
                int maxDigit =
                    int.parse(jobOrder.serialNumberMaxDigit.split("-")[0]);

                if (jobOrder.serialNumberValidationType[0] != "0") {
                  if (StringUtils.isNullOrEmpty(value)) {
                    return "Kolom ini harus diisi.";
                  }

                  if (jobOrder.serialNumberValidationType[0] == "1") {
                    if (value!.length < maxDigit) {
                      return "Minimal karakter $maxDigit.";
                    }
                  } else if (jobOrder.serialNumberValidationType[0] == "2") {
                    if (SnStockDao.find(
                          serialNumber: value!,
                          servicePointId: widget.jobFormPageState.widget
                              .jobOrder.servicePoint!.id,
                          category: SnStockCategory.MESIN.name,
                        ) ==
                        null) {
                      return "Nomor seri tidak ditemukan.";
                    }
                  } else if (jobOrder.serialNumberValidationType[0] == "3") {
                    if (!StringUtils.equalsIgnoreCase(
                      value!,
                      widget.jobFormPageState.widget.jobOrder.serialNumber ??
                          "",
                    )) {
                      return "Nomor seri tidak sesuai.";
                    }
                  } else if (jobOrder.serialNumberValidationType[0] == "4") {
                    if (SnStockDao.find(
                              serialNumber: value!,
                              servicePointId: widget.jobFormPageState.widget
                                  .jobOrder.servicePoint!.id,
                              category: SnStockCategory.MESIN.name,
                            ) ==
                            null ||
                        !StringUtils.equalsIgnoreCase(
                          value,
                          widget.jobFormPageState.widget.jobOrder
                                  .serialNumber ??
                              "",
                        )) {
                      return "Nomor seri tidak sesuai.";
                    }
                  }
                }

                return null;
              },
              initialValue:
                  StringUtils.defaultString(jobOrder.scannedSerialNumber),
              onSaved: (newValue) {
                Realms.get().write(() {
                  if (!Strings.equals(jobOrder.scannedSerialNumber, newValue)) {
                    jobOrder.scannedSerialNumber = newValue;
                  }
                });
              },
            ),
          ),
          ...machineCondition(),
          SizedBox(
            height: Dimensions.height15,
          ),
          const TextSheet(
            'MESIN DAN KARTU',
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomSpinnerField(
            labelText: 'Provider',
            initialValue: jobOrder.machineAndCard != null &&
                    jobOrder.machineAndCard!.provider != null
                ? SpinnerItem(
                    identity: jobOrder.machineAndCard!.provider!.id,
                    description: jobOrder.machineAndCard!.provider!.name,
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
                  jobOrder.machineAndCard ??= JobOrderMachineAndCard();

                  if (jobOrder.machineAndCard!.provider == null) {
                    jobOrder.machineAndCard!.provider = JobOrderProvider(
                      value.identity,
                      value.description,
                    );
                  } else {
                    jobOrder.machineAndCard!.provider!.id = value.identity;
                    jobOrder.machineAndCard!.provider!.name = value.description;
                  }
                });
              }
            },
            spinnerItems: widget.jobFormPageState.providers
                .map(
                  (e) => SpinnerItem(
                    identity: e.id,
                    description: e.name,
                  ),
                )
                .toList(),
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          Visibility(
            visible: jobOrder.serialNumberMandatoryType[1] == "1",
            child: Column(
              children: [
                CustomTextField(
                  fieldKey: ffsSimCard,
                  controller: tecSimCard,
                  label: 'Simcard',
                  readOnly: widget.jobFormPageState.widget.readOnly,
                  suffixIcon: widget.jobFormPageState.widget.readOnly
                      ? null
                      : IconButton(
                          icon: const Icon(
                            Icons.qr_code_scanner,
                          ),
                          onPressed: () async {
                            Permission.camera.request().then((value) {
                              if (value.isGranted) {
                                Navigators.push(
                                  context,
                                  ScannerPage(
                                    onSubmitted: (String value) {
                                      setState(() {
                                        if (ffsSimCard.currentState != null) {
                                          tecSimCard.text = value;
                                          ffsSimCard.currentState!
                                              .setValue(value);
                                        }
                                      });
                                    },
                                  ),
                                );
                              }
                            });
                          },
                        ),
                  validator: (value) {
                    int maxDigit =
                        int.parse(jobOrder.serialNumberMaxDigit.split("-")[1]);

                    if (jobOrder.serialNumberValidationType[1] != "0") {
                      if (StringUtils.isNullOrEmpty(value)) {
                        return "Kolom ini harus diisi.";
                      }

                      if (jobOrder.serialNumberValidationType[1] == "1") {
                        if (value!.length < maxDigit) {
                          return "Minimal karakter $maxDigit.";
                        }
                      } else if (jobOrder.serialNumberValidationType[1] ==
                          "2") {
                        if (SnStockDao.find(
                              serialNumber: value!,
                              servicePointId: widget.jobFormPageState.widget
                                  .jobOrder.servicePoint!.id,
                              category: SnStockCategory.PROVIDER.name,
                            ) ==
                            null) {
                          return "Nomor seri tidak ditemukan.";
                        }
                      } else if (jobOrder.serialNumberValidationType[1] ==
                          "3") {
                        if (!StringUtils.equalsIgnoreCase(
                          value!,
                          widget.jobFormPageState.widget.jobOrder.simCard ?? "",
                        )) {
                          return "Nomor seri tidak sesuai.";
                        }
                      } else if (jobOrder.serialNumberValidationType[1] ==
                          "4") {
                        if (SnStockDao.find(
                                  serialNumber: value!,
                                  servicePointId: widget.jobFormPageState.widget
                                      .jobOrder.servicePoint!.id,
                                  category: SnStockCategory.PROVIDER.name,
                                ) ==
                                null ||
                            !StringUtils.equalsIgnoreCase(
                              value,
                              widget.jobFormPageState.widget.jobOrder.simCard ??
                                  "",
                            )) {
                          return "Nomor seri tidak sesuai.";
                        }
                      }
                    }

                    return null;
                  },
                  onSaved: (value) {
                    Realms.get().write(() {
                      jobOrder.machineAndCard ??= JobOrderMachineAndCard();

                      if (!Strings.equals(
                        jobOrder.machineAndCard!.simCard,
                        value,
                      )) {
                        jobOrder.machineAndCard!.simCard = value;
                      }
                    });
                  },
                ),
                SizedBox(
                  height: Dimensions.height15,
                )
              ],
            ),
          ),
          Visibility(
            visible: jobOrder.serialNumberMandatoryType[2] == "1",
            child: Column(
              children: [
                CustomTextField(
                  fieldKey: ffsSam,
                  controller: tecSam,
                  label: 'SAM BRI',
                  readOnly: widget.jobFormPageState.widget.readOnly,
                  suffixIcon: widget.jobFormPageState.widget.readOnly
                      ? null
                      : IconButton(
                          icon: const Icon(
                            Icons.qr_code_scanner,
                          ),
                          onPressed: () async {
                            Permission.camera.request().then((value) {
                              if (value.isGranted) {
                                Navigators.push(
                                  context,
                                  ScannerPage(
                                    onSubmitted: (String value) {
                                      setState(() {
                                        if (ffsSam.currentState != null) {
                                          tecSam.text = value;
                                          ffsSam.currentState!.setValue(value);
                                        }
                                      });
                                    },
                                  ),
                                );
                              }
                            });
                          },
                        ),
                  validator: (value) {
                    int maxDigit =
                        int.parse(jobOrder.serialNumberMaxDigit.split("-")[2]);

                    if (jobOrder.serialNumberValidationType[2] != "0") {
                      if (StringUtils.isNullOrEmpty(value)) {
                        return "Kolom ini harus diisi.";
                      }

                      if (jobOrder.serialNumberValidationType[2] == "1") {
                        if (value!.length < maxDigit) {
                          return "Minimal karakter $maxDigit.";
                        }
                      } else if (jobOrder.serialNumberValidationType[2] ==
                          "2") {
                        if (SnStockDao.find(
                              serialNumber: value!,
                              servicePointId: widget.jobFormPageState.widget
                                  .jobOrder.servicePoint!.id,
                              category: SnStockCategory.SAMCARD.name,
                            ) ==
                            null) {
                          return "Nomor seri tidak ditemukan.";
                        }
                      } else if (jobOrder.serialNumberValidationType[2] ==
                          "3") {
                        if (!StringUtils.equalsIgnoreCase(
                          value!,
                          widget.jobFormPageState.widget.jobOrder.sam ?? "",
                        )) {
                          return "Nomor seri tidak sesuai.";
                        }
                      } else if (jobOrder.serialNumberValidationType[2] ==
                          "4") {
                        if (SnStockDao.find(
                                  serialNumber: value!,
                                  servicePointId: widget.jobFormPageState.widget
                                      .jobOrder.servicePoint!.id,
                                  category: SnStockCategory.SAMCARD.name,
                                ) ==
                                null ||
                            !StringUtils.equalsIgnoreCase(
                              value,
                              widget.jobFormPageState.widget.jobOrder.sam ?? "",
                            )) {
                          return "Nomor seri tidak sesuai.";
                        }
                      }
                    }

                    return null;
                  },
                  onSaved: (value) {
                    Realms.get().write(() {
                      jobOrder.machineAndCard ??= JobOrderMachineAndCard();

                      if (!Strings.equals(
                        jobOrder.machineAndCard!.sam,
                        value,
                      )) {
                        jobOrder.machineAndCard!.sam = value;
                      }
                    });
                  },
                ),
                SizedBox(
                  height: Dimensions.height15,
                )
              ],
            ),
          ),
          Visibility(
            visible: jobOrder.serialNumberMandatoryType[3] == "1",
            child: Column(
              children: [
                CustomTextField(
                  fieldKey: ffsSam2,
                  controller: tecSam2,
                  label: 'SAM MANDIRI',
                  readOnly: widget.jobFormPageState.widget.readOnly,
                  suffixIcon: widget.jobFormPageState.widget.readOnly
                      ? null
                      : IconButton(
                          icon: const Icon(
                            Icons.qr_code_scanner,
                          ),
                          onPressed: () async {
                            Permission.camera.request().then((value) {
                              if (value.isGranted) {
                                Navigators.push(
                                  context,
                                  ScannerPage(
                                    onSubmitted: (String value) {
                                      setState(() {
                                        if (ffsSam2.currentState != null) {
                                          tecSam2.text = value;
                                          ffsSam2.currentState!.setValue(value);
                                        }
                                      });
                                    },
                                  ),
                                );
                              }
                            });
                          },
                        ),
                  validator: (value) {
                    int maxDigit =
                        int.parse(jobOrder.serialNumberMaxDigit.split("-")[3]);

                    if (jobOrder.serialNumberValidationType[3] != "0") {
                      if (StringUtils.isNullOrEmpty(value)) {
                        return "Kolom ini harus diisi.";
                      }

                      if (jobOrder.serialNumberValidationType[3] == "1") {
                        if (value!.length < maxDigit) {
                          return "Minimal karakter $maxDigit.";
                        }
                      } else if (jobOrder.serialNumberValidationType[3] ==
                          "2") {
                        if (SnStockDao.find(
                              serialNumber: value!,
                              servicePointId: widget.jobFormPageState.widget
                                  .jobOrder.servicePoint!.id,
                              category: SnStockCategory.SAMCARD.name,
                            ) ==
                            null) {
                          return "Nomor seri tidak ditemukan.";
                        }
                      } else if (jobOrder.serialNumberValidationType[3] ==
                          "3") {
                        if (!StringUtils.equalsIgnoreCase(
                          value!,
                          widget.jobFormPageState.widget.jobOrder.sam2 ?? "",
                        )) {
                          return "Nomor seri tidak sesuai.";
                        }
                      } else if (jobOrder.serialNumberValidationType[3] ==
                          "4") {
                        if (SnStockDao.find(
                                  serialNumber: value!,
                                  servicePointId: widget.jobFormPageState.widget
                                      .jobOrder.servicePoint!.id,
                                  category: SnStockCategory.SAMCARD.name,
                                ) ==
                                null ||
                            !StringUtils.equalsIgnoreCase(
                              value,
                              widget.jobFormPageState.widget.jobOrder.sam2 ??
                                  "",
                            )) {
                          return "Nomor seri tidak sesuai.";
                        }
                      }
                    }

                    if (StringUtils.isNotNullOrEmpty(value)) {
                      if (Strings.equalsAny(value, [tecSam.text])) {
                        return "Duplikat nomor seri.";
                      }
                    }

                    return null;
                  },
                  onSaved: (value) {
                    Realms.get().write(() {
                      jobOrder.machineAndCard ??= JobOrderMachineAndCard();

                      if (!Strings.equals(
                        jobOrder.machineAndCard!.sam2,
                        value,
                      )) {
                        jobOrder.machineAndCard!.sam2 = value;
                      }
                    });
                  },
                ),
                SizedBox(
                  height: Dimensions.height15,
                )
              ],
            ),
          ),
          Visibility(
            visible: jobOrder.serialNumberMandatoryType[4] == "1",
            child: Column(
              children: [
                CustomTextField(
                  fieldKey: ffsSam3,
                  controller: tecSam3,
                  label: 'SAM BNI',
                  readOnly: widget.jobFormPageState.widget.readOnly,
                  suffixIcon: widget.jobFormPageState.widget.readOnly
                      ? null
                      : IconButton(
                          icon: const Icon(
                            Icons.qr_code_scanner,
                          ),
                          onPressed: () async {
                            Permission.camera.request().then((value) {
                              if (value.isGranted) {
                                Navigators.push(
                                  context,
                                  ScannerPage(
                                    onSubmitted: (String value) {
                                      setState(() {
                                        if (ffsSam3.currentState != null) {
                                          tecSam3.text = value;
                                          ffsSam3.currentState!.setValue(value);
                                        }
                                      });
                                    },
                                  ),
                                );
                              }
                            });
                          },
                        ),
                  validator: (value) {
                    int maxDigit =
                        int.parse(jobOrder.serialNumberMaxDigit.split("-")[4]);

                    if (jobOrder.serialNumberValidationType[4] != "0") {
                      if (StringUtils.isNullOrEmpty(value)) {
                        return "Kolom ini harus diisi.";
                      }

                      if (jobOrder.serialNumberValidationType[4] == "1") {
                        if (value!.length < maxDigit) {
                          return "Minimal karakter $maxDigit.";
                        }
                      } else if (jobOrder.serialNumberValidationType[4] ==
                          "2") {
                        if (SnStockDao.find(
                              serialNumber: value!,
                              servicePointId: widget.jobFormPageState.widget
                                  .jobOrder.servicePoint!.id,
                              category: SnStockCategory.SAMCARD.name,
                            ) ==
                            null) {
                          return "Nomor seri tidak ditemukan.";
                        }
                      } else if (jobOrder.serialNumberValidationType[4] ==
                          "3") {
                        if (!StringUtils.equalsIgnoreCase(
                          value!,
                          widget.jobFormPageState.widget.jobOrder.sam3 ?? "",
                        )) {
                          return "Nomor seri tidak sesuai.";
                        }
                      } else if (jobOrder.serialNumberValidationType[4] ==
                          "4") {
                        if (SnStockDao.find(
                                  serialNumber: value!,
                                  servicePointId: widget.jobFormPageState.widget
                                      .jobOrder.servicePoint!.id,
                                  category: SnStockCategory.SAMCARD.name,
                                ) ==
                                null ||
                            !StringUtils.equalsIgnoreCase(
                              value,
                              widget.jobFormPageState.widget.jobOrder.sam3 ??
                                  "",
                            )) {
                          return "Nomor seri tidak sesuai.";
                        }
                      }
                    }

                    if (StringUtils.isNotNullOrEmpty(value)) {
                      if (Strings.equalsAny(
                        value,
                        [tecSam.text, tecSam2.text],
                      )) {
                        return "Duplikat nomor seri.";
                      }
                    }

                    return null;
                  },
                  onSaved: (value) {
                    Realms.get().write(() {
                      jobOrder.machineAndCard ??= JobOrderMachineAndCard();

                      if (!Strings.equals(
                        jobOrder.machineAndCard!.sam3,
                        value,
                      )) {
                        jobOrder.machineAndCard!.sam3 = value;
                      }
                    });
                  },
                ),
                SizedBox(
                  height: Dimensions.height15,
                )
              ],
            ),
          ),
          Visibility(
            visible: jobOrder.serialNumberMandatoryType[5] == "1",
            child: Column(
              children: [
                CustomTextField(
                  fieldKey: ffsSam4,
                  controller: tecSam4,
                  label: 'SAM BTN',
                  readOnly: widget.jobFormPageState.widget.readOnly,
                  suffixIcon: widget.jobFormPageState.widget.readOnly
                      ? null
                      : IconButton(
                          icon: const Icon(
                            Icons.qr_code_scanner,
                          ),
                          onPressed: () async {
                            Permission.camera.request().then((value) {
                              if (value.isGranted) {
                                Navigators.push(
                                  context,
                                  ScannerPage(
                                    onSubmitted: (String value) {
                                      setState(() {
                                        if (ffsSam4.currentState != null) {
                                          tecSam4.text = value;
                                          ffsSam4.currentState!.setValue(value);
                                        }
                                      });
                                    },
                                  ),
                                );
                              }
                            });
                          },
                        ),
                  validator: (value) {
                    int maxDigit =
                        int.parse(jobOrder.serialNumberMaxDigit.split("-")[5]);

                    if (jobOrder.serialNumberValidationType[5] != "0") {
                      if (StringUtils.isNullOrEmpty(value)) {
                        return "Kolom ini harus diisi.";
                      }

                      if (jobOrder.serialNumberValidationType[5] == "1") {
                        if (value!.length < maxDigit) {
                          return "Minimal karakter $maxDigit.";
                        }
                      } else if (jobOrder.serialNumberValidationType[5] ==
                          "2") {
                        if (SnStockDao.find(
                              serialNumber: value!,
                              servicePointId: widget.jobFormPageState.widget
                                  .jobOrder.servicePoint!.id,
                              category: SnStockCategory.SAMCARD.name,
                            ) ==
                            null) {
                          return "Nomor seri tidak ditemukan.";
                        }
                      } else if (jobOrder.serialNumberValidationType[5] ==
                          "3") {
                        if (!StringUtils.equalsIgnoreCase(
                          value!,
                          widget.jobFormPageState.widget.jobOrder.sam4 ?? "",
                        )) {
                          return "Nomor seri tidak sesuai.";
                        }
                      } else if (jobOrder.serialNumberValidationType[5] ==
                          "4") {
                        if (SnStockDao.find(
                                  serialNumber: value!,
                                  servicePointId: widget.jobFormPageState.widget
                                      .jobOrder.servicePoint!.id,
                                  category: SnStockCategory.SAMCARD.name,
                                ) ==
                                null ||
                            !StringUtils.equalsIgnoreCase(
                              value,
                              widget.jobFormPageState.widget.jobOrder.sam4 ??
                                  "",
                            )) {
                          return "Nomor seri tidak sesuai.";
                        }
                      }
                    }

                    if (StringUtils.isNotNullOrEmpty(value)) {
                      if (Strings.equalsAny(
                        value,
                        [tecSam.text, tecSam2.text, tecSam3.text],
                      )) {
                        return "Duplikat nomor seri.";
                      }
                    }

                    return null;
                  },
                  onSaved: (value) {
                    Realms.get().write(() {
                      jobOrder.machineAndCard ??= JobOrderMachineAndCard();

                      if (!Strings.equals(
                        jobOrder.machineAndCard!.sam4,
                        value,
                      )) {
                        jobOrder.machineAndCard!.sam4 = value;
                      }
                    });
                  },
                ),
                SizedBox(
                  height: Dimensions.height15,
                )
              ],
            ),
          ),
          Visibility(
            visible: jobOrder.serialNumberMandatoryType[6] == "1",
            child: Column(
              children: [
                CustomTextField(
                  fieldKey: ffsSam5,
                  controller: tecSam5,
                  label: 'SAM BSI',
                  readOnly: widget.jobFormPageState.widget.readOnly,
                  suffixIcon: widget.jobFormPageState.widget.readOnly
                      ? null
                      : IconButton(
                          icon: const Icon(
                            Icons.qr_code_scanner,
                          ),
                          onPressed: () async {
                            Permission.camera.request().then((value) {
                              if (value.isGranted) {
                                Navigators.push(
                                  context,
                                  ScannerPage(
                                    onSubmitted: (String value) {
                                      setState(() {
                                        if (ffsSam5.currentState != null) {
                                          tecSam5.text = value;
                                          ffsSam5.currentState!.setValue(value);
                                        }
                                      });
                                    },
                                  ),
                                );
                              }
                            });
                          },
                        ),
                  validator: (value) {
                    int maxDigit =
                        int.parse(jobOrder.serialNumberMaxDigit.split("-")[6]);

                    if (jobOrder.serialNumberValidationType[6] != "0") {
                      if (StringUtils.isNullOrEmpty(value)) {
                        return "Kolom ini harus diisi.";
                      }

                      if (jobOrder.serialNumberValidationType[6] == "1") {
                        if (value!.length < maxDigit) {
                          return "Minimal karakter $maxDigit.";
                        }
                      } else if (jobOrder.serialNumberValidationType[6] ==
                          "2") {
                        if (SnStockDao.find(
                              serialNumber: value!,
                              servicePointId: widget.jobFormPageState.widget
                                  .jobOrder.servicePoint!.id,
                              category: SnStockCategory.SAMCARD.name,
                            ) ==
                            null) {
                          return "Nomor seri tidak ditemukan.";
                        }
                      } else if (jobOrder.serialNumberValidationType[6] ==
                          "3") {
                        if (!StringUtils.equalsIgnoreCase(
                          value!,
                          widget.jobFormPageState.widget.jobOrder.sam5 ?? "",
                        )) {
                          return "Nomor seri tidak sesuai.";
                        }
                      } else if (jobOrder.serialNumberValidationType[6] ==
                          "4") {
                        if (SnStockDao.find(
                                  serialNumber: value!,
                                  servicePointId: widget.jobFormPageState.widget
                                      .jobOrder.servicePoint!.id,
                                  category: SnStockCategory.SAMCARD.name,
                                ) ==
                                null ||
                            !StringUtils.equalsIgnoreCase(
                              value,
                              widget.jobFormPageState.widget.jobOrder.sam5 ??
                                  "",
                            )) {
                          return "Nomor seri tidak sesuai.";
                        }
                      }
                    }

                    if (StringUtils.isNotNullOrEmpty(value)) {
                      if (Strings.equalsAny(value, [
                        tecSam.text,
                        tecSam2.text,
                        tecSam3.text,
                        tecSam4.text
                      ])) {
                        return "Duplikat nomor seri.";
                      }
                    }

                    return null;
                  },
                  onSaved: (value) {
                    Realms.get().write(() {
                      jobOrder.machineAndCard ??= JobOrderMachineAndCard();

                      if (!Strings.equals(
                        jobOrder.machineAndCard!.sam5,
                        value,
                      )) {
                        jobOrder.machineAndCard!.sam5 = value;
                      }
                    });
                  },
                ),
                SizedBox(
                  height: Dimensions.height15,
                )
              ],
            ),
          ),
          Visibility(
            visible: jobOrder.serialNumberMandatoryType[7] == "1",
            child: Column(
              children: [
                CustomTextField(
                  fieldKey: ffsSam6,
                  controller: tecSam6,
                  label: 'SAM DANAMON',
                  readOnly: widget.jobFormPageState.widget.readOnly,
                  suffixIcon: widget.jobFormPageState.widget.readOnly
                      ? null
                      : IconButton(
                          icon: const Icon(
                            Icons.qr_code_scanner,
                          ),
                          onPressed: () async {
                            Permission.camera.request().then((value) {
                              if (value.isGranted) {
                                Navigators.push(
                                  context,
                                  ScannerPage(
                                    onSubmitted: (String value) {
                                      setState(() {
                                        if (ffsSam6.currentState != null) {
                                          tecSam6.text = value;
                                          ffsSam6.currentState!.setValue(value);
                                        }
                                      });
                                    },
                                  ),
                                );
                              }
                            });
                          },
                        ),
                  validator: (value) {
                    int maxDigit =
                        int.parse(jobOrder.serialNumberMaxDigit.split("-")[7]);

                    if (jobOrder.serialNumberValidationType[7] != "0") {
                      if (StringUtils.isNullOrEmpty(value)) {
                        return "Kolom ini harus diisi.";
                      }

                      if (jobOrder.serialNumberValidationType[7] == "1") {
                        if (value!.length < maxDigit) {
                          return "Minimal karakter $maxDigit.";
                        }
                      } else if (jobOrder.serialNumberValidationType[7] ==
                          "2") {
                        if (SnStockDao.find(
                              serialNumber: value!,
                              servicePointId: widget.jobFormPageState.widget
                                  .jobOrder.servicePoint!.id,
                              category: SnStockCategory.SAMCARD.name,
                            ) ==
                            null) {
                          return "Nomor seri tidak ditemukan.";
                        }
                      } else if (jobOrder.serialNumberValidationType[7] ==
                          "3") {
                        if (!StringUtils.equalsIgnoreCase(
                          value!,
                          widget.jobFormPageState.widget.jobOrder.sam6 ?? "",
                        )) {
                          return "Nomor seri tidak sesuai.";
                        }
                      } else if (jobOrder.serialNumberValidationType[7] ==
                          "4") {
                        if (SnStockDao.find(
                                  serialNumber: value!,
                                  servicePointId: widget.jobFormPageState.widget
                                      .jobOrder.servicePoint!.id,
                                  category: SnStockCategory.SAMCARD.name,
                                ) ==
                                null ||
                            !StringUtils.equalsIgnoreCase(
                              value,
                              widget.jobFormPageState.widget.jobOrder.sam6 ??
                                  "",
                            )) {
                          return "Nomor seri tidak sesuai.";
                        }
                      }
                    }

                    if (StringUtils.isNotNullOrEmpty(value)) {
                      if (Strings.equalsAny(value, [
                        tecSam.text,
                        tecSam2.text,
                        tecSam3.text,
                        tecSam4.text,
                        tecSam5.text
                      ])) {
                        return "Duplikat nomor seri.";
                      }
                    }

                    return null;
                  },
                  onSaved: (value) {
                    Realms.get().write(() {
                      jobOrder.machineAndCard ??= JobOrderMachineAndCard();

                      if (!Strings.equals(
                        jobOrder.machineAndCard!.sam6,
                        value,
                      )) {
                        jobOrder.machineAndCard!.sam6 = value;
                      }
                    });
                  },
                ),
                SizedBox(
                  height: Dimensions.height15,
                )
              ],
            ),
          ),
          Visibility(
            visible: jobOrder.serialNumberMandatoryType[8] == "1",
            child: Column(
              children: [
                CustomTextField(
                  fieldKey: ffsSam7,
                  controller: tecSam7,
                  label: 'SAM ASTRAPAY',
                  readOnly: widget.jobFormPageState.widget.readOnly,
                  suffixIcon: widget.jobFormPageState.widget.readOnly
                      ? null
                      : IconButton(
                          icon: const Icon(
                            Icons.qr_code_scanner,
                          ),
                          onPressed: () async {
                            Permission.camera.request().then((value) {
                              if (value.isGranted) {
                                Navigators.push(
                                  context,
                                  ScannerPage(
                                    onSubmitted: (String value) {
                                      setState(() {
                                        if (ffsSam7.currentState != null) {
                                          tecSam7.text = value;
                                          ffsSam7.currentState!.setValue(value);
                                        }
                                      });
                                    },
                                  ),
                                );
                              }
                            });
                          },
                        ),
                  validator: (value) {
                    int maxDigit =
                        int.parse(jobOrder.serialNumberMaxDigit.split("-")[8]);

                    if (jobOrder.serialNumberValidationType[8] != "0") {
                      if (StringUtils.isNullOrEmpty(value)) {
                        return "Kolom ini harus diisi.";
                      }

                      if (jobOrder.serialNumberValidationType[8] == "1") {
                        if (value!.length < maxDigit) {
                          return "Minimal karakter $maxDigit.";
                        }
                      } else if (jobOrder.serialNumberValidationType[8] ==
                          "2") {
                        if (SnStockDao.find(
                              serialNumber: value!,
                              servicePointId: widget.jobFormPageState.widget
                                  .jobOrder.servicePoint!.id,
                              category: SnStockCategory.SAMCARD.name,
                            ) ==
                            null) {
                          return "Nomor seri tidak ditemukan.";
                        }
                      } else if (jobOrder.serialNumberValidationType[8] ==
                          "3") {
                        if (!StringUtils.equalsIgnoreCase(
                          value!,
                          widget.jobFormPageState.widget.jobOrder.sam7 ?? "",
                        )) {
                          return "Nomor seri tidak sesuai.";
                        }
                      } else if (jobOrder.serialNumberValidationType[8] ==
                          "4") {
                        if (SnStockDao.find(
                                  serialNumber: value!,
                                  servicePointId: widget.jobFormPageState.widget
                                      .jobOrder.servicePoint!.id,
                                  category: SnStockCategory.SAMCARD.name,
                                ) ==
                                null ||
                            !StringUtils.equalsIgnoreCase(
                              value,
                              widget.jobFormPageState.widget.jobOrder.sam7 ??
                                  "",
                            )) {
                          return "Nomor seri tidak sesuai.";
                        }
                      }
                    }

                    if (StringUtils.isNotNullOrEmpty(value)) {
                      if (Strings.equalsAny(value, [
                        tecSam.text,
                        tecSam2.text,
                        tecSam3.text,
                        tecSam4.text,
                        tecSam5.text,
                        tecSam6.text
                      ])) {
                        return "Duplikat nomor seri.";
                      }
                    }

                    return null;
                  },
                  onSaved: (value) {
                    Realms.get().write(() {
                      jobOrder.machineAndCard ??= JobOrderMachineAndCard();

                      if (!Strings.equals(
                        jobOrder.machineAndCard!.sam7,
                        value,
                      )) {
                        jobOrder.machineAndCard!.sam7 = value;
                      }
                    });
                  },
                ),
                SizedBox(
                  height: Dimensions.height15,
                )
              ],
            ),
          ),
          CustomSpinnerField(
            labelText: 'Jenis EDC',
            initialValue: jobOrder.machineAndCard != null &&
                    jobOrder.machineAndCard!.edcType != null
                ? SpinnerItem(
                    identity: jobOrder.machineAndCard!.edcType!.id,
                    description: jobOrder.machineAndCard!.edcType!.name,
                    tag: jobOrder.machineAndCard!.edcType!,
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
                  jobOrder.machineAndCard ??= JobOrderMachineAndCard();

                  if (jobOrder.machineAndCard!.edcType == null) {
                    jobOrder.machineAndCard!.edcType = JobOrderEdcType(
                      value.identity,
                      value.description,
                      testFlagAndroid.toString(),
                    );
                  } else {
                    // jobOrder.machineAndCard!.edcType!.id = value.identity;
                    // jobOrder.machineAndCard!.edcType!.name = value.description;
                    // jobOrder.machineAndCard!.edcType!.flag_android =
                    //     testFlagAndroid.toString();

                    jobOrder.machineAndCard!.edcType = JobOrderEdcType(
                      value.identity,
                      value.description,
                      testFlagAndroid.toString(),
                    );
                  }
                });
              }
            },
            onChanged: (newValue) {
              setState(() {
                testFlagAndroid = (newValue.tag as EdcType).flag_android;
              });
            },
            spinnerItems: widget.jobFormPageState.edcTypes
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
            labelText: 'Jenis Komunikasi EDC',
            initialValue: jobOrder.machineAndCard != null &&
                    jobOrder.machineAndCard!.edcCommunicationType != null
                ? SpinnerItem(
                    identity: jobOrder.machineAndCard!.edcCommunicationType!.id,
                    description:
                        jobOrder.machineAndCard!.edcCommunicationType!.name,
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
                  jobOrder.machineAndCard ??= JobOrderMachineAndCard();

                  if (jobOrder.machineAndCard!.edcCommunicationType == null) {
                    jobOrder.machineAndCard!.edcCommunicationType =
                        JobOrderEdcCommunicationType(
                      value.identity,
                      value.description,
                    );
                  } else {
                    jobOrder.machineAndCard!.edcCommunicationType!.id =
                        value.identity;
                    jobOrder.machineAndCard!.edcCommunicationType!.name =
                        value.description;
                  }
                });
              }
            },
            spinnerItems: widget.jobFormPageState.edcCommunicationTypes
                .map(
                  (e) => SpinnerItem(
                    identity: e.id,
                    description: e.name,
                  ),
                )
                .toList(),
          ),
          ...cekPoi(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void fill() {
    JobOrder jobOrder = widget.jobFormPageState.widget.jobOrder;

    if (jobOrder.merchant != null) {
      for (ImageFile imageFile in jobOrder.merchant!.images) {
        merchantImages.add(
          Uint8List.fromList(imageFile.file),
        );
      }
    }

    if (jobOrder.machineAndCard != null) {
      Widgets.fill(
        textEditingController: tecSimCard,
        value: jobOrder.machineAndCard!.simCard,
      );
      Widgets.fill(
        textEditingController: tecSam,
        value: jobOrder.machineAndCard!.sam,
      );
      Widgets.fill(
        textEditingController: tecSam2,
        value: jobOrder.machineAndCard!.sam2,
      );
      Widgets.fill(
        textEditingController: tecSam3,
        value: jobOrder.machineAndCard!.sam3,
      );
      Widgets.fill(
        textEditingController: tecSam4,
        value: jobOrder.machineAndCard!.sam4,
      );
      Widgets.fill(
        textEditingController: tecSam5,
        value: jobOrder.machineAndCard!.sam5,
      );
      Widgets.fill(
        textEditingController: tecSam6,
        value: jobOrder.machineAndCard!.sam6,
      );
      Widgets.fill(
        textEditingController: tecSam7,
        value: jobOrder.machineAndCard!.sam7,
      );
    }

    machineConditionNormal = jobOrder.machineConditionNormal;
  }

  List<Widget> machineCondition() {
    JobOrder jobOrder = widget.jobFormPageState.widget.jobOrder;

    if (jobOrder.jobType != null) {
      if (Strings.equalsAny(jobOrder.jobType!.id, ["21", "18"])) {
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
                        "Keadaan Mesin Normal",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FormField<bool>(
                      onSaved: (value) {
                        if (value != null) {
                          Realms.get().write(() {
                            jobOrder.machineConditionNormal = value;
                          });
                        }
                      },
                      initialValue: machineConditionNormal,
                      builder: (field) => CupertinoSwitch(
                        value: field.value ?? false,
                        onChanged: widget.jobFormPageState.widget.readOnly
                            ? null
                            : (value) {
                                setState(() {
                                  field.setValue(value);

                                  machineConditionNormal = value;
                                });
                              },
                        activeColor: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  ],
                ),
                Visibility(
                  visible: !machineConditionNormal,
                  child: CustomSpinnerField(
                    labelText: 'Jenis Kerusakan',
                    initialValue: jobOrder.damageType != null
                        ? SpinnerItem(
                            identity: jobOrder.damageType!.id,
                            description: jobOrder.damageType!.name,
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
                          if (jobOrder.damageType == null) {
                            jobOrder.damageType = JobOrderDamageType(
                              value.identity,
                              value.description,
                            );
                          } else {
                            jobOrder.damageType!.id = value.identity;
                            jobOrder.damageType!.name = value.description;
                          }
                        });
                      }
                    },
                    spinnerItems: widget.jobFormPageState.damageTypes
                        .map(
                          (e) => SpinnerItem(
                            identity: e.id,
                            description: e.name,
                          ),
                        )
                        .toList(),
                  ),
                )
              ],
            ),
          )
        ];
      }
    }

    return [];
  }

  List<Widget> remarkCM() {
    JobOrder jobOrder = widget.jobFormPageState.widget.jobOrder;

    if (jobOrder.jobType != null) {
      if (Strings.equalsAny(jobOrder.jobType!.id, ["12"])) {
        return [
          SizedBox(
            height: Dimensions.height15,
          ),
          BasicInformation(
            title: 'Remark CM',
            subtitle: StringUtils.defaultString(jobOrder.cmRemark),
          )
        ];
      }
    }

    return [];
  }

  List<Widget> cekPoi() {
    JobOrder jobOrder = widget.jobFormPageState.widget.jobOrder;

    if (Strings.equalsAny(jobOrder.vendorId, ["3"])) {
      return [
        SizedBox(
          height: Dimensions.height15,
        ),
        CustomAltTextField(
          title: "CEK POI",
          initialValue: StringUtils.defaultString(jobOrder.poi),
          readOnly: widget.jobFormPageState.widget.readOnly,
          validator: (value) {
            if (StringUtils.isNullOrEmpty(value)) {
              return "Kolom ini harus diisi.";
            }

            return null;
          },
          onSaved: (newValue) {
            Realms.get().write(() {
              jobOrder.poi = newValue;
            });
          },
        )
      ];
    }

    return [];
  }
}
