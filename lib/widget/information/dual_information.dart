import 'package:flutter/material.dart';
import 'basic_information.dart';

class DualInformation extends StatelessWidget {
  const DualInformation({
    Key? key,
    required this.firstTitle,
    required this.firstSubtitle,
    required this.secondTitle,
    required this.secondSubtitle,
    this.firstTrailingIcon,
    this.firstTrailingOnTap,
    this.secondTrailingIcon,
    this.secondTrailingOnTap,
  }) : super(key: key);

  final String firstTitle;
  final String firstSubtitle;
  final IconData? firstTrailingIcon;
  final Function()? firstTrailingOnTap;
  final String secondTitle;
  final String secondSubtitle;
  final IconData? secondTrailingIcon;
  final Function()? secondTrailingOnTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: BasicInformation(
            title: firstTitle,
            subtitle: firstSubtitle,
            trailingIcon: firstTrailingIcon,
            trailingOnTap: firstTrailingOnTap,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: BasicInformation(
            title: secondTitle,
            subtitle: secondSubtitle,
            trailingIcon: secondTrailingIcon,
            trailingOnTap: secondTrailingOnTap,
          ),
        )
      ],
    );
  }
}
