import 'package:flutter/material.dart';
import 'package:rtracker/helper/dimensions.dart';
import 'package:rtracker/module/home/widgets/component/jo_today_component.dart';

import '/widget/text_sheet.dart';

class JoTodayContent extends StatelessWidget {
  const JoTodayContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextSheet(
            "JO Hari ini",
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: Dimensions.height10),
          Row(
            children: [
              JoTodayComponent(
                title: "Jenis Pekerjaan",
                item1: "Supplies",
                icon1: Icon(Icons.inventory),
                item2: "Maintenance",
                icon2: Icon(Icons.build),
                item3: "Install",
                icon3: Icon(Icons.settings),
                item4: "Init",
                icon4: Icon(Icons.autorenew),
              ),
              SizedBox(width: Dimensions.width10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(4, (index) {
                      var title = index == 0
                          ? "Done"
                          : index == 1
                              ? "In SLA"
                              : index == 2
                                  ? "Out SLA"
                                  : "Out STD";
                      return Row(
                        children: [
                          JoTodayComponent(
                            title: title,
                            item1: "0",
                            item2: "0 | 0 %",
                            item3: "0",
                            item4: "0",
                          ),
                          SizedBox(width: Dimensions.width10),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
