// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:rtracker/helper/bottom_sheets.dart';
import 'package:rtracker/helper/dimensions.dart';
import 'package:rtracker/widget/text_sheet.dart';

class CustomNumberListField extends StatefulWidget {
  final FormFieldValidator<List<NumberItem>>? validator;
  final FormFieldSetter<List<NumberItem>>? onSaved;
  final List<NumberItem> numberItems;

  final bool readOnly;

  const CustomNumberListField({
    Key? key,
    this.validator,
    this.onSaved,
    this.readOnly = false,
    required this.numberItems,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CustomNumberListFieldState();
}

class CustomNumberListFieldState extends State<CustomNumberListField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<List<NumberItem>>(
      validator: widget.validator,
      initialValue: widget.numberItems,
      onSaved: widget.onSaved,
      builder: (field) {
        if (field.value == null) {
          field.setValue([]);
        }

        return ListView.separated(
          shrinkWrap: true,
          itemCount: field.value!.length,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: Dimensions.height10,
            );
          },
          itemBuilder: (context, index) {
            NumberItem numberItem = field.value![index];

            return Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle),
                  onPressed: () {
                    setState(() {
                      if (numberItem.value > 0) {
                        numberItem.value = numberItem.value - 1;
                      }
                    });
                  },
                ),
                SizedBox(
                  width: Dimensions.width30,
                  child: Center(
                    child: Text(numberItem.value.toString()),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle),
                  onPressed: () {
                    setState(() {
                      if (numberItem.value < 999) {
                        numberItem.value = numberItem.value + 1;
                      }
                    });
                  },
                ),
                Expanded(
                  child: TextSheet(
                    numberItem.description,
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}
