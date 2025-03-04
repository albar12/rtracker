import 'package:flutter/material.dart';

import '/helper/dimensions.dart';
import '/widget/text_sheet.dart';

class JoYesterdayComponent extends StatelessWidget {
  const JoYesterdayComponent({
    super.key,
    required this.title,
    this.valueTitle,
    required this.item1,
    required this.item2,
    required this.item3,
    required this.item4,
    this.icon1,
    this.icon2,
    this.icon3,
    this.icon4,
  });
  final String title;
  final String? valueTitle;
  final String item1;
  final String item2;
  final String item3;
  final String item4;
  final Widget? icon1;
  final Widget? icon2;
  final Widget? icon3;
  final Widget? icon4;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Dimensions.width10 * 13.2,
          decoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextSheet(
              title,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              children: [
                Container(
                  width: Dimensions.width10 * 12,
                  height: Dimensions.height10 * 4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: icon1 != null
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      children: [
                        if (icon1 != null) icon1!,
                        if (icon1 != null) SizedBox(width: Dimensions.width10),
                        TextSheet(
                          item1,
                          fontSize: 11,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w300,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height10),
                Container(
                  width: Dimensions.width10 * 12,
                  height: Dimensions.height10 * 4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: icon2 != null
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      children: [
                        if (icon2 != null) icon2!,
                        if (icon2 != null) SizedBox(width: Dimensions.width10),
                        TextSheet(
                          item2,
                          fontSize: 11,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w300,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height10),
                Container(
                  width: Dimensions.width10 * 12,
                  height: Dimensions.height10 * 4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: icon3 != null
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      children: [
                        if (icon3 != null) icon3!,
                        if (icon3 != null) SizedBox(width: Dimensions.width10),
                        TextSheet(
                          item3,
                          fontSize: 11,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w300,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height10),
                Container(
                  width: Dimensions.width10 * 12,
                  height: Dimensions.height10 * 4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: icon4 != null
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      children: [
                        if (icon4 != null) icon4!,
                        if (icon4 != null) SizedBox(width: Dimensions.width10),
                        TextSheet(
                          item4,
                          fontSize: 11,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w300,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
