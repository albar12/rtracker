import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String label;
  final String? helperText;
  final FormFieldValidator<String>? validator;
  final Function(String?)? onSaved;
  final bool readOnly;
  final Widget? suffixIcon;
  final Key? fieldKey;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.keyboardType,
    required this.label,
    this.helperText,
    this.validator,
    this.onSaved,
    this.readOnly = false,
    this.suffixIcon,
    this.fieldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    focusNode.canRequestFocus = !readOnly;
    return TextFormField(
      key: fieldKey,
      validator: validator,
      onSaved: onSaved,
      keyboardType: keyboardType,
      controller: controller,
      readOnly: readOnly,
      focusNode: focusNode,
      decoration: InputDecoration(
        helperText: helperText,
        labelText: label,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        filled: true,
        suffixIcon: suffixIcon,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 0.25,
          ),
        ),
      ),
    );
  }
}
