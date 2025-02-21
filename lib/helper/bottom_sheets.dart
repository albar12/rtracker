import 'dart:io';
import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:rtracker/api/endpoint/non_sn_stock_portal/non_sn_stock_portal_response_detail.dart';
import 'package:rtracker/api/endpoint/sn_stock_portal/sn_stock_portal_response_detail.dart';
import 'package:rtracker/api/endpoint/terima_non_sn_stock/terima_non_sn_stock_response_detail.dart';
import 'package:rtracker/helper/dialogs.dart';
import 'package:rtracker/helper/dimensions.dart';
import 'package:rtracker/helper/navigators.dart';
import 'package:rtracker/helper/no_overscroll.dart';
import 'package:rtracker/helper/strings.dart';
import 'package:rtracker/module/scan_sn/scan_sn.dart';
import 'package:rtracker/module/stok_barang/stok_barang_bloc.dart';
import 'package:rtracker/module/stok_barang/stok_barang_event.dart';
import 'package:rtracker/module/stok_barang/stok_barang_state.dart';
import 'package:rtracker/module/terima_barang/terima_barang_bloc.dart';
import 'package:rtracker/module/terima_barang/terima_barang_event.dart';
import 'package:rtracker/module/terima_barang/terima_barang_state.dart';
import 'package:rtracker/realm/non_sn_stock_dao.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/sn_stock_dao.dart';
import 'package:rtracker/widget/appbar/search_appbar.dart';
import 'package:rtracker/widget/custom_text_field.dart';
import 'package:rtracker/widget/custom_textfield.dart';
import 'package:rtracker/widget/text_sheet.dart';
import 'package:flutter/material.dart';
import 'package:rtracker/widget/appbar/standard_appbar.dart';
import 'package:rtracker/helper/formats.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart'
    as webview_flutter_android;

class BottomSheets {
  static Future<dynamic> spinner({
    required BuildContext context,
    required String title,
    required List<SpinnerItem> spinnerItems,
    required void Function(SpinnerItem selectedItem) onSelected,
  }) async {
    List<SpinnerItem> duplicate = [];
    duplicate.addAll(spinnerItems);

    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Material(
              color: Theme.of(context).primaryColor,
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.04,
                ),
                child: Scaffold(
                  backgroundColor: Theme.of(context).primaryColor,
                  appBar: SearchAppBar(
                    title: Text(title),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        List<SpinnerItem> searched = [];
                        for (var e in spinnerItems) {
                          if (e.description
                              .toLowerCase()
                              .contains(value.toLowerCase())) {
                            searched.add(e);
                          } else if (e.subDescription != null) {
                            if (e.subDescription!
                                .toLowerCase()
                                .contains(value.toLowerCase())) {
                              searched.add(e);
                            }
                          }
                        }
                        spinnerItems.clear();
                        spinnerItems.addAll(searched);
                      } else {
                        spinnerItems.clear();
                        spinnerItems.addAll(duplicate);
                      }
                      setState(() {});
                    },
                    height: MediaQuery.of(context).size.height * 0.15,
                    bottomWidget: [
                      SizedBox(
                        height: Dimensions.height15,
                      )
                    ],
                  ),
                  body: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.875,
                    child: ScrollConfiguration(
                      behavior: NoOverscrollBehavior(),
                      child: ListView.builder(
                        itemCount: spinnerItems.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              onSelected(spinnerItems[index]);
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xff2F80ED),
                                          Color(0xff1E3C72)
                                        ],
                                        begin: Alignment.centerRight,
                                        end: Alignment.centerLeft,
                                        stops: [0, 1],
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      spinnerItems[index]
                                          .description[0]
                                          .toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            spinnerItems[index].description,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          if (spinnerItems[index]
                                                  .subDescription !=
                                              null)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 5,
                                              ),
                                              child: Text(
                                                spinnerItems[index]
                                                    .subDescription!,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static void addReplacementPart({
    required BuildContext context,
    required JobOrder jobOrder,
    required List<ReplacementType> replacementTypes,
    required Map<String, List<SpinnerItem>> map,
    required void Function(JobOrderReplacement jobOrderReplacement) onSelected,
  }) async {
    TextEditingController tecCategory = TextEditingController();
    TextEditingController tecProduct = TextEditingController();
    TextEditingController tecOldSerialNumber = TextEditingController();
    TextEditingController tecNewSerialNumber = TextEditingController();
    TextEditingController tecReason = TextEditingController();

    SpinnerItem? selectedCategory;
    SpinnerItem? selectedProduct;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.95,
          initialChildSize: 0.95,
          minChildSize: 0.65,
          builder: (context, scrollController) => Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.height10,
                horizontal: Dimensions.width15,
              ),
              child: ScrollConfiguration(
                behavior: NoOverscrollBehavior(),
                child: ListView(
                  controller: scrollController,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .unselectedWidgetColor
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height15,
                        ),
                        const TextSheet(
                          'Tambah Penggantian Part',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        CustomTextFieldOld(
                          controller: tecCategory,
                          label: 'Kategori',
                          onTap: () {
                            List<SpinnerItem> spinnerItems = [];

                            for (String category in map.keys) {
                              spinnerItems.add(
                                SpinnerItem(
                                  identity: category,
                                  description: category,
                                ),
                              );
                            }

                            BottomSheets.spinner(
                              context: context,
                              title: 'Kategori',
                              spinnerItems: spinnerItems,
                              onSelected: (selected) {
                                tecCategory.text = selected.description;
                                tecProduct.text = "";

                                selectedCategory = selected;
                                selectedProduct = null;
                              },
                            );
                          },
                        ),
                        CustomTextFieldOld(
                          controller: tecProduct,
                          label: 'Produk SN Lama',
                          onTap: () {
                            List<SpinnerItem> spinnerItems = [];

                            if (selectedCategory != null) {
                              spinnerItems.addAll(map[selectedCategory!.identity.toString()]!);
                            }

                            BottomSheets.spinner(
                              context: context,
                              title: 'Produk SN Lama',
                              spinnerItems: spinnerItems,
                              onSelected: (selected) {
                                tecProduct.text = selected.description;

                                selectedProduct = selected;
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        CustomTextField(
                          controller: tecOldSerialNumber,
                          label: 'Nomor Seri Lama',
                          isCapital: true,
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.qr_code_scanner,
                            ),
                            onPressed: () async {
                              Permission.camera.request().then((value) {
                                if (value.isGranted) {
                                  Navigators.push(
                                    context,
                                    ScannerPage(
                                      onSubmitted: (String value) {
                                        tecOldSerialNumber.text = value;
                                      },
                                    ),
                                  );
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        CustomTextField(
                          controller: tecNewSerialNumber,
                          label: 'Nomor Seri Baru',
                          isCapital: true,
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.qr_code_scanner,
                            ),
                            onPressed: () async {
                              Permission.camera.request().then((value) {
                                if (value.isGranted) {
                                  Navigators.push(
                                    context,
                                    ScannerPage(
                                      onSubmitted: (String value) {
                                        tecNewSerialNumber.text = value;
                                      },
                                    ),
                                  );
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        CustomTextFieldOld(
                          controller: tecReason,
                          label: 'Alasan Penggantian',
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SizedBox(
              height: kToolbarHeight - 10,
              child: ElevatedButton(
                onPressed: () {
                  ReplacementType? replacementType = replacementTypes
                      .firstWhereOrNull((element) => element.id == "1");

                  if (Strings.isZero(tecOldSerialNumber.text.toString())){
                    Dialogs.message(
                      context: context,
                      title: "Nomor seri lama tidak boleh 0.",
                    );
                    return;
                  }

                  if (Strings.isZero(tecNewSerialNumber.text.toString())){
                    Dialogs.message(
                      context: context,
                      title: "Nomor seri baru tidak boleh 0.",
                    );
                    return;
                  }

                  var oldSnSameCharacters = Strings.findFiveConsecutiveSameCharacters(tecOldSerialNumber.text.toString());
                  if (oldSnSameCharacters != null){
                    Dialogs.message(
                      context: context,
                      title: "$oldSnSameCharacters tidak valid sebagai nomor serial lama",
                    );
                    return;
                  }
                  var newSnSameCharacters = Strings.findFiveConsecutiveSameCharacters(tecNewSerialNumber.text.toString());
                  if (newSnSameCharacters != null){
                    Dialogs.message(
                      context: context,
                      title: "$newSnSameCharacters tidak valid sebagai nomor serial lama",
                    );
                    return;
                  }

                  if (StringUtils.isNullOrEmpty(tecOldSerialNumber.text)) {
                    Dialogs.message(
                      context: context,
                      title: "Nomor seri lama harus diisi.",
                    );

                    return;
                  }

                  if (selectedCategory != null &&
                      selectedProduct != null &&
                      replacementType != null) {
                    if (SnStockDao.find(
                          serialNumber: tecNewSerialNumber.text,
                          servicePointId: jobOrder.servicePoint!.id,
                          category: selectedCategory!.identity,
                          product: null,
                        ) ==
                        null) {
                      Dialogs.message(
                        context: context,
                        title: "Nomor seri baru tidak ditemukan.",
                      );

                      return;
                    }

                    if (selectedCategory!.identity == "MESIN") {
                      if (tecNewSerialNumber.text !=
                          (jobOrder.scannedSerialNumber ?? "")) {
                        Dialogs.message(
                          context: context,
                          title: "Nomor seri baru tidak sesuai.",
                        );

                        return;
                      }
                    } else if (selectedCategory!.identity == "PROVIDER") {
                      if (jobOrder.machineAndCard != null) {
                        if (tecNewSerialNumber.text !=
                            (jobOrder.machineAndCard!.simCard ?? "")) {
                          Dialogs.message(
                            context: context,
                            title: "Nomor seri baru tidak sesuai.",
                          );

                          return;
                        }
                      }
                    }

                    JobOrderReplacement jobOrderReplacement =
                        JobOrderReplacement(
                      selectedCategory!.identity,
                      selectedProduct!.identity,
                      selectedProduct!.description,
                      tecOldSerialNumber.text,
                      tecNewSerialNumber.text,
                      1,
                      tecReason.text,
                      type: JobOrderReplacementType(
                        replacementType.id,
                        replacementType.name,
                      ),
                    );

                    Navigators.pop(context);

                    onSelected.call(jobOrderReplacement);
                  } else {
                    Dialogs.message(
                      context: context,
                      title: "Data jenis penggantian fullset tidak ditemukan.",
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const TextSheet(
                  'TAMBAH',
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void addInputPeripheral({
    required BuildContext context,
    required JobOrder jobOrder,
    required void Function(JobOrderInputPeripheral jobOrderInputPeripheral)
        onSelected,
  }) async {
    TextEditingController tecStock = TextEditingController();
    TextEditingController tecAvailableQuantity = TextEditingController();
    TextEditingController tecUsedQuantity = TextEditingController();

    SpinnerItem? selectedNonSnStock;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.95,
          initialChildSize: 0.95,
          minChildSize: 0.65,
          builder: (context, scrollController) {
            return Scaffold(
              body: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.height10,
                  horizontal: Dimensions.width15,
                ),
                child: ScrollConfiguration(
                  behavior: NoOverscrollBehavior(),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 50,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .unselectedWidgetColor
                                  .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height15,
                          ),
                          const TextSheet(
                            'Tambah Input Periferal',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          CustomTextFieldOld(
                            controller: tecStock,
                            label: 'Pilih Stok Periferal',
                            onTap: () {
                              List<NonSnStock> nonSnStocks = NonSnStockDao.all(
                                servicePointId: jobOrder.servicePoint!.id,
                              );

                              List<SpinnerItem> spinnerItems = [];

                              for (NonSnStock nonSnStock in nonSnStocks) {
                                spinnerItems.add(
                                  SpinnerItem(
                                    identity: nonSnStock.id,
                                    description:
                                        "${nonSnStock.productName} - ${nonSnStock.servicePointName}",
                                    tag: nonSnStock,
                                  ),
                                );
                              }

                              BottomSheets.spinner(
                                context: context,
                                title: 'Pilih Stok Periferal',
                                spinnerItems: spinnerItems,
                                onSelected: (selected) {
                                  tecStock.text = selected.description;
                                  tecAvailableQuantity.text =
                                      (selected.tag as NonSnStock)
                                          .quantity
                                          .toString();

                                  selectedNonSnStock = selected;
                                },
                              );
                            },
                          ),
                          CustomTextField(
                            controller: tecAvailableQuantity,
                            label: 'Jumlah Stok Teknisi',
                            readOnly: true,
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          CustomTextField(
                            controller: tecUsedQuantity,
                            label: 'Jumlah Stok Yang Digunakan',
                            keyboardType: TextInputType.number,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: SizedBox(
                height: kToolbarHeight - 10,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedNonSnStock != null) {
                      int quantity = int.tryParse(tecUsedQuantity.text) ?? 0;

                      if (quantity > 0) {
                        NonSnStock nonSnStock =
                            selectedNonSnStock!.tag as NonSnStock;

                        if (quantity > nonSnStock.quantity) {
                          Dialogs.message(
                            context: context,
                            title: "Stok tidak mencukupi",
                          );
                        } else {
                          JobOrderInputPeripheral jobOrderInputPeripheral =
                              JobOrderInputPeripheral(
                            nonSnStock.id,
                            nonSnStock.servicePointId,
                            nonSnStock.category,
                            nonSnStock.productName,
                            quantity,
                          );

                          Navigators.pop(context);

                          onSelected.call(jobOrderInputPeripheral);
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const TextSheet(
                    'TAMBAH',
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static Future<void> terimaNonSnStock({
    required BuildContext context,
    required TerimaNonSnStockResponseDetail terimaNonSnStockResponseDetail,
  }) async {
    TextEditingController tecVendor = TextEditingController();
    TextEditingController tecServicePoint = TextEditingController();
    TextEditingController tecProductName = TextEditingController();
    TextEditingController tecAvailableQuantity = TextEditingController();
    TextEditingController tecQuantity = TextEditingController();

    tecVendor.text = terimaNonSnStockResponseDetail.vendorName;
    tecServicePoint.text = terimaNonSnStockResponseDetail.servicePointName;
    tecProductName.text = terimaNonSnStockResponseDetail.productName;
    tecAvailableQuantity.text =
        terimaNonSnStockResponseDetail.quantity.toString();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.95,
          initialChildSize: 0.95,
          minChildSize: 0.65,
          builder: (context, scrollController) {
            return BlocListener<TerimaBarangBloc, TerimaBarangState>(
              listener: (context, state) async {
                if (state is TerimaBarangSendNonSnStockLoading) {
                  context.loaderOverlay.show();
                } else if (state is TerimaBarangSendNonSnStockSuccess) {
                  Navigators.pop(context);

                  await Dialogs.message(
                    context: context,
                    title: state.message,
                  );
                } else if (state is TerimaBarangSendNonSnStockFailed) {
                  Dialogs.message(
                    context: context,
                    title: state.message,
                  );
                } else if (state is TerimaBarangSendNonSnStockFinished) {
                  context.loaderOverlay.hide();
                }
              },
              child: Scaffold(
                body: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.height10,
                    horizontal: Dimensions.width15,
                  ),
                  child: ScrollConfiguration(
                    behavior: NoOverscrollBehavior(),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 50,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .unselectedWidgetColor
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height15,
                            ),
                            const TextSheet(
                              'Terima Barang Periferal Teknisi',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            CustomTextField(
                              controller: tecVendor,
                              label: 'Vendor',
                              readOnly: true,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            CustomTextField(
                              controller: tecServicePoint,
                              label: 'Service Point',
                              readOnly: true,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            CustomTextField(
                              controller: tecProductName,
                              label: 'Nama Produk',
                              readOnly: true,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            CustomTextField(
                              controller: tecAvailableQuantity,
                              label: 'Jumlah Yang Belum Diterima',
                              readOnly: true,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            CustomTextField(
                              controller: tecQuantity,
                              label: 'Jumlah Yang Akan Diterima',
                              keyboardType: TextInputType.number,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: SizedBox(
                  height: kToolbarHeight - 10,
                  child: ElevatedButton(
                    onPressed: () {
                      int quantity = int.tryParse(tecQuantity.text) ?? 0;
                      int availableQuantity =
                          terimaNonSnStockResponseDetail.quantity;

                      if (quantity > 0) {
                        if (quantity > availableQuantity) {
                          Dialogs.message(
                            context: context,
                            title: "Stok tidak mencukupi",
                          );
                        } else {
                          context.read<TerimaBarangBloc>().add(
                                TerimaBarangSendNonSnStock(
                                  id: terimaNonSnStockResponseDetail.id,
                                  productId:
                                      terimaNonSnStockResponseDetail.productId,
                                  quantity: quantity.toString(),
                                ),
                              );
                        }
                      } else {
                        Dialogs.message(
                          context: context,
                          title: "Jumlah yang akan diterima harus diisi.",
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const TextSheet(
                      'TERIMA',
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static Future<void> returSnStock({
    required BuildContext context,
    required SnStockPortalResponseDetail snStockPortalResponseDetail,
  }) async {
    TextEditingController tecVendor = TextEditingController();
    TextEditingController tecServicePoint = TextEditingController();
    TextEditingController tecProductName = TextEditingController();
    TextEditingController tecSerialNumber = TextEditingController();
    TextEditingController tecCondition = TextEditingController();
    TextEditingController tecNote = TextEditingController();

    SpinnerItem? selectedCondition;

    tecVendor.text = snStockPortalResponseDetail.vendorName;
    tecServicePoint.text = snStockPortalResponseDetail.servicePointName;
    tecProductName.text = snStockPortalResponseDetail.productName;
    tecSerialNumber.text = snStockPortalResponseDetail.serialNumber;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.95,
          initialChildSize: 0.95,
          minChildSize: 0.65,
          builder: (context, scrollController) {
            return BlocListener<StokBarangBloc, StokBarangState>(
              listener: (context, state) async {
                if (state is StokBarangReturSnLoading) {
                  context.loaderOverlay.show();
                } else if (state is StokBarangReturSnSuccess) {
                  Navigators.pop(context);

                  await Dialogs.message(
                    context: context,
                    title: state.message,
                  );
                } else if (state is StokBarangReturSnFailed) {
                  Dialogs.message(
                    context: context,
                    title: state.message,
                  );
                } else if (state is StokBarangReturSnFinished) {
                  context.loaderOverlay.hide();
                }
              },
              child: Scaffold(
                body: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.height10,
                    horizontal: Dimensions.width15,
                  ),
                  child: ScrollConfiguration(
                    behavior: NoOverscrollBehavior(),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 50,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .unselectedWidgetColor
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height15,
                            ),
                            const TextSheet(
                              'Request Retur Barang SN',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            CustomTextField(
                              controller: tecVendor,
                              label: 'Vendor',
                              readOnly: true,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            CustomTextField(
                              controller: tecServicePoint,
                              label: 'Service Point',
                              readOnly: true,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            CustomTextField(
                              controller: tecProductName,
                              label: 'Nama Produk',
                              readOnly: true,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            CustomTextField(
                              controller: tecSerialNumber,
                              label: 'Serial Number',
                              readOnly: true,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            CustomTextFieldOld(
                              controller: tecCondition,
                              label: 'Kondisi',
                              onTap: () {
                                List<SpinnerItem> spinnerItems = [
                                  SpinnerItem(
                                    identity: "1",
                                    description: "Berfungsi",
                                  ),
                                  SpinnerItem(
                                    identity: "2",
                                    description: "Tidak Berfungsi",
                                  )
                                ];

                                BottomSheets.spinner(
                                  context: context,
                                  title: 'Kondisi',
                                  spinnerItems: spinnerItems,
                                  onSelected: (selected) {
                                    tecCondition.text = selected.description;

                                    selectedCondition = selected;
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            CustomTextField(
                              controller: tecNote,
                              label: 'Keterangan',
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: SizedBox(
                  height: kToolbarHeight - 10,
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedCondition != null) {
                        if (StringUtils.isNotNullOrEmpty(tecNote.text)) {
                          context.read<StokBarangBloc>().add(
                                StokBarangReturSn(
                                  id: snStockPortalResponseDetail.id,
                                  condition: selectedCondition!.identity,
                                  serialNumber:
                                      snStockPortalResponseDetail.serialNumber,
                                  note: tecNote.text,
                                ),
                              );
                        } else {
                          Dialogs.message(
                            context: context,
                            title: "Keterangan harus diisi.",
                          );
                        }
                      } else {
                        Dialogs.message(
                          context: context,
                          title: "Kondisi harus dipilih.",
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const TextSheet(
                      'RETUR',
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static Future<void> returNonSnStock({
    required BuildContext context,
    required NonSnStockPortalResponseDetail nonSnStockPortalResponseDetail,
  }) async {
    TextEditingController tecVendor = TextEditingController();
    TextEditingController tecServicePoint = TextEditingController();
    TextEditingController tecProductName = TextEditingController();
    TextEditingController tecAvailableQuantity = TextEditingController();
    TextEditingController tecQuantity = TextEditingController();
    TextEditingController tecCondition = TextEditingController();
    TextEditingController tecNote = TextEditingController();

    SpinnerItem? selectedCondition;

    tecVendor.text = nonSnStockPortalResponseDetail.vendorName;
    tecServicePoint.text = nonSnStockPortalResponseDetail.servicePointName;
    tecProductName.text = nonSnStockPortalResponseDetail.productName;
    tecAvailableQuantity.text =
        nonSnStockPortalResponseDetail.quantity.toString();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.95,
          initialChildSize: 0.95,
          minChildSize: 0.65,
          builder: (context, scrollController) {
            return BlocListener<StokBarangBloc, StokBarangState>(
              listener: (context, state) async {
                if (state is StokBarangReturNonSnLoading) {
                  context.loaderOverlay.show();
                } else if (state is StokBarangReturNonSnSuccess) {
                  Navigators.pop(context);

                  await Dialogs.message(
                    context: context,
                    title: state.message,
                  );
                } else if (state is StokBarangReturNonSnFailed) {
                  Dialogs.message(
                    context: context,
                    title: state.message,
                  );
                } else if (state is StokBarangReturNonSnFinished) {
                  context.loaderOverlay.hide();
                }
              },
              child: Scaffold(
                body: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.height10,
                    horizontal: Dimensions.width15,
                  ),
                  child: ScrollConfiguration(
                    behavior: NoOverscrollBehavior(),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 50,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .unselectedWidgetColor
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height15,
                            ),
                            const TextSheet(
                              'Request Retur Barang Non SN',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            CustomTextField(
                              controller: tecVendor,
                              label: 'Vendor',
                              readOnly: true,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            CustomTextField(
                              controller: tecServicePoint,
                              label: 'Service Point',
                              readOnly: true,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            CustomTextField(
                              controller: tecProductName,
                              label: 'Nama Produk',
                              readOnly: true,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            CustomTextField(
                              controller: tecAvailableQuantity,
                              label: 'Jumlah Stok',
                              readOnly: true,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            CustomTextField(
                              controller: tecQuantity,
                              label: 'Jumlah Yang Akan Diretur',
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            CustomTextFieldOld(
                              controller: tecCondition,
                              label: 'Kondisi',
                              onTap: () {
                                List<SpinnerItem> spinnerItems = [
                                  SpinnerItem(
                                    identity: "1",
                                    description: "Berfungsi",
                                  ),
                                  SpinnerItem(
                                    identity: "2",
                                    description: "Tidak Berfungsi",
                                  )
                                ];

                                BottomSheets.spinner(
                                  context: context,
                                  title: 'Kondisi',
                                  spinnerItems: spinnerItems,
                                  onSelected: (selected) {
                                    tecCondition.text = selected.description;

                                    selectedCondition = selected;
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            CustomTextField(
                              controller: tecNote,
                              label: 'Keterangan',
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: SizedBox(
                  height: kToolbarHeight - 10,
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedCondition != null) {
                        if (StringUtils.isNotNullOrEmpty(tecNote.text)) {
                          int quantity = int.tryParse(tecQuantity.text) ?? 0;
                          int availableQuantity =
                              nonSnStockPortalResponseDetail.quantity;

                          if (quantity > 0) {
                            if (quantity > availableQuantity) {
                              Dialogs.message(
                                context: context,
                                title: "Stok tidak mencukupi",
                              );
                            } else {
                              context.read<StokBarangBloc>().add(
                                    StokBarangReturNonSn(
                                      id: nonSnStockPortalResponseDetail.id,
                                      condition: selectedCondition!.identity,
                                      productId: nonSnStockPortalResponseDetail
                                          .productId,
                                      quantity: quantity.toString(),
                                      note: tecNote.text,
                                    ),
                                  );
                            }
                          } else {
                            Dialogs.message(
                              context: context,
                              title: "Jumlah yang akan diretur harus diisi.",
                            );
                          }
                        } else {
                          Dialogs.message(
                            context: context,
                            title: "Keterangan harus diisi.",
                          );
                        }
                      } else {
                        Dialogs.message(
                          context: context,
                          title: "Kondisi harus dipilih.",
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const TextSheet(
                      'RETUR',
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static Future<dynamic> showInboxMessage({
    required BuildContext context,
    required Inbox inbox,
  }) async {
    return await showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      builder: (context) {
        return Column(
          children: [
            SizedBox(
              height: Dimensions.screenHeight * 0.05,
            ),
            Expanded(
              child: Scaffold(
                backgroundColor: Theme.of(context).primaryColor,
                appBar: const StandardAppBar(
                  title: Text(
                    "Detil Pesan",
                  ),
                ),
                body: ScrollConfiguration(
                  behavior: NoOverscrollBehavior(),
                  child: Padding(
                    padding: EdgeInsets.all(Dimensions.width15),
                    child: ListView(
                      children: [
                        TextSheet(
                          inbox.title,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextSheet(
                          Formats.date(inbox.date),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextSheet(
                          inbox.body,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  static Future<dynamic> webView({
    required BuildContext context,
    required String url,
  }) async {
    WebViewController webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(url));

    if (Platform.isAndroid) {
      final controller = (webViewController.platform
          as webview_flutter_android.AndroidWebViewController);
      await controller.setOnShowFileSelector((params) async {
        final result = await FilePicker.platform.pickFiles();

        if (result != null && result.files.single.path != null) {
          final file = File(result.files.single.path!);
          return [file.uri.toString()];
        }
        return [];
      });
    }

    return await showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      builder: (context) {
        return Column(
          children: [
            SizedBox(
              height: Dimensions.screenHeight * 0.05,
            ),
            Expanded(
              child: Scaffold(
                backgroundColor: Theme.of(context).primaryColor,
                appBar: const StandardAppBar(
                  title: Text("Portal Web"),
                ),
                body: ScrollConfiguration(
                  behavior: NoOverscrollBehavior(),
                  child: WebViewWidget(controller: webViewController),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  static void imagePreview({
    required BuildContext context,
    required String title,
    required Uint8List bytes,
  }) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Material(
              color: Theme.of(context).primaryColor,
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.04,
                ),
                child: Scaffold(
                  backgroundColor: Theme.of(context).primaryColor,
                  appBar: StandardAppBar(
                    title: Text(title),
                  ),
                  body: PhotoView(
                    imageProvider: MemoryImage(bytes),
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class SpinnerItem {
  final dynamic identity;
  final String description;
  final dynamic tag;
  final String? subDescription;
  final String? additionalText;

  SpinnerItem({
    required this.identity,
    required this.description,
    this.tag,
    this.subDescription,
    this.additionalText,
  });
}

class CheckItem {
  final dynamic identity;
  final String description;
  final String? groupBy;
  final String? subtitle;
  final dynamic tag;
  bool value;

  CheckItem({
    required this.identity,
    required this.description,
    this.groupBy,
    this.subtitle,
    this.tag,
    this.value = false,
  });
}

class NumberItem {
  final dynamic identity;
  final String description;
  final dynamic tag;
  int value;

  NumberItem({
    required this.identity,
    required this.description,
    this.tag,
    this.value = 0,
  });
}
