import 'dart:typed_data';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:rtracker/helper/app_colors.dart';
import 'package:rtracker/helper/dimensions.dart';
import 'package:rtracker/helper/widgets.dart';
import 'package:rtracker/module/job_form/job_form_page.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
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
  final TextEditingController tecPicPhoneNumber = TextEditingController();
  final TextEditingController tecInvoiceCount = TextEditingController();
  final TextEditingController tecNote = TextEditingController();

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
    }
  }

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

                  if (value!.length < 70) {
                    return "Silahkan isi dengan minimal 70 karakter.";
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
          signature()
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
        SizedBox(
          width: double.infinity,
          height: 300,
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
            if (!hasSign && jobOrder.imageMandatoryType[0] == "1") {
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
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: SfSignaturePad(
                    key: gkSignaturePadState,
                    onDrawEnd: () => hasSign = true,
                    backgroundColor: Colors.white,
                  ),
                )
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
              )
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
