// ignore_for_file: invalid_use_of_protected_member

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:rtracker/helper/bottom_sheets.dart';

class CustomSpinnerField extends StatefulWidget {
  final String labelText;
  final FormFieldValidator<SpinnerItem>? validator;
  final SpinnerItem? initialValue;
  final FormFieldSetter<SpinnerItem>? onSaved;
  final void Function(SpinnerItem newValue)? onChanged;
  final List<SpinnerItem> spinnerItems;
  final bool readOnly;
  final Key? fieldKey;
  final TextEditingController? textEditingController;

  const CustomSpinnerField({
    Key? key,
    required this.labelText,
    this.validator,
    this.initialValue,
    this.onSaved,
    this.onChanged,
    required this.spinnerItems,
    this.readOnly = false,
    this.fieldKey,
    this.textEditingController,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CustomSpinnerFieldState();
}

class CustomSpinnerFieldState extends State<CustomSpinnerField> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();

    if (widget.textEditingController != null) {
      textEditingController = widget.textEditingController!;
    } else {
      textEditingController = TextEditingController();
    }

    if (widget.initialValue != null) {
      textEditingController.text =
          StringUtils.defaultString(widget.initialValue!.description);

      // textEditingController.text = widget.initialValue!.description;
    }
    print("widget.initialValue");
    print(widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return FormField<SpinnerItem?>(
      key: widget.fieldKey,
      validator: widget.validator,
      initialValue: widget.initialValue,
      onSaved: widget.onSaved,
      builder: (field) {
        return TextField(
          controller: textEditingController,
          onTap: () {
            if (!widget.readOnly) {
              BottomSheets.spinner(
                context: context,
                title: widget.labelText,
                spinnerItems: widget.spinnerItems,
                onSelected: (selected) {
                  setState(() {
                    if (field.value != selected) {
                      field.setValue(selected);

                      textEditingController.text = selected.description;

                      if (widget.onChanged != null) {
                        widget.onChanged!(selected);
                      }
                    }
                  });
                },
              );
            }
          },
          readOnly: true,
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
            errorText: field.errorText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            filled: true,
            border: const UnderlineInputBorder(
              borderSide: BorderSide(
                width: 0.25,
              ),
            ),
            suffixIcon: const Icon(Icons.arrow_drop_down),
          ),
        );
      },
    );
  }
}
