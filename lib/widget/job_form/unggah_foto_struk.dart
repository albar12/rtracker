import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/helper/bottom_sheets.dart';
import 'package:rtracker/helper/dimensions.dart';
import 'package:rtracker/helper/image_mandatory.dart';
import 'package:rtracker/helper/preferences.dart';
import 'package:rtracker/helper/strings.dart';
import 'package:rtracker/module/job_form/job_form_page.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/widget/custom_checklist_field.dart';
import 'package:rtracker/widget/custom_datetime_field.dart';
import 'package:rtracker/widget/custom_image_field.dart';
import 'package:rtracker/widget/information/custom_information.dart';

class UnggahFotoStruk extends StatefulWidget {
  final JobFormPageState jobFormPageState;

  const UnggahFotoStruk({
    Key? key,
    required this.jobFormPageState,
  }) : super(key: key);

  @override
  State<UnggahFotoStruk> createState() => UnggahFotoStrukState();
}

class UnggahFotoStrukState extends State<UnggahFotoStruk>
    with AutomaticKeepAliveClientMixin {
  List<Uint8List> transactionTestImages = [];
  List<Uint8List> qrisReceiptImages = [];
  List<Uint8List> brizziInstallmentReceiptImages = [];

  @override
  void initState() {
    super.initState();

    JobOrder jobOrder = widget.jobFormPageState.widget.jobOrder;

    if (jobOrder.transactionTest != null) {
      for (ImageFile imageFile in jobOrder.transactionTest!.images) {
        transactionTestImages.add(
          Uint8List.fromList(imageFile.file),
        );
      }
    }

    if (jobOrder.qris != null) {
      for (ImageFile imageFile in jobOrder.qris!.qrisReceiptImages) {
        qrisReceiptImages.add(
          Uint8List.fromList(imageFile.file),
        );
      }

      for (ImageFile imageFile
          in jobOrder.qris!.brizziInstallmentReceiptImages) {
        brizziInstallmentReceiptImages.add(
          Uint8List.fromList(imageFile.file),
        );
      }
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
          CustomInformation(
            title: 'TEST TRANSAKSI',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDateTimeField(
                  labelText: "Tanggal",
                  initialValue: jobOrder.transactionTest != null &&
                          jobOrder.transactionTest!.date != null
                      ? jobOrder.transactionTest!.date
                      : null,
                  readOnly: widget.jobFormPageState.widget.readOnly,
                  validator: (value) {
                    if (widget.jobFormPageState.widget.jobOrder.status !=
                        null) {
                      if (widget.jobFormPageState.widget.jobOrder.status!.id ==
                          "9") {
                        if (value == null) {
                          return "Kolom ini harus diisi.";
                        }
                      }
                    }

                    return null;
                  },
                  onSaved: (value) {
                    if (value != null) {
                      Realms.get().write(() {
                        jobOrder.transactionTest ??= JobOrderTransactionTest();
                        jobOrder.transactionTest!.date = value.toUtc();
                      });
                    }
                  },
                ),
                CustomCheckListField(
                  title: "KASUS PENGUJIAN",
                  readOnly: widget.jobFormPageState.widget.readOnly,
                  validator: (value) {
                    if (widget
                        .jobFormPageState.transactionTestCases.isNotEmpty) {
                      if (value != null) {
                        if (widget.jobFormPageState.selectedJobStatus != null &&
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
                    }

                    return null;
                  },
                  onSaved: (value) {
                    if (value != null) {
                      Realms.get().write(() {
                        jobOrder.transactionTest ??= JobOrderTransactionTest();
                        jobOrder.transactionTest!.cases.clear();

                        for (CheckItem checkItem in value) {
                          TransactionTestCase transactionTestCase =
                              checkItem.tag as TransactionTestCase;

                          jobOrder.transactionTest!.cases.add(
                            JobOrderTransactionTestCase(
                              transactionTestCase.id,
                              transactionTestCase.name,
                              transactionTestCase.amount,
                              checkItem.value,
                            ),
                          );
                        }
                      });
                    }
                  },
                  checkItems:
                      widget.jobFormPageState.transactionTestCases.map((e) {
                    JobOrderTransactionTestCase? jobOrderTransactionTestCase;

                    if (jobOrder.transactionTest != null) {
                      jobOrderTransactionTestCase = jobOrder
                          .transactionTest!.cases
                          .firstWhereOrNull((element) => element.id == e.id);
                    }

                    return CheckItem(
                      identity: e.id,
                      description: e.name,
                      subtitle: e.amount,
                      tag: e,
                      value: jobOrderTransactionTestCase != null
                          ? jobOrderTransactionTestCase.value
                          : false,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomImageField(
            title: "FOTO SALES DRAFT",
            subtitle: "Silahkan unggah foto sales draft",
            allowGallery: Preferences.getInstance().getBool(
                  SharedPreferenceKey.TRANSACTION_TEST_IMAGE_ALLOW_GALLERY,
                ) ??
                false,
            validator: (value) {
              if (ImageMandatory.getImageMandatory(jobOrder.imageMandatoryType, ImageMandatoryKey.struck) == "1") {
                if (value == null || value.isEmpty) {
                  return "Kolom ini harus diisi.";
                }
              }

              if (value != null && value.length > 3) {
                return "Gambar maksimal 3";
              }

              return null;
            },
            initialValue: jobOrder.transactionTest != null
                ? jobOrder.transactionTest!.images
                    .map((e) => Uint8List.fromList(e.file))
                    .toList()
                : [],
            readOnly: widget.jobFormPageState.widget.readOnly,
            onSaved: (newValue) {
              if (newValue != null && jobOrder.transactionTest != null) {
                Realms.get().write(() {
                  jobOrder.transactionTest!.images.clear();

                  for (Uint8List uint8List in newValue) {
                    jobOrder.transactionTest!.images.add(
                      ImageFile(file: uint8List),
                    );
                  }
                });
              }
            },
          ),
          ...qrisAndBrizziReceiptImage()
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  List<Widget> qrisAndBrizziReceiptImage() {
    JobOrder jobOrder = widget.jobFormPageState.widget.jobOrder;

    if (Strings.equalsAny(jobOrder.vendorId, ["3"])) {
      return [
        SizedBox(
          height: Dimensions.height15,
        ),
        CustomImageField(
          title: "FOTO STRUK QRIS",
          subtitle: "Silahkan unggah foto struk QRIS",
          allowGallery: Preferences.getInstance().getBool(
                SharedPreferenceKey.QRIS_RECEIPT_IMAGE_ALLOW_GALLERY,
              ) ??
              false,
          validator: (value) {
            if (ImageMandatory.getImageMandatory(jobOrder.imageMandatoryType, ImageMandatoryKey.struckQris) == "1") {
              if (value == null || value.isEmpty) {
                return "Kolom ini harus diisi.";
              }
            }

            if (value != null && value.length > 3) {
              return "Gambar maksimal 3";
            }

            return null;
          },
          initialValue: jobOrder.qris != null
              ? jobOrder.qris!.qrisReceiptImages
                  .map((e) => Uint8List.fromList(e.file))
                  .toList()
              : [],
          readOnly: widget.jobFormPageState.widget.readOnly,
          onSaved: (newValue) {
            if (newValue != null && jobOrder.qris != null) {
              Realms.get().write(() {
                jobOrder.qris!.qrisReceiptImages.clear();

                for (Uint8List uint8List in newValue) {
                  jobOrder.qris!.qrisReceiptImages.add(
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
        CustomImageField(
          title: "FOTO STRUK CICILAN BRIZZI",
          subtitle: "Silahkan unggah foto struk cicilan Brizzi",
          allowGallery: Preferences.getInstance().getBool(
                SharedPreferenceKey
                    .BRIZZI_INSTALLMENT_RECEIPT_IMAGE_ALLOW_GALLERY,
              ) ??
              false,
          validator: (value) {
            if (ImageMandatory.getImageMandatory(jobOrder.imageMandatoryType, ImageMandatoryKey.struckBrizzi) == "1") {
              if (value == null || value.isEmpty) {
                return "Kolom ini harus diisi.";
              }
            }

            if (value != null && value.length > 3) {
              return "Gambar maksimal 3";
            }

            return null;
          },
          initialValue: jobOrder.qris != null
              ? jobOrder.qris!.brizziInstallmentReceiptImages
                  .map((e) => Uint8List.fromList(e.file))
                  .toList()
              : [],
          readOnly: widget.jobFormPageState.widget.readOnly,
          onSaved: (newValue) {
            if (newValue != null && jobOrder.qris != null) {
              Realms.get().write(() {
                jobOrder.qris!.brizziInstallmentReceiptImages.clear();

                for (Uint8List uint8List in newValue) {
                  jobOrder.qris!.brizziInstallmentReceiptImages.add(
                    ImageFile(file: uint8List),
                  );
                }
              });
            }
          },
        )
      ];
    }

    return [];
  }
}
