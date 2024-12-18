import 'package:flutter/material.dart';

class CustomTextArea extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? helperText;
  final FormFieldValidator<String>? validator;
  final Function(String?)? onSaved;
  final bool readOnly;

  const CustomTextArea({
    Key? key,
    required this.controller,
    required this.label,
    this.helperText,
    this.validator,
    this.onSaved,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: onSaved,
      keyboardType: TextInputType.multiline,
      controller: controller,
      readOnly: readOnly,
      minLines: 3,
      maxLines: null,
      decoration: InputDecoration(
        helperText: helperText,
        labelText: label,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        filled: true,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 0.25,
          ),
        ),
      ),
    );
  }
}
