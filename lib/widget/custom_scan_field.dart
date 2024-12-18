// ignore_for_file: invalid_use_of_protected_member

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rtracker/helper/app_colors.dart';
import 'package:rtracker/helper/dimensions.dart';
import 'package:rtracker/helper/navigators.dart';
import 'package:rtracker/module/scan_sn/scan_sn.dart';
import 'package:rtracker/widget/text_sheet.dart';

class CustomScanField extends StatefulWidget {
  final String title;
  final String? subtitle;
  final bool readOnly;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final FormFieldSetter<String>? onSaved;
  final TextEditingController? textEditingController;

  const CustomScanField({
    Key? key,
    required this.title,
    this.subtitle,
    this.readOnly = false,
    this.validator,
    this.initialValue,
    this.onSaved,
    this.textEditingController,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CustomScanFieldState();
}

class CustomScanFieldState extends State<CustomScanField> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();

    if (widget.textEditingController != null) {
      textEditingController = widget.textEditingController!;
    } else {
      textEditingController = TextEditingController();
    }

    textEditingController.text = StringUtils.defaultString(widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String?>(
      validator: widget.validator,
      initialValue: widget.initialValue,
      onSaved: widget.onSaved,
      builder: (field) {
        return SizedBox(
          width: double.infinity,
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              side: borderSide(field),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            color: cardColor(field),
            child: Container(
              padding: EdgeInsets.all(Dimensions.width20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextSheet(
                    widget.title,
                    fontWeight: FontWeight.bold,
                  ),
                  Visibility(
                    visible: StringUtils.isNotNullOrEmpty(widget.subtitle),
                    child: TextSheet(
                      '${widget.subtitle}',
                      fontSize: Dimensions.size14,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: Dimensions.height10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: body(field),
                  ),
                  Visibility(
                    visible: field.hasError,
                    child: Column(
                      children: [
                        SizedBox(height: Dimensions.height15),
                        Row(
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
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color? cardColor(FormFieldState formFieldState) {
    if (formFieldState.hasError) {
      return const Color(0xFFFFEFEF);
    } else {
      return AppColors.surface;
    }
  }

  BorderSide borderSide(FormFieldState formFieldState) {
    if (formFieldState.hasError) {
      return const BorderSide(
        color: AppColors.primary,
        width: 2,
      );
    } else {
      return BorderSide(
        color: Theme.of(context).unselectedWidgetColor,
        width: 0.25,
      );
    }
  }

  void onPressed(FormFieldState formFieldState) async {
    Permission.camera.request().then((value) {
      if (value.isGranted) {
        Navigators.push(
          context,
          ScannerPage(
            onSubmitted: (String value) {
              setState(() {
                formFieldState.setValue(value);

                textEditingController.text = value;
              });
            },
          ),
        );
      }
    });
  }

  List<Widget> body(FormFieldState<String?> formFieldState) {
    List<Widget> widgets = [
      TextField(
        controller: textEditingController,
        onChanged: (value) => formFieldState.setValue(value),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.35),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        readOnly: isReadOnly(),
      )
    ];

    if (!isReadOnly()) {
      widgets.add(
        SizedBox(
          height: Dimensions.height5,
        ),
      );

      widgets.add(
        ElevatedButton(
          onPressed: () => onPressed(formFieldState),
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
                Icons.qr_code_scanner,
              ),
              SizedBox(
                width: Dimensions.width5,
              ),
              const Text(
                "PINDAI",
              )
            ],
          ),
        ),
      );
    }

    return widgets;
  }

  bool isReadOnly() {
    return widget.readOnly;
  }
}
