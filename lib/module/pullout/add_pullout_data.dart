import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rtracker/helper/bottom_sheets.dart';
import 'package:rtracker/helper/dimensions.dart';
import 'package:rtracker/module/pullout/bloc/add_pullout_bloc/add_pullout_bloc.dart';
import 'package:rtracker/widget/custom_image_field.dart';
import 'package:rtracker/widget/custom_spinner_field.dart';
import 'package:rtracker/widget/custom_text_field.dart';
import 'package:rtracker/widget/text_sheet.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class AddPulloutData extends StatefulWidget {
  const AddPulloutData({Key? key}) : super(key: key);

  @override
  State<AddPulloutData> createState() => _AddPulloutDataState();
}

class _AddPulloutDataState extends State<AddPulloutData> {

  var processBloc = AddPulloutBloc();

  TextEditingController tecPic = TextEditingController();
  TextEditingController tecPhoneNumber = TextEditingController();

  SpinnerItem? selectedServicePoint;
  SpinnerItem? selectedProduct;
  SpinnerItem? selectedGoodStatus;
  SpinnerItem? selectedMerchant;

  List<Uint8List> photoMerchant = [];
  List<Uint8List> photoMachine = [];
  List<Uint8List> photoSignature = [];

  bool hasSign = false;

  @override
  void initState() {
    super.initState();
    context.read<AddPulloutBloc>().add(
      LoadAllData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: processBloc,
      listener: (context, state) {
        if (state is LoadingProcess){
          if (state.loading){
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
        }
        if (state is ProcessSuccess){

        }
        if (state is ProcessFailed){

        }
      },
      child: Padding(
        padding: EdgeInsets.all(
          Dimensions.width15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextSheet(
              "TAMBAH BARANG TARIKAN",
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: Dimensions.height15,
            ),
            BlocBuilder<AddPulloutBloc, AddPulloutState>(
              builder: (context, state) {
                if (state is LoadedData) {
                  return CustomSpinnerField(
                    labelText: "Service Point",
                    initialValue: selectedServicePoint,
                    readOnly: false,
                    validator: (value) {
                      if (value == null) {
                        return "Kolom ini harus diisi.";
                      }
                      return null;
                    },
                    onChanged: (newValue) {
                      selectedServicePoint = newValue;
                    },
                    spinnerItems: state.listServicePoint,
                  );
                } else {
                  return Container();
                }
              },
            ),
            SizedBox(
              height: Dimensions.height15,
            ),
            BlocBuilder<AddPulloutBloc, AddPulloutState>(
              builder: (context, state) {
                if (state is LoadedData) {
                  return CustomSpinnerField(
                    labelText: "Product",
                    initialValue: selectedProduct,
                    readOnly: false,
                    validator: (value) {
                      if (value == null) {
                        return "Kolom ini harus diisi.";
                      }
                      return null;
                    },
                    onChanged: (newValue) {
                      selectedProduct = newValue;
                    },
                    spinnerItems: state.listProduct,
                  );
                } else {
                  return Container();
                }
              },
            ),
            SizedBox(
              height: Dimensions.height15,
            ),
            BlocBuilder<AddPulloutBloc, AddPulloutState>(
              builder: (context, state) {
                if (state is LoadedData) {
                  return CustomSpinnerField(
                    labelText: "Status Barang",
                    initialValue: selectedGoodStatus,
                    readOnly: false,
                    validator: (value) {
                      if (value == null) {
                        return "Kolom ini harus diisi.";
                      }
                      return null;
                    },
                    onChanged: (newValue) {
                      selectedGoodStatus = newValue;
                    },
                    spinnerItems: state.listStatusGoods,
                  );
                } else {
                  return Container();
                }
              },
            ),
            SizedBox(
              height: Dimensions.height15,
            ),
            BlocBuilder<AddPulloutBloc, AddPulloutState>(
              builder: (context, state) {
                if (state is LoadedData) {
                  return CustomSpinnerField(
                    labelText: "Merchant",
                    initialValue: selectedMerchant,
                    readOnly: false,
                    validator: (value) {
                      if (value == null) {
                        return "Kolom ini harus diisi.";
                      }
                      return null;
                    },
                    onChanged: (newValue) {
                      selectedMerchant = newValue;
                    },
                    spinnerItems: state.listMerchant,
                  );
                } else {
                  return Container();
                }
              },
            ),
            SizedBox(
              height: Dimensions.height15,
            ),
            CustomTextField(
              controller: tecPic,
              label: 'PIC',
              readOnly: false,
              validator: (value) {
                if (StringUtils.isNullOrEmpty(value)) {
                  return "Kolom ini harus diisi.";
                }
                return null;
              },
            ),
            SizedBox(
              height: Dimensions.height15,
            ),
            CustomTextField(
              controller: tecPhoneNumber,
              label: 'No Handphone',
              readOnly: false,
              validator: (value) {
                if (StringUtils.isNullOrEmpty(value)) {
                  return "Kolom ini harus diisi.";
                }
                return null;
              },
            ),
            SizedBox(
              height: Dimensions.height15,
            ),
            CustomImageField(
              title: "Foto Merchant",
              subtitle: "Silahkan unggah foto merchant",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Kolom ini harus diisi.";
                }

                return null;
              },
              initialValue: photoMerchant,
              onSaved: (newValue) {
                if (newValue != null) {
                  photoMerchant = newValue;
                }
              },
            ),
            SizedBox(
              height: Dimensions.height15,
            ),
            CustomImageField(
              title: "Foto Mesin",
              subtitle: "Silahkan unggah foto mesin",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Kolom ini harus diisi.";
                }

                return null;
              },
              initialValue: photoMachine,
              onSaved: (newValue) {
                if (newValue != null) {
                  photoMachine = newValue;
                }
              },
            ),
            SizedBox(
              height: Dimensions.height15,
            ),
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                border: Border.all(
                  color: Colors.blue, // Border color
                  width: 3.0, // Border width
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: SfSignaturePad(
                onDrawEnd: () => hasSign = true,
                backgroundColor: Colors.white,
              ),
            ),
            SizedBox(
              height: Dimensions.height15,
            ),
            ElevatedButton(
              onPressed: () {

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
          ],
        ),
      ),
    );
  }
}
