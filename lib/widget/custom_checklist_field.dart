// ignore_for_file: invalid_use_of_protected_member

import 'package:basic_utils/basic_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:rtracker/helper/app_colors.dart';
import 'package:rtracker/helper/bottom_sheets.dart';
import 'package:rtracker/helper/dimensions.dart';
import 'package:rtracker/widget/custom_chips.dart';
import 'package:rtracker/widget/information/custom_information.dart';
import 'package:rtracker/widget/text_sheet.dart';

class CustomCheckListField extends StatefulWidget {
  final String title;
  final FormFieldValidator<List<CheckItem>>? validator;
  final FormFieldSetter<List<CheckItem>>? onSaved;
  final List<CheckItem> checkItems;
  final bool readOnly;

  const CustomCheckListField({
    Key? key,
    required this.title,
    this.validator,
    this.onSaved,
    this.readOnly = false,
    required this.checkItems,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CustomCheckListFieldState();
}

class CustomCheckListFieldState extends State<CustomCheckListField> {
  @override
  Widget build(BuildContext context) {
    return FormField<List<CheckItem>>(
      validator: widget.validator,
      initialValue: widget.checkItems,
      onSaved: widget.onSaved,
      builder: (field) {
        if (field.value == null) {
          field.setValue([]);
        }

        return CustomInformation(
          title: widget.title,
          content: Column(
            children: [
              content(field),
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
        );
      },
    );
  }

  Widget content(FormFieldState<List<CheckItem>> field) {
    if (field.value!.isNotEmpty && StringUtils.isNotNullOrEmpty(field.value![0].groupBy)) {
      Map<String, List<CheckItem>> map = field.value!.groupListsBy((element) => element.groupBy!);

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: map.keys.length,
        itemBuilder: (context, index1) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomChip(
                label: Text(
                  map.keys.elementAt(index1),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.amber,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: map[map.keys.elementAt(index1)]!.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  CheckItem checkItem = map[map.keys.elementAt(index1)]![index];

                  return CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextSheet(
                          StringUtils.defaultString(checkItem.description),
                        ),
                        Visibility(
                          visible: StringUtils.isNotNullOrEmpty(checkItem.subtitle),
                          child: TextSheet(
                            StringUtils.defaultString(checkItem.subtitle),
                          ),
                        )
                      ],
                    ),
                    value: checkItem.value,
                    onChanged: widget.readOnly
                        ? null
                        : (value) {
                            if (value != null) {
                              setState(() {
                                checkItem.value = value;
                              });
                            }
                          },
                  );
                },
              )
            ],
          );
        },
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: field.value!.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          CheckItem checkItem = field.value![index];

          return CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextSheet(
                  StringUtils.defaultString(checkItem.description),
                ),
                Visibility(
                  visible: StringUtils.isNotNullOrEmpty(checkItem.subtitle),
                  child: TextSheet(
                    StringUtils.defaultString(checkItem.subtitle),
                  ),
                )
              ],
            ),
            value: checkItem.value,
            onChanged: widget.readOnly
                ? null
                : (value) {
                    if (value != null) {
                      setState(() {
                        checkItem.value = value;
                      });
                    }
                  },
          );
        },
      );
    }
  }
}
