import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:rtracker/helper/app_colors.dart';
import 'package:rtracker/helper/bottom_sheets.dart';
import 'package:rtracker/helper/dialogs.dart';
import 'package:rtracker/helper/dimensions.dart';
import 'package:rtracker/widget/text_sheet.dart';

class CustomImageField extends StatefulWidget {
  final String title;
  final String? subtitle;
  final bool readOnly;
  final FormFieldValidator<List<Uint8List>>? validator;
  final List<Uint8List>? initialValue;
  final FormFieldSetter<List<Uint8List>>? onSaved;
  final bool allowGallery;

  const CustomImageField({
    Key? key,
    required this.title,
    this.subtitle,
    this.readOnly = false,
    this.validator,
    this.initialValue,
    this.onSaved,
    this.allowGallery = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CustomImageFieldState();
}

class CustomImageFieldState extends State<CustomImageField> {
  @override
  Widget build(BuildContext context) {
    return FormField<List<Uint8List>?>(
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
                    children: fileWidgets(field),
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
    Dialogs.image(
      context: context,
      title: widget.title,
      multiple: true,
      allowGallery: widget.allowGallery,
      callback: (files) {
        if (formFieldState.value == null) {
          // ignore: invalid_use_of_protected_member
          formFieldState.setValue([]);
        }

        setState(() {
          for (Uint8List file in files) {
            formFieldState.value.add(file);
          }
        });
      },
    );
  }

  List<Widget> fileWidgets(FormFieldState<List<Uint8List>?> formFieldState) {
    List<Widget> widgets = [];

    if (!isReadOnly()) {
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
                Icons.upload,
              ),
              SizedBox(
                width: Dimensions.width5,
              ),
              const Text(
                "UNGGAH GAMBAR",
              )
            ],
          ),
        ),
      );
    }

    if (formFieldState.value != null && formFieldState.value!.isNotEmpty) {
      widgets.add(
        SizedBox(
          height: Dimensions.height5,
        ),
      );

      widgets.add(
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: formFieldState.value!.map((file) {
              Widget widget = Stack(
                children: [
                  Image.memory(
                    file,
                    width: 92,
                    height: 92,
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          BottomSheets.imagePreview(
                            context: context,
                            title: this.widget.title,
                            bytes: file,
                          );
                        },
                      ),
                    ),
                  )
                ],
              );

              return Container(
                margin: EdgeInsets.only(right: Dimensions.width10),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        Dimensions.radius10,
                      ),
                      child: widget,
                    ),
                    Visibility(
                      visible: !isReadOnly(),
                      child: Column(
                        children: [
                          SizedBox(
                            height: Dimensions.height5,
                          ),
                          OutlinedButton(
                            onPressed: () {
                              Dialogs.confirmation(
                                context: context,
                                title:
                                    "Apakah anda yakin ingin menghapus gambar yang dipilih?",
                                positive: "HAPUS",
                                positiveCallback: () {
                                  setState(() {
                                    if (formFieldState.value!.contains(file)) {
                                      formFieldState.value!.remove(file);
                                    }
                                  });
                                },
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.delete,
                                  size: 16,
                                ),
                                SizedBox(
                                  width: Dimensions.width5,
                                ),
                                const Text(
                                  "HAPUS",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
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
