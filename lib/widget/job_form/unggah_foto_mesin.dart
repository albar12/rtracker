import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/helper/dimensions.dart';
import 'package:rtracker/helper/preferences.dart';
import 'package:rtracker/module/job_form/job_form_page.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/widget/custom_image_field.dart';

class UnggahFotoMesin extends StatefulWidget {
  final JobFormPageState jobFormPageState;

  const UnggahFotoMesin({
    Key? key,
    required this.jobFormPageState,
  }) : super(key: key);

  @override
  State<UnggahFotoMesin> createState() => UnggahFotoMesinState();
}

class UnggahFotoMesinState extends State<UnggahFotoMesin> with AutomaticKeepAliveClientMixin {
  List<Uint8List> machineImages = [];
  List<Uint8List> machineSerialNumberPhotos = [];
  List<Uint8List> picMerchantImages = [];
  List<Uint8List> rollSalesDraftImages = [];
  List<Uint8List> trainingStatementLetterImages = [];
  List<Uint8List> edcAppImages = [];
  List<Uint8List> otherImages = [];

  @override
  void initState() {
    super.initState();

    JobOrder jobOrder = widget.jobFormPageState.widget.jobOrder;

    if (jobOrder.machineAndCard != null) {
      for (ImageFile imageFile in jobOrder.machineAndCard!.images) {
        machineImages.add(
          Uint8List.fromList(imageFile.file),
        );
      }

      for (ImageFile imageFile in jobOrder.machineAndCard!.serialNumberPhotos) {
        machineSerialNumberPhotos.add(
          Uint8List.fromList(imageFile.file),
        );
      }

      for (ImageFile imageFile in jobOrder.machineAndCard!.picMerchantImages) {
        picMerchantImages.add(
          Uint8List.fromList(imageFile.file),
        );
      }

      for (ImageFile imageFile in jobOrder.machineAndCard!.rollSalesDraftImages) {
        rollSalesDraftImages.add(
          Uint8List.fromList(imageFile.file),
        );
      }

      for (ImageFile imageFile in jobOrder.machineAndCard!.trainingStatementLetterImages) {
        trainingStatementLetterImages.add(
          Uint8List.fromList(imageFile.file),
        );
      }

      for (ImageFile imageFile in jobOrder.machineAndCard!.edcAppImages) {
        edcAppImages.add(
          Uint8List.fromList(imageFile.file),
        );
      }

      for (ImageFile imageFile in jobOrder.machineAndCard!.otherImages) {
        otherImages.add(
          Uint8List.fromList(imageFile.file),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    JobOrder jobOrder = widget.jobFormPageState.widget.jobOrder;

    return Padding(
      padding: EdgeInsets.all(
        Dimensions.width15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageField(
            title: "FOTO MESIN",
            subtitle: "Silahkan unggah foto mesin (maksimal 3)",
            allowGallery: Preferences.getInstance().getBool(SharedPreferenceKey.MACHINE_IMAGE_ALLOW_GALLERY) ?? false,
            validator: (value) {
              if (jobOrder.imageMandatoryType[2] == "1") {
                if (value == null || value.isEmpty) {
                  return "Kolom ini harus diisi.";
                }
              }

              if (value != null && value.length > 3) {
                return "Gambar maksimal 3";
              }

              return null;
            },
            initialValue: jobOrder.machineAndCard != null ? jobOrder.machineAndCard!.images.map((e) => Uint8List.fromList(e.file)).toList() : [],
            readOnly: widget.jobFormPageState.widget.readOnly,
            onSaved: (newValue) {
              if (newValue != null) {
                Realms.get().write(() {
                  jobOrder.machineAndCard ??= JobOrderMachineAndCard();
                  jobOrder.machineAndCard!.images.clear();

                  for (Uint8List uint8List in newValue) {
                    jobOrder.machineAndCard!.images.add(
                      ImageFile(file: uint8List),
                    );
                  }
                });
              }
            },
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomImageField(
            title: "FOTO NOMOR SERI",
            subtitle: "Silahkan unggah foto nomor seri (maksimal 3)",
            allowGallery: Preferences.getInstance().getBool(
                  SharedPreferenceKey.MACHINE_SERIAL_NUMBER_PHOTO_ALLOW_GALLERY,
                ) ??
                false,
            validator: (value) {
              if (jobOrder.imageMandatoryType[3] == "1") {
                if (value == null || value.isEmpty) {
                  return "Kolom ini harus diisi.";
                }
              }

              if (value != null && value.length > 3) {
                return "Gambar maksimal 3";
              }

              return null;
            },
            initialValue: jobOrder.machineAndCard != null ? jobOrder.machineAndCard!.serialNumberPhotos.map((e) => Uint8List.fromList(e.file)).toList() : [],
            readOnly: widget.jobFormPageState.widget.readOnly,
            onSaved: (newValue) {
              if (newValue != null) {
                Realms.get().write(() {
                  jobOrder.machineAndCard ??= JobOrderMachineAndCard();
                  jobOrder.machineAndCard!.serialNumberPhotos.clear();

                  for (Uint8List uint8List in newValue) {
                    jobOrder.machineAndCard!.serialNumberPhotos.add(
                      ImageFile(file: uint8List),
                    );
                  }
                });
              }
            },
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomImageField(
            title: "FOTO PIC MERCHANT",
            subtitle: "Silahkan unggah foto pic merchant (maksimal 3)",
            allowGallery: Preferences.getInstance().getBool(
              SharedPreferenceKey.MACHINE_SERIAL_NUMBER_PHOTO_ALLOW_GALLERY,
            ) ??
                false,
            validator: (value) {
              if (jobOrder.imageMandatoryType[3] == "1") {
                if (value == null || value.isEmpty) {
                  return "Kolom ini harus diisi.";
                }
              }

              if (value != null && value.length > 3) {
                return "Gambar maksimal 3";
              }

              return null;
            },
            initialValue: jobOrder.machineAndCard != null ? jobOrder.machineAndCard!.picMerchantImages.map((e) => Uint8List.fromList(e.file)).toList() : [],
            readOnly: widget.jobFormPageState.widget.readOnly,
            onSaved: (newValue) {
              if (newValue != null) {
                Realms.get().write(() {
                  jobOrder.machineAndCard ??= JobOrderMachineAndCard();
                  jobOrder.machineAndCard!.picMerchantImages.clear();

                  for (Uint8List uint8List in newValue) {
                    jobOrder.machineAndCard!.picMerchantImages.add(
                      ImageFile(file: uint8List),
                    );
                  }
                });
              }
            },
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomImageField(
            title: "FOTO ROLL SALES DRAFT",
            subtitle: "Silahkan unggah foto roll sales draft (maksimal 3)",
            allowGallery: Preferences.getInstance().getBool(
              SharedPreferenceKey.MACHINE_SERIAL_NUMBER_PHOTO_ALLOW_GALLERY,
            ) ??
                false,
            validator: (value) {
              if (jobOrder.imageMandatoryType[3] == "1") {
                if (value == null || value.isEmpty) {
                  return "Kolom ini harus diisi.";
                }
              }

              if (value != null && value.length > 3) {
                return "Gambar maksimal 3";
              }

              return null;
            },
            initialValue: jobOrder.machineAndCard != null ? jobOrder.machineAndCard!.rollSalesDraftImages.map((e) => Uint8List.fromList(e.file)).toList() : [],
            readOnly: widget.jobFormPageState.widget.readOnly,
            onSaved: (newValue) {
              if (newValue != null) {
                Realms.get().write(() {
                  jobOrder.machineAndCard ??= JobOrderMachineAndCard();
                  jobOrder.machineAndCard!.rollSalesDraftImages.clear();

                  for (Uint8List uint8List in newValue) {
                    jobOrder.machineAndCard!.rollSalesDraftImages.add(
                      ImageFile(file: uint8List),
                    );
                  }
                });
              }
            },
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomImageField(
            title: "FOTO SURAT PERNYATAAN TRAINING",
            subtitle: "Silahkan unggah foto surat pernyataan training (maksimal 3)",
            allowGallery: Preferences.getInstance().getBool(
              SharedPreferenceKey.MACHINE_SERIAL_NUMBER_PHOTO_ALLOW_GALLERY,
            ) ??
                false,
            validator: (value) {
              if (jobOrder.imageMandatoryType[3] == "1") {
                if (value == null || value.isEmpty) {
                  return "Kolom ini harus diisi.";
                }
              }

              if (value != null && value.length > 3) {
                return "Gambar maksimal 3";
              }

              return null;
            },
            initialValue: jobOrder.machineAndCard != null ? jobOrder.machineAndCard!.trainingStatementLetterImages.map((e) => Uint8List.fromList(e.file)).toList() : [],
            readOnly: widget.jobFormPageState.widget.readOnly,
            onSaved: (newValue) {
              if (newValue != null) {
                Realms.get().write(() {
                  jobOrder.machineAndCard ??= JobOrderMachineAndCard();
                  jobOrder.machineAndCard!.trainingStatementLetterImages.clear();

                  for (Uint8List uint8List in newValue) {
                    jobOrder.machineAndCard!.trainingStatementLetterImages.add(
                      ImageFile(file: uint8List),
                    );
                  }
                });
              }
            },
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomImageField(
            title: "FOTO APLIKASI EDC",
            subtitle: "Silahkan unggah foto aplikasi edc (maksimal 3)",
            allowGallery: Preferences.getInstance().getBool(
              SharedPreferenceKey.MACHINE_SERIAL_NUMBER_PHOTO_ALLOW_GALLERY,
            ) ??
                false,
            validator: (value) {
              if (jobOrder.imageMandatoryType[3] == "1") {
                if (value == null || value.isEmpty) {
                  return "Kolom ini harus diisi.";
                }
              }

              if (value != null && value.length > 3) {
                return "Gambar maksimal 3";
              }

              return null;
            },
            initialValue: jobOrder.machineAndCard != null ? jobOrder.machineAndCard!.edcAppImages.map((e) => Uint8List.fromList(e.file)).toList() : [],
            readOnly: widget.jobFormPageState.widget.readOnly,
            onSaved: (newValue) {
              if (newValue != null) {
                Realms.get().write(() {
                  jobOrder.machineAndCard ??= JobOrderMachineAndCard();
                  jobOrder.machineAndCard!.edcAppImages.clear();

                  for (Uint8List uint8List in newValue) {
                    jobOrder.machineAndCard!.edcAppImages.add(
                      ImageFile(file: uint8List),
                    );
                  }
                });
              }
            },
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          CustomImageField(
            title: "FOTO SURAT LAMPIRAN",
            subtitle: "Silahkan unggah foto surat lampiran (maksimal 3)",
            allowGallery: Preferences.getInstance().getBool(
              SharedPreferenceKey.MACHINE_SERIAL_NUMBER_PHOTO_ALLOW_GALLERY,
            ) ??
                false,
            validator: (value) {
              if (jobOrder.imageMandatoryType[3] == "1") {
                if (value == null || value.isEmpty) {
                  return "Kolom ini harus diisi.";
                }
              }

              if (value != null && value.length > 3) {
                return "Gambar maksimal 3";
              }

              return null;
            },
            initialValue: jobOrder.machineAndCard != null ? jobOrder.machineAndCard!.otherImages.map((e) => Uint8List.fromList(e.file)).toList() : [],
            readOnly: widget.jobFormPageState.widget.readOnly,
            onSaved: (newValue) {
              if (newValue != null) {
                Realms.get().write(() {
                  jobOrder.machineAndCard ??= JobOrderMachineAndCard();
                  jobOrder.machineAndCard!.otherImages.clear();

                  for (Uint8List uint8List in newValue) {
                    jobOrder.machineAndCard!.otherImages.add(
                      ImageFile(file: uint8List),
                    );
                  }
                });
              }
            },
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
