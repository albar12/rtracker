// // ignore_for_file: invalid_use_of_protected_member

// import 'dart:ffi';

// import 'package:flutter/material.dart';
// import 'package:rtracker/helper/bottom_sheets.dart';
// import 'package:rtracker/helper/dimensions.dart';
// import 'package:rtracker/widget/text_sheet.dart';

// class CustomNumberField extends StatefulWidget {
//   final FormFieldValidator<NumberItem>? validator;
//   final FormFieldSetter<NumberItem>? onSaved;
//   final NumberItem numberItems;

//   final bool readOnly;

//   const CustomNumberField({
//     Key? key,
//     this.validator,
//     this.onSaved,
//     this.readOnly = false,
//     required this.numberItems,
//   }) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => CustomNumberFieldState();
// }

// class CustomNumberFieldState extends State<CustomNumberField> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FormField<NumberItem>(
//       validator: widget.validator,
//       initialValue: widget.numberItems,
//       onSaved: widget.onSaved,
//       builder: (field) {
//         // if (field.value == null) {
//         //   field.setValue([]);
//         // }

//         return Row(
//           children: [
//             IconButton(
//               icon: const Icon(Icons.remove_circle),
//               onPressed: () {
//                 setState(() {
//                   if (field.value! > 0) {
//                     field.value = field.value - 1;
//                   }
//                 });
//               },
//             ),
//             SizedBox(
//               width: Dimensions.width30,
//               child: Center(
//                 child: Text(field.toString()),
//               ),
//             ),
//             IconButton(
//               icon: const Icon(Icons.add_circle),
//               onPressed: () {
//                 setState(() {
//                   if (field < 999) {
//                     field = field + 1;
//                   }
//                 });
//               },
//             ),
//             Expanded(
//               child: TextSheet(
//                 field.toString(),
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }
// }
