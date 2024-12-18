// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:rtracker/helper/formats.dart';

class CustomDateTimeField extends StatefulWidget {
  final String labelText;
  final FormFieldValidator<DateTime>? validator;
  final DateTime? initialValue;
  final FormFieldSetter<DateTime>? onSaved;
  final void Function(DateTime newValue)? onChanged;
  final bool readOnly;

  const CustomDateTimeField({
    Key? key,
    required this.labelText,
    this.validator,
    this.initialValue,
    this.onSaved,
    this.onChanged,
    this.readOnly = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CustomDateTimeFieldState();
}

class CustomDateTimeFieldState extends State<CustomDateTimeField> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.initialValue != null) {
      textEditingController.text = Formats.dateTime(widget.initialValue!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      validator: widget.validator,
      initialValue: widget.initialValue,
      onSaved: widget.onSaved,
      builder: (field) {
        return Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: TextField(
            controller: textEditingController,
            onTap: widget.readOnly
                ? null
                : () async {
                    DateTime? dateTime = await showDatePicker(
                      context: context,
                      initialDate: widget.initialValue ?? DateTime.now(),
                      firstDate: DateTime(1900, 1, 1),
                      lastDate: DateTime(2099, 12, 31),
                    );

                    if (dateTime != null) {
                      TimeOfDay? timeOfDay = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (timeOfDay != null) {
                        setState(() {
                          DateTime finalDateTime = DateTime(
                            dateTime.year,
                            dateTime.month,
                            dateTime.day,
                            timeOfDay.hour,
                            timeOfDay.minute,
                          );

                          if (field.value != finalDateTime) {
                            field.setValue(finalDateTime);

                            textEditingController.text =
                                Formats.dateTime(finalDateTime);

                            if (widget.onChanged != null) {
                              widget.onChanged!(finalDateTime);
                            }
                          }
                        });
                      }
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
              suffixIcon: const Icon(Icons.event),
            ),
          ),
        );
      },
    );
  }
}
