import 'package:basic_utils/basic_utils.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rtracker/api/endpoint/terima_non_sn_stock/terima_non_sn_stock_response_detail.dart';
import 'package:rtracker/api/endpoint/terima_sn_stock/terima_sn_stock_response_detail.dart';
import 'package:rtracker/helper/app_colors.dart';
import 'package:rtracker/helper/bottom_sheets.dart';
import 'package:rtracker/helper/dialogs.dart';
import 'package:rtracker/helper/dimensions.dart';
import 'package:rtracker/helper/extensions.dart';
import 'package:rtracker/module/terima_barang/terima_barang_bloc.dart';
import 'package:rtracker/module/terima_barang/terima_barang_event.dart';
import 'package:rtracker/module/terima_barang/terima_barang_state.dart';
import 'package:rtracker/widget/appbar/search_appbar.dart';
import 'package:rtracker/widget/custom_chips.dart';
import 'package:rtracker/widget/custom_scan_field.dart';
import 'package:rtracker/widget/text_sheet.dart';

class TerimaBarangPage extends StatefulWidget {
  const TerimaBarangPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TerimaBarangPage> createState() => TerimaBarangPageState();
}

class TerimaBarangPageState extends State<TerimaBarangPage>
    with TickerProviderStateMixin {
  int selectedIndex = 0;
  TabController? tabController;
  TextEditingController tecSearch = TextEditingController();
  TextEditingController tecSerialNumber = TextEditingController();
  List<TerimaSnStockResponseDetail> terimaSnStockResponseDetails = [];
  List<TerimaNonSnStockResponseDetail> terimaNonSnStockResponseDetails = [];

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    tabController!.addListener(() {
      setState(() {});

      if (tabController!.index == 1) {
        getSnStock();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TerimaBarangBloc, TerimaBarangState>(
      listener: (context, state) {
        if (state is TerimaBarangSendSnStockLoading) {
          context.loaderOverlay.show();
        } else if (state is TerimaBarangSendSnStockSuccess) {
          Dialogs.message(
            context: context,
            title: state.message,
          );

          setState(() {
            tecSerialNumber.text = "";
          });
        } else if (state is TerimaBarangSendSnStockFailed) {
          Dialogs.message(
            context: context,
            title: state.message,
          );
        } else if (state is TerimaBarangSendSnStockFinished) {
          context.loaderOverlay.hide();
        } else if (state is TerimaBarangGetSnStockLoading) {
          context.loaderOverlay.show();
        } else if (state is TerimaBarangGetSnStockSuccess) {
          setState(() {
            terimaSnStockResponseDetails.clear();
            terimaSnStockResponseDetails
                .addAll(state.terimaSnStockResponse.data);
          });
        } else if (state is TerimaBarangGetSnStockFailed) {
          setState(() {
            terimaSnStockResponseDetails.clear();
          });
        } else if (state is TerimaBarangGetSnStockFinished) {
          context.loaderOverlay.hide();
        } else if (state is TerimaBarangGetNonSnStockLoading) {
          context.loaderOverlay.show();
        } else if (state is TerimaBarangGetNonSnStockSuccess) {
          setState(() {
            terimaNonSnStockResponseDetails.clear();
            terimaNonSnStockResponseDetails
                .addAll(state.terimaNonSnStockResponse.data);
          });
        } else if (state is TerimaBarangGetNonSnStockFailed) {
          setState(() {
            terimaNonSnStockResponseDetails.clear();
          });
        } else if (state is TerimaBarangGetNonSnStockFinished) {
          context.loaderOverlay.hide();
        }
      },
      child: Scaffold(
        appBar: SearchAppBar(
          title: const Text("Terima Barang"),
          height: selectedIndex == 1
              ? MediaQuery.of(context).size.height * 0.152
              : MediaQuery.of(context).size.height * 0.19,
          bottomWidget: [bottomAppBar()],
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
              if (tabController!.index == 1) {
                getSnStock();
              }
            }
          },
        ),
      ),
    );
  }

  PreferredSizeWidget bottomAppBar() {
    if (selectedIndex == 0) {
      return TabBar(
        controller: tabController!,
        tabs: const [
          Tab(
            text: "Pindai SN",
          ),
          Tab(
            text: "SN Yang Tersedia",
          )
        ],
      );
    } else {
      return PreferredSize(
        preferredSize: Size.zero,
        child: SizedBox(
          height: Dimensions.height15,
        ),
      );
    }
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
          itemCount: terimaNonSnStockResponseDetails.where((element) {
            String pattern =
                "${element.vendorName}${element.servicePointName}${element.productName}${element.category}"
                    .toLowerCase();

            return pattern.contains(tecSearch.text.toLowerCase());
          }).length,
          itemBuilder: (context, index) {
            TerimaNonSnStockResponseDetail terimaNonSnStockResponseDetail =
                terimaNonSnStockResponseDetails.where((element) {
              String pattern =
                  "${element.vendorName}${element.servicePointName}${element.productName}${element.category}"
                      .toLowerCase();

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
                onTap: () async {
                  await BottomSheets.terimaNonSnStock(
                    context: context,
                    terimaNonSnStockResponseDetail:
                        terimaNonSnStockResponseDetail,
                  );

                  getNonSnStock();
                },
                child: Container(
                  padding: EdgeInsets.all(Dimensions.width15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextSheet(
                        terimaNonSnStockResponseDetail.productName,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: Dimensions.height5,
                      ),
                      TextSheet(
                        terimaNonSnStockResponseDetail.category,
                        fontWeight: FontWeight.normal,
                      ),
                      SizedBox(
                        height: Dimensions.height5,
                      ),
                      TextSheet(
                        terimaNonSnStockResponseDetail.vendorName,
                        fontWeight: FontWeight.normal,
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
                              terimaNonSnStockResponseDetail.servicePointName,
                              style: const TextStyle(
                                color: Color(0xff2F80ED),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor:
                                const Color(0xff2F80ED).withOpacity(0.2),
                          ),
                          Visibility(
                            visible: StringUtils.isNotNullOrEmpty(
                              terimaNonSnStockResponseDetail.vendorName,
                            ),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 0,
                              children: [
                                CustomChip(
                                  label: Text(
                                    terimaNonSnStockResponseDetail.vendorName,
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
                          CustomChip(
                            label: Text(
                              "${terimaNonSnStockResponseDetail.quantity} pcs",
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
      if (tabController!.index == 1) {
        return RefreshIndicator(
          child: ListView.separated(
            padding: EdgeInsets.all(Dimensions.width15),
            separatorBuilder: (context, index) {
              return SizedBox(
                height: Dimensions.height10,
              );
            },
            itemCount: terimaSnStockResponseDetails.where((element) {
              String pattern =
                  "${element.vendorName}${element.category}${element.servicePointName}${element.productName}${element.serialNumber}"
                      .toLowerCase();

              return pattern.contains(tecSearch.text.toLowerCase());
            }).length,
            itemBuilder: (context, index) {
              TerimaSnStockResponseDetail terimaSnStockResponseDetail =
                  terimaSnStockResponseDetails.where((element) {
                String pattern =
                    "${element.vendorName}${element.category}${element.servicePointName}${element.productName}${element.serialNumber}"
                        .toLowerCase();

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
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 1),
                        content: Text(
                          "${terimaSnStockResponseDetail.serialNumber} berhasil disalin.",
                        ),
                      ),
                    );

                    Clipboard.setData(
                      ClipboardData(
                        text: terimaSnStockResponseDetail.serialNumber,
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.width15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextSheet(
                          terimaSnStockResponseDetail.serialNumber,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: Dimensions.height5,
                        ),
                        TextSheet(
                          terimaSnStockResponseDetail.category,
                          fontWeight: FontWeight.normal,
                        ),
                        SizedBox(
                          height: Dimensions.height5,
                        ),
                        TextSheet(
                          terimaSnStockResponseDetail.productName,
                          fontWeight: FontWeight.normal,
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
                                terimaSnStockResponseDetail.servicePointName,
                                style: const TextStyle(
                                  color: Color(0xff2F80ED),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor:
                                  const Color(0xff2F80ED).withOpacity(0.2),
                            )
                          ],
                        ),
                        Visibility(
                          visible: StringUtils.isNotNullOrEmpty(
                            terimaSnStockResponseDetail.vendorName,
                          ),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 0,
                            children: [
                              CustomChip(
                                label: Text(
                                  terimaSnStockResponseDetail.vendorName,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                backgroundColor: Colors.red.withOpacity(0.2),
                              )
                            ],
                          ),
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
      } else {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: EdgeInsets.all(Dimensions.width10),
            child: Column(
              children: [
                CustomScanField(
                  textEditingController: tecSerialNumber,
                  title: "PINDAI NOMOR SERI",
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                SizedBox(
                  width: Dimensions.screenWidth,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      if (StringUtils.isNotNullOrEmpty(tecSerialNumber.text)) {
                        context.read<TerimaBarangBloc>().add(
                              TerimaBarangSendSnStock(
                                serialNumber: tecSerialNumber.text,
                              ),
                            );
                      } else {
                        Dialogs.message(
                          context: context,
                          title: "Nomor seri harus diisi",
                        );
                      }
                    },
                    child: const Text(
                      "TERIMA",
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    }
  }

  void getSnStock() {
    context.read<TerimaBarangBloc>().add(
          TerimaBarangGetSnStock(),
        );
  }

  void getNonSnStock() {
    context.read<TerimaBarangBloc>().add(
          TerimaBarangGetNonSnStock(),
        );
  }
}
