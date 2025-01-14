import 'dart:typed_data';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/helper/app_colors.dart';
import 'package:rtracker/helper/bottom_sheets.dart';
import 'package:rtracker/helper/dimensions.dart';
import 'package:rtracker/helper/image_mandatory.dart';
import 'package:rtracker/helper/widgets.dart';
import 'package:rtracker/module/job_form/job_form_page.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/widget/custom_spinner_field.dart';
import 'package:rtracker/widget/custom_switch.dart';
import 'package:rtracker/widget/custom_text_area.dart';
import 'package:rtracker/widget/custom_text_field.dart';
import 'package:rtracker/widget/information/custom_information.dart';
import 'package:rtracker/widget/text_sheet.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class ParafPicDataMerchant extends StatefulWidget {
  final JobFormPageState jobFormPageState;

  const ParafPicDataMerchant({
    Key? key,
    required this.jobFormPageState,
  }) : super(key: key);

  @override
  State<ParafPicDataMerchant> createState() => ParafPicDataMerchantState();
}

class ParafPicDataMerchantState extends State<ParafPicDataMerchant>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController tecPicName = TextEditingController();
  final TextEditingController tecPicPosition = TextEditingController();
  final TextEditingController tecPicPhoneNumber = TextEditingController();
  final TextEditingController tecInvoiceCount = TextEditingController();
  final TextEditingController tecNote = TextEditingController();

  final TextEditingController tecPriorityEDC = TextEditingController();
  final TextEditingController tecMerchantComment = TextEditingController();
  final TextEditingController tecMostUsedEDC = TextEditingController();
  final TextEditingController tecMerchantRequest = TextEditingController();
  final TextEditingController tecPromoMaterial = TextEditingController();

  final GlobalKey<SfSignaturePadState> gkSignaturePadState = GlobalKey();

  bool hasSign = false;

  @override
  void initState() {
    super.initState();

    JobOrder jobOrder = widget.jobFormPageState.widget.jobOrder;

    if (jobOrder.merchant != null) {
      Widgets.fill(
        textEditingController: tecPicName,
        value: jobOrder.merchant!.picName,
      );
      Widgets.fill(
        textEditingController: tecPicPhoneNumber,
        value: jobOrder.merchant!.picPhoneNumber,
      );
      Widgets.fill(
        textEditingController: tecInvoiceCount,
        value: jobOrder.merchant!.invoiceCount.toString(),
      );
      Widgets.fill(
        textEditingController: tecNote,
        value: jobOrder.merchant!.note,
      );
      Widgets.fill(
        textEditingController: tecPriorityEDC,
        value: jobOrder.priorityEdc,
      );
      Widgets.fill(
        textEditingController: tecMerchantComment,
        value: jobOrder.merchantComment,
      );
      Widgets.fill(
        textEditingController: tecMostUsedEDC,
        value: jobOrder.mostUsedEdc,
      );
      Widgets.fill(
        textEditingController: tecMerchantRequest,
        value: jobOrder.merchantRequest,
      );
      Widgets.fill(
        textEditingController: tecPromoMaterial,
        value: jobOrder.promoMaterial,
      );
      Widgets.fill(
        textEditingController: tecPicPosition,
        value: jobOrder.position,
      );
    }
  }

  List<Map<String, dynamic>> comLine = [
    {"id": 1, "name": "Gprs"},
    {"id": 2, "name": "Dial"},
    {"id": 3, "name": "Lan"},
  ];

  @override
  Widget build(BuildContext context) {
    JobOrder jobOrder = widget.jobFormPageState.widget.jobOrder;

    return Padding(
      padding: EdgeInsets.all(
        Dimensions.width15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextSheet(
            'DATA MERCHANT',
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomTextField(
            controller: tecPicName,
            label: 'PIC Toko',
            readOnly: widget.jobFormPageState.widget.readOnly,
            validator: (value) {
              if (StringUtils.isNullOrEmpty(value)) {
                return "Kolom ini harus diisi.";
              }
              return null;
            },
            onSaved: (value) {
              Realms.get().write(() {
                if (jobOrder.merchant != null) {
                  jobOrder.merchant!.picName = value;
                }
              });
            },
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomTextField(
            controller: tecPicPosition,
            label: 'PIC Jabatan',
            readOnly: widget.jobFormPageState.widget.readOnly,
            validator: (value) {
              if (StringUtils.isNullOrEmpty(value)) {
                return "Kolom ini harus diisi.";
              }
              return null;
            },
            onSaved: (value) {
              Realms.get().write(() {
                jobOrder.position = value;
              });
            },
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomTextField(
            controller: tecPicPhoneNumber,
            label: 'Nomor Ponsel PIC',
            readOnly: widget.jobFormPageState.widget.readOnly,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (StringUtils.isNullOrEmpty(value)) {
                return "Kolom ini harus diisi.";
              }

              if (value!.length > 20) {
                return "Maksimal karakter 20.";
              }
              return null;
            },
            onSaved: (value) {
              Realms.get().write(() {
                if (jobOrder.merchant != null) {
                  jobOrder.merchant!.picPhoneNumber = value;
                }
              });
            },
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          // CustomTextField(
          //   controller: tecInvoiceCount,
          //   label: 'Jumlah Faktur',
          //   keyboardType: TextInputType.number,
          //   readOnly: widget.jobFormPageState.widget.readOnly,
          //   validator: (value) {
          //     if (StringUtils.isNullOrEmpty(value)) {
          //       return "Kolom ini harus diisi.";
          //     }

          //     if (value!.length > 3) {
          //       return "Maksimal 3 digit.";
          //     }
          //     return null;
          //   },
          //   onSaved: (value) {
          //     if (value != null) {
          //       Realms.get().write(() {
          //         if (jobOrder.merchant != null) {
          //           jobOrder.merchant!.invoiceCount = int.tryParse(value) ?? 0;
          //         }
          //       });
          //     }
          //   },
          // ),
          // SizedBox(
          //   height: Dimensions.height15,
          // ),
          CustomTextArea(
            controller: tecNote,
            label: 'Catatan',
            readOnly: widget.jobFormPageState.widget.readOnly,
            validator: (value) {
              if (widget.jobFormPageState.widget.jobOrder.status != null) {
                if (widget.jobFormPageState.widget.jobOrder.status!.id != "9") {
                  if (StringUtils.isNullOrEmpty(value)) {
                    return "Kolom ini harus diisi.";
                  }

                  if (value!.length < 70 && !kDebugMode) {
                    return "Silahkan isi dengan minimal 70 karakter.";
                  }
                } else {
                  if (value!.length < 15) {
                    return "Silahkan isi dengan minimal 15 karakter.";
                  }
                }
              }
              return null;
            },
            onSaved: (value) {
              if (value != null) {
                Realms.get().write(() {
                  if (jobOrder.merchant != null) {
                    jobOrder.merchant!.note = value;
                  }
                });
              }
            },
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomSwitch(
            readOnly: widget.jobFormPageState.widget.readOnly,
            title: "EDC Problem",
            value: SwitchValues.valueToStatus(jobOrder.edcProblem),
            onChanged: (status){
              Realms.get().write(() {
                jobOrder.edcProblem = SwitchValues.statusToValue(status);
              });
            },
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomSwitch(
            readOnly: widget.jobFormPageState.widget.readOnly,
            title: "Settlement",
            value: SwitchValues.valueToStatus(jobOrder.settlement),
            onChanged: (status){
              Realms.get().write(() {
                jobOrder.settlement = SwitchValues.statusToValue(status);
              });
            },
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomSpinnerField(
            labelText: 'Signal Bar',
            initialValue: jobOrder.signalBar != null
                ? SpinnerItem(
              identity: '',
              description: jobOrder.signalBar!,
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
                  jobOrder.signalBar = value.description;
                });
              }
            },
            spinnerItems: Parameter.signalBars
                .map(
                  (e) => SpinnerItem(
                identity: '',
                description: e,
              ),
            ).toList(),
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomSpinnerField(
            labelText: "Com Line",
            initialValue: jobOrder.comLine != null
                ? SpinnerItem(
              identity: 0,
              description: StringUtils.defaultString(
                jobOrder.comLine,
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
                  jobOrder.comLine = value.description;
                });
              }
            },
            spinnerItems: comLine
                .map((e) => SpinnerItem(
              identity: e['id'],
              description: e['name'],
              tag: e,
            ),)
                .toList(),
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomTextField(
            controller: tecPriorityEDC,
            label: 'Priority EDC',
            readOnly: widget.jobFormPageState.widget.readOnly,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (StringUtils.isNullOrEmpty(value)) {
                return "Kolom ini harus diisi.";
              }
              return null;
            },
            onSaved: (value) {
              Realms.get().write(() {
                jobOrder.priorityEdc = value;
              });
            },
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomTextArea(
            controller: tecMerchantComment,
            label: 'Merchant Comment',
            readOnly: widget.jobFormPageState.widget.readOnly,
            validator: (value) {
              if (StringUtils.isNullOrEmpty(value)) {
                return "Kolom ini harus diisi.";
              }
              return null;
            },
            onSaved: (value) {
              Realms.get().write(() {
                jobOrder.merchantComment = value;
              });
            },
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          const TextSheet(
            'OTHER INFORMATION',
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomTextField(
            controller: tecMostUsedEDC,
            label: 'EDC yang sering digunakan',
            readOnly: widget.jobFormPageState.widget.readOnly,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (StringUtils.isNullOrEmpty(value)) {
                return "Kolom ini harus diisi.";
              }
              return null;
            },
            onSaved: (value) {
              Realms.get().write(() {
                jobOrder.mostUsedEdc = value;
              });
            },
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomTextArea(
            controller: tecMerchantRequest,
            label: 'Merchant Request',
            readOnly: widget.jobFormPageState.widget.readOnly,
            validator: (value) {
              return null;
            },
            onSaved: (value) {
              Realms.get().write(() {
                jobOrder.merchantRequest = value;
              });
            },
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomTextField(
            controller: tecPromoMaterial,
            label: 'Promo Material',
            readOnly: widget.jobFormPageState.widget.readOnly,
            keyboardType: TextInputType.text,
            validator: (value) {
              return null;
            },
            onSaved: (value) {
              Realms.get().write(() {
                jobOrder.promoMaterial = value;
              });
            },
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomInformation(
            title: 'PARAF MERCHANT',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 13,
                    ),
                    children: [
                      TextSpan(
                        text: 'Disclaimer: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      TextSpan(
                        text: 'Kunjungan dan layanan ini ',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      TextSpan(
                        text: 'GRATIS, ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      TextSpan(
                        text: 'tidak dikenakan biaya apapun!',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          signature(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget signature() {
    List<Widget> widgets = [];

    JobOrder jobOrder = widget.jobFormPageState.widget.jobOrder;

    if (widget.jobFormPageState.widget.readOnly ||
        (jobOrder.merchant != null &&
            jobOrder.merchant!.signature != null &&
            jobOrder.merchant!.signature!.file.isNotEmpty)) {
      widgets.add(
        Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.blue[50],
            border: Border.all(
              color: Colors.blue, // Border color
              width: 3.0, // Border width
            ),
          ),
          child: Image.memory(
            Uint8List.fromList(jobOrder.merchant!.signature!.file),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      widgets.add(
        FormField(
          validator: (value) {
            if (!hasSign && ImageMandatory.getImageMandatory(jobOrder.imageMandatoryType, ImageMandatoryKey.signature) == "1") {
              return "Tanda tangan harus diisi.";
            }
            return null;
          },
          builder: (field) {
            return Column(
              children: [
                Visibility(
                  visible: field.hasError,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: AppColors.primaryDark,
                      ),
                      SizedBox(width: Dimensions.width5),
                      Flexible(
                        child: TextSheet(
                          field.errorText ?? "",
                          fontSize: Dimensions.size14,
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.height15,
                ),
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    border: Border.all(
                      color: Colors.blue, // Border color
                      width: 3.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: SfSignaturePad(
                    key: gkSignaturePadState,
                    onDrawEnd: () => hasSign = true,
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

    if (!widget.jobFormPageState.widget.readOnly) {
      widgets.add(
        ElevatedButton(
          onPressed: () {
            setState(() {
              Realms.get().write(() {
                jobOrder.merchant!.signature = null;
              });

              if (gkSignaturePadState.currentState != null) {
                gkSignaturePadState.currentState!.clear();
              }
            });
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.edit,
              ),
              SizedBox(
                width: Dimensions.width5,
              ),
              const Text(
                "RESET TANDA TANGAN",
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: widgets,
    );
  }
}
