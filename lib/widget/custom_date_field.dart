// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:rtracker/helper/formats.dart';

class CustomDateField extends StatefulWidget {
  final String labelText;
  final FormFieldValidator<DateTime>? validator;
  final DateTime? initialValue;
  final FormFieldSetter<DateTime>? onSaved;
  final void Function(DateTime newValue)? onChanged;
  final bool readOnly;
  final Key? fieldKey;
  final TextEditingController? textEditingController;

  const CustomDateField({
    Key? key,
    required this.labelText,
    this.validator,
    this.initialValue,
    this.onSaved,
    this.onChanged,
    this.readOnly = false,
    this.fieldKey,
    this.textEditingController,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CustomDateFieldState();
}

class CustomDateFieldState extends State<CustomDateField> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.textEditingController != null) {
      textEditingController = widget.textEditingController!;
    } else {
      textEditingController = TextEditingController();
    }

    if (widget.initialValue != null) {
      textEditingController.text = Formats.date(widget.initialValue!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      key: widget.fieldKey,
      validator: widget.validator,
      initialValue: widget.initialValue,
      onSaved: widget.onSaved,
      builder: (field) {
        return TextField(
          controller: textEditingController,
          onTap: widget.readOnly
              ? null
              : () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 3),
                    lastDate: DateTime(DateTime.now().year + 3),
                    currentDate: widget.initialValue ?? DateTime.now(),
                  ).then((value) {
                    if (value != null) {
                      setState(() {
                        if (field.value != value) {
                          field.setValue(value);

                          textEditingController.text = Formats.date(value);

                          if (widget.onChanged != null) {
                            widget.onChanged!(value);
                          }
                        }
                      });
                    }
                  });
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
            suffixIcon: const Icon(Icons.event),
          ),
        );
      },
    );
  }
}
