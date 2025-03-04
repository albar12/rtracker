import 'package:flutter/material.dart';
import 'package:rtracker/helper/dimensions.dart';

import '../component/jo_mtd_component.dart';
import '/widget/text_sheet.dart';

class JoMTDContent extends StatelessWidget {
  const JoMTDContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextSheet(
            "JO Month To Date",
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: Dimensions.height10),
          Row(
            children: [
              JoMTDComponent(
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
                    children: List.generate(7, (index) {
                      var title = index == 0
                          ? "Receive"
                          : index == 1
                              ? "Retur"
                              : index == 2
                                  ? "Done"
                                  : index == 3
                                      ? "In SLA"
                                      : index == 4
                                          ? "Out SLA"
                                          : index == 5
                                              ? "Kendala"
                                              : "Out STD";
                      return Row(
                        children: [
                          JoMTDComponent(
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
