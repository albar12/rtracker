import 'package:flutter/material.dart';
import 'package:rtracker/widget/text_sheet.dart';

import '../../helper/app_colors.dart';

class CustomInformation extends StatelessWidget {
  const CustomInformation({
    Key? key,
    this.title = '',
    required this.content,
    this.desc = '',
    this.width,
  }) : super(key: key);

  final String title;
  final String desc;
  final Widget content;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Theme.of(context).unselectedWidgetColor,
          width: 0.25,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            TextSheet(
              title,
              fontWeight: FontWeight.bold,
            ),
          if (desc.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextSheet(
                desc,
                fontSize: 12,
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: content,
          )
        ],
      ),
    );
  }
}
