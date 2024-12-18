import 'package:basic_utils/basic_utils.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rtracker/api/endpoint/non_sn_stock_portal/non_sn_stock_portal_response_detail.dart';
import 'package:rtracker/api/endpoint/sn_stock_portal/sn_stock_portal_response_detail.dart';
import 'package:rtracker/helper/app_colors.dart';
import 'package:rtracker/helper/bottom_sheets.dart';
import 'package:rtracker/helper/dimensions.dart';
import 'package:rtracker/helper/extensions.dart';
import 'package:rtracker/module/stok_barang/stok_barang_bloc.dart';
import 'package:rtracker/module/stok_barang/stok_barang_event.dart';
import 'package:rtracker/module/stok_barang/stok_barang_state.dart';
import 'package:rtracker/widget/appbar/search_appbar.dart';
import 'package:rtracker/widget/custom_chips.dart';
import 'package:rtracker/widget/text_sheet.dart';

class StokBarangPage extends StatefulWidget {
  const StokBarangPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StokBarangPage> createState() => StokBarangPageState();
}

class StokBarangPageState extends State<StokBarangPage> {
  int selectedIndex = 0;
  TextEditingController tecSearch = TextEditingController();
  List<SnStockPortalResponseDetail> snStockPortalResponseDetails = [];
  List<NonSnStockPortalResponseDetail> nonSnStockPortalResponseDetails = [];

  @override
  void initState() {
    super.initState();

    getSnStock();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StokBarangBloc, StokBarangState>(
      listener: (context, state) {
        if (state is StokBarangGetSnLoading) {
          context.loaderOverlay.show();
        } else if (state is StokBarangGetSnSuccess) {
          setState(() {
            snStockPortalResponseDetails.clear();
            snStockPortalResponseDetails.addAll(state.snStockPortalResponse.data);
          });
        } else if (state is StokBarangGetSnFailed) {
          setState(() {
            snStockPortalResponseDetails.clear();
          });
        } else if (state is StokBarangGetSnFinished) {
          context.loaderOverlay.hide();
        } else if (state is StokBarangGetNonSnLoading) {
          context.loaderOverlay.show();
        } else if (state is StokBarangGetNonSnSuccess) {
          setState(() {
            nonSnStockPortalResponseDetails.clear();
            nonSnStockPortalResponseDetails.addAll(state.nonSnStockPortalResponse.data);
          });
        } else if (state is StokBarangGetNonSnFailed) {
          setState(() {
            nonSnStockPortalResponseDetails.clear();
          });
        } else if (state is StokBarangGetNonSnFinished) {
          context.loaderOverlay.hide();
        }
      },
      child: Scaffold(
        appBar: SearchAppBar(
          title: const Text("Stok Barang"),
          height: MediaQuery.of(context).size.height * 0.152,
          bottomWidget: [
            PreferredSize(
              preferredSize: Size.zero,
              child: SizedBox(
                height: Dimensions.height15,
              ),
            )
          ],
          controller: tecSearch,
          onChanged: (p0) {
            setState(() {});
          },
        ),
        body: body(),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner),
              label: "SN",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: "Non SN",
            )
          ],
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });

            if (selectedIndex == 1) {
              getNonSnStock();
            } else {
              getSnStock();
            }
          },
        ),
      ),
    );
  }

  Widget body() {
    if (selectedIndex == 1) {
      return RefreshIndicator(
        child: ListView.separated(
          padding: EdgeInsets.all(Dimensions.width15),
          separatorBuilder: (context, index) {
            return SizedBox(
              height: Dimensions.height10,
            );
          },
          itemCount: nonSnStockPortalResponseDetails.where((element) {
            String pattern = "${element.vendorName}${element.servicePointName}${element.productName}${element.category}${element.status}".toLowerCase();

            return pattern.contains(tecSearch.text.toLowerCase());
          }).length,
          itemBuilder: (context, index) {
            NonSnStockPortalResponseDetail nonSnStockPortalResponseDetail = nonSnStockPortalResponseDetails.where((element) {
              String pattern = "${element.vendorName}${element.servicePointName}${element.productName}${element.category}${element.status}".toLowerCase();

              return pattern.contains(tecSearch.text.toLowerCase());
            }).toList()[index];

            return Card(
              margin: EdgeInsets.zero,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  Dimensions.radius10,
                ),
              ),
              color: Colors.blue.lighten(90),
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(Dimensions.width15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextSheet(
                                  nonSnStockPortalResponseDetail.productName,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(
                                  height: Dimensions.height5,
                                ),
                                TextSheet(
                                  nonSnStockPortalResponseDetail.category,
                                  fontWeight: FontWeight.normal,
                                ),
                                SizedBox(
                                  height: Dimensions.height5,
                                ),
                                TextSheet(
                                  nonSnStockPortalResponseDetail.vendorName,
                                  fontWeight: FontWeight.normal,
                                )
                              ],
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () async {
                              await BottomSheets.returNonSnStock(
                                context: context,
                                nonSnStockPortalResponseDetail: nonSnStockPortalResponseDetail,
                              );

                              getNonSnStock();
                            },
                            icon: const Icon(Icons.assignment_return),
                          )
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height5,
                      ),
                      DottedLine(
                        dashGapLength: 2,
                        dashColor: AppColors.textSheet.lighten(50),
                      ),
                      SizedBox(
                        height: Dimensions.height5,
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 0,
                        children: [
                          CustomChip(
                            label: Text(
                              nonSnStockPortalResponseDetail.servicePointName,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: Colors.blue.withOpacity(0.2),
                          ),
                          Visibility(
                            visible: StringUtils.isNotNullOrEmpty(
                              nonSnStockPortalResponseDetail.vendorName,
                            ),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 0,
                              children: [
                                CustomChip(
                                  label: Text(
                                    nonSnStockPortalResponseDetail.vendorName,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  backgroundColor: Colors.red.withOpacity(0.2),
                                )
                              ],
                            ),
                          ),
                          Visibility(
                            visible: StringUtils.isNotNullOrEmpty(
                              nonSnStockPortalResponseDetail.status,
                            ),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 0,
                              children: [
                                CustomChip(
                                  label: Text(
                                    nonSnStockPortalResponseDetail.status,
                                    style: const TextStyle(
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  backgroundColor: Colors.amber.withOpacity(0.2),
                                )
                              ],
                            ),
                          ),
                          CustomChip(
                            label: Text(
                              "${nonSnStockPortalResponseDetail.quantity} pcs",
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: Colors.green.withOpacity(0.2),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        onRefresh: () async {
          getNonSnStock();
        },
      );
    } else {
      return RefreshIndicator(
        child: ListView.separated(
          padding: EdgeInsets.all(Dimensions.width15),
          separatorBuilder: (context, index) {
            return SizedBox(
              height: Dimensions.height10,
            );
          },
          itemCount: snStockPortalResponseDetails.where((element) {
            String pattern = "${element.vendorName}${element.category}${element.servicePointName}${element.productName}${element.serialNumber}${element.status}".toLowerCase();

            return pattern.contains(tecSearch.text.toLowerCase());
          }).length,
          itemBuilder: (context, index) {
            SnStockPortalResponseDetail snStockPortalResponseDetail = snStockPortalResponseDetails.where((element) {
              String pattern = "${element.vendorName}${element.category}${element.servicePointName}${element.productName}${element.serialNumber}${element.status}".toLowerCase();

              return pattern.contains(tecSearch.text.toLowerCase());
            }).toList()[index];

            return Card(
              margin: EdgeInsets.zero,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  Dimensions.radius10,
                ),
              ),
              color: Colors.blue.lighten(90),
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(Dimensions.width15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextSheet(
                                  snStockPortalResponseDetail.serialNumber,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(
                                  height: Dimensions.height5,
                                ),
                                TextSheet(
                                  snStockPortalResponseDetail.category,
                                  fontWeight: FontWeight.normal,
                                ),
                                SizedBox(
                                  height: Dimensions.height5,
                                ),
                                TextSheet(
                                  snStockPortalResponseDetail.productName,
                                  fontWeight: FontWeight.normal,
                                )
                              ],
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () async {
                              await BottomSheets.returSnStock(
                                context: context,
                                snStockPortalResponseDetail: snStockPortalResponseDetail,
                              );

                              getSnStock();
                            },
                            icon: const Icon(Icons.assignment_return),
                          )
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height5,
                      ),
                      DottedLine(
                        dashGapLength: 2,
                        dashColor: AppColors.textSheet.lighten(50),
                      ),
                      SizedBox(
                        height: Dimensions.height5,
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 0,
                        children: [
                          CustomChip(
                            label: Text(
                              snStockPortalResponseDetail.servicePointName,
                              style: const TextStyle(
                                color: Color(0xff2F80ED),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: const Color(0xff2F80ED).withOpacity(0.2),
                          ),
                          Visibility(
                            visible: StringUtils.isNotNullOrEmpty(
                              snStockPortalResponseDetail.vendorName,
                            ),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 0,
                              children: [
                                CustomChip(
                                  label: Text(
                                    snStockPortalResponseDetail.vendorName,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  backgroundColor: Colors.red.withOpacity(0.2),
                                )
                              ],
                            ),
                          ),
                          Visibility(
                            visible: StringUtils.isNotNullOrEmpty(
                              snStockPortalResponseDetail.status,
                            ),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 0,
                              children: [
                                CustomChip(
                                  label: Text(
                                    snStockPortalResponseDetail.status,
                                    style: const TextStyle(
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  backgroundColor: Colors.amber.withOpacity(0.2),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        onRefresh: () async {
          getSnStock();
        },
      );
    }
  }

  void getSnStock() {
    context.read<StokBarangBloc>().add(
          StokBarangGetSn(),
        );
  }

  void getNonSnStock() {
    context.read<StokBarangBloc>().add(
          StokBarangGetNonSn(),
        );
  }
}
