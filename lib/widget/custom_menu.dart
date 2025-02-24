import 'dart:ui' as ui;

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:rtracker/helper/app_colors.dart';
import 'package:rtracker/helper/dimensions.dart';
import 'package:rtracker/helper/extensions.dart';
import 'package:rtracker/widget/text_sheet.dart';

Widget menu({
  required ui.Color color,
  required GestureTapCallback onTap,
  required IconData iconData,
  required String name,
  String? badge,
}) {
  print("StringUtils.isNotNullOrEmpty(badge)");
  print(StringUtils.isNotNullOrEmpty(badge));
  return Container(
    margin: EdgeInsets.symmetric(vertical: Dimensions.height5),
    child: InkWell(
      splashColor: color.lighten(50),
      radius: Dimensions.radius15,
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Ink(
        color: color.lighten(95),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.width15,
            vertical: Dimensions.height20,
          ),
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              SizedBox(width: Dimensions.width5),
              Icon(iconData, color: Colors.black, size: 30),
              SizedBox(width: Dimensions.width10),
              Expanded(
                child: TextSheet(
                  name,
                  fontSize: 20,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              StringUtils.isNotNullOrEmpty(badge)
                  ? Card(
                      elevation: 0,
                      color: AppColors.alertShaded.lighten(80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(Dimensions.height5),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 18,
                              color: AppColors.alertShaded,
                            ),
                            SizedBox(width: 3),
                            TextSheet('3', color: AppColors.alertShaded),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    ),
  );
}
