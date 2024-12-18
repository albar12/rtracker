import 'package:flutter/material.dart';

///Custom TextField, jika [onTap] null maka menampilkan textfield biasa,
///jika [onTap] tidak null maka menampilkan suffix icon, jika
class CustomTextFieldOld extends StatelessWidget {
  const CustomTextFieldOld({
    Key? key,
    required this.controller,
    this.keyboardType,
    required this.label,
    this.helperText,
    this.onTap,
    this.suffixIcon = const Icon(Icons.arrow_drop_down),
    this.onSaved,
  }) : super(key: key);
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String label;
  final String? helperText;
  final Function()? onTap;
  final Icon suffixIcon;
  final Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    if (onTap != null && controller.text.isEmpty) {
      if (suffixIcon == const Icon(Icons.arrow_drop_down)) {
        controller.text = 'Pilih salah satu';
      }
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        onSaved: onSaved,
        keyboardType: keyboardType,
        controller: controller,
        onTap: onTap,
        readOnly: onTap != null,
        decoration: InputDecoration(
          helperText: helperText,
          labelText: label,
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          filled: true,
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 0.25,
            ),
          ),
          suffixIcon: onTap != null ? suffixIcon : null,
        ),
      ),
    );
  }
}
