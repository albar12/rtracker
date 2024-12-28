import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/helper/dimensions.dart';
import 'package:rtracker/helper/image_mandatory.dart';
import 'package:rtracker/helper/preferences.dart';
import 'package:rtracker/module/job_form/image_load_bloc/image_load_bloc.dart';
import 'package:rtracker/module/job_form/image_load_bloc/image_load_event.dart';
import 'package:rtracker/module/job_form/image_load_bloc/image_load_state.dart';
import 'package:rtracker/module/job_form/job_form_page.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/widget/custom_image_field.dart';
import 'package:rtracker/widget/custom_shimmer.dart';

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
  late ImageLoadBloc machineImageBloc;
  late ImageLoadBloc machineSerialNumberImageBloc;
  late ImageLoadBloc picMerchantImageBloc;
  late ImageLoadBloc rollSalesDraftImageBloc;
  late ImageLoadBloc trainingStatementLetterImageBloc;
  late ImageLoadBloc edcAppImageBloc;
  late ImageLoadBloc otherImageBloc;

  @override
  void initState() {
    super.initState();
    JobOrder jobOrder = widget.jobFormPageState.widget.jobOrder;
    machineImageBloc = ImageLoadBloc();
    machineSerialNumberImageBloc = ImageLoadBloc();
    picMerchantImageBloc = ImageLoadBloc();
    rollSalesDraftImageBloc = ImageLoadBloc();
    trainingStatementLetterImageBloc = ImageLoadBloc();
    edcAppImageBloc = ImageLoadBloc();
    otherImageBloc = ImageLoadBloc();
    if (jobOrder.machineAndCard != null) {
      machineImageBloc.add(ImageLoadFromRealm(jobOrder.machineAndCard!.images));
      machineSerialNumberImageBloc.add(ImageLoadFromRealm(jobOrder.machineAndCard!.serialNumberPhotos));
      picMerchantImageBloc.add(ImageLoadFromRealm(jobOrder.machineAndCard!.picMerchantImages));
      rollSalesDraftImageBloc.add(ImageLoadFromRealm(jobOrder.machineAndCard!.rollSalesDraftImages));
      trainingStatementLetterImageBloc.add(ImageLoadFromRealm(jobOrder.machineAndCard!.trainingStatementLetterImages));
      edcAppImageBloc.add(ImageLoadFromRealm(jobOrder.machineAndCard!.edcAppImages));
      otherImageBloc.add(ImageLoadFromRealm(jobOrder.machineAndCard!.otherImages));
    }
  }

  @override
  void dispose() {
    super.dispose();
    machineImageBloc.close();
    machineSerialNumberImageBloc.close();
    picMerchantImageBloc.close();
    rollSalesDraftImageBloc.close();
    trainingStatementLetterImageBloc.close();
    edcAppImageBloc.close();
    otherImageBloc.close();
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
          BlocBuilder<ImageLoadBloc, ImageLoadState>(
            bloc: machineImageBloc,
            builder: (context, state){
              if (state is ImageLoadSuccess){
                return CustomImageField(
                  title: "FOTO MESIN",
                  subtitle: "Silahkan unggah foto mesin",
                  allowGallery: Preferences.getInstance().getBool(SharedPreferenceKey.MACHINE_IMAGE_ALLOW_GALLERY) ?? false,
                  validator: (value) {
                    if (ImageMandatory.getImageMandatory(jobOrder.imageMandatoryType, ImageMandatoryKey.machine) == "1") {
                      if (value == null || value.isEmpty) {
                        return "Kolom ini harus diisi.";
                      }
                    }

                    if (value != null && value.length > 3) {
                      return "Gambar maksimal 3";
                    }

                    return null;
                  },
                  initialValue: state.listImages,
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
                );
              } else {
                return CustomShimmer.customImageShimmer(context);
              }
            },
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          BlocBuilder<ImageLoadBloc, ImageLoadState>(
            bloc: machineSerialNumberImageBloc,
            builder: (context, state){
              if (state is ImageLoadSuccess){
                return CustomImageField(
                  title: "FOTO SIM CARD + SN EDC + SAM CARD",
                  subtitle: "Silahkan unggah foto sim card + sn edc + sam card",
                  allowGallery: Preferences.getInstance().getBool(
                    SharedPreferenceKey.MACHINE_SERIAL_NUMBER_PHOTO_ALLOW_GALLERY,
                  ) ??
                      false,
                  validator: (value) {
                    if (ImageMandatory.getImageMandatory(jobOrder.imageMandatoryType, ImageMandatoryKey.serialNumber) == "1") {
                      if (value == null || value.isEmpty) {
                        return "Kolom ini harus diisi.";
                      }
                    }

                    if (value != null && value.length > 3) {
                      return "Gambar maksimal 3";
                    }

                    return null;
                  },
                  initialValue: state.listImages,
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
                );
              } else {
                return CustomShimmer.customImageShimmer(context);
              }
            },
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          BlocBuilder<ImageLoadBloc, ImageLoadState>(
            bloc: picMerchantImageBloc,
            builder: (context, state){
              if (state is ImageLoadSuccess){
                return CustomImageField(
                  title: "FOTO PIC MERCHANT",
                  subtitle: "Silahkan unggah foto pic merchant",
                  allowGallery: Preferences.getInstance().getBool(
                    SharedPreferenceKey.PIC_MERCHANT_IMAGE_ALLOW_GALLERY,
                  ) ??
                      false,
                  validator: (value) {
                    if (ImageMandatory.getImageMandatory(jobOrder.imageMandatoryType, ImageMandatoryKey.picMerchant) == "1") {
                      if (value == null || value.isEmpty) {
                        return "Kolom ini harus diisi.";
                      }
                    }

                    if (value != null && value.length > 3) {
                      return "Gambar maksimal 3";
                    }

                    return null;
                  },
                  initialValue: state.listImages,
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
                );
              } else {
                return CustomShimmer.customImageShimmer(context);
              }
            },
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          BlocBuilder<ImageLoadBloc, ImageLoadState>(
            bloc: rollSalesDraftImageBloc,
            builder: (context, state){
              if (state is ImageLoadSuccess){
                return CustomImageField(
                  title: "FOTO ROLL SALES DRAFT",
                  subtitle: "Silahkan unggah foto roll sales draft",
                  allowGallery: Preferences.getInstance().getBool(
                    SharedPreferenceKey.ROLL_SALES_DRAFT_IMAGE_ALLOW_GALLERY,
                  ) ??
                      false,
                  validator: (value) {
                    if (ImageMandatory.getImageMandatory(jobOrder.imageMandatoryType, ImageMandatoryKey.rollSalesDraft) == "1") {
                      if (value == null || value.isEmpty) {
                        return "Kolom ini harus diisi.";
                      }
                    }

                    if (value != null && value.length > 3) {
                      return "Gambar maksimal 3";
                    }

                    return null;
                  },
                  initialValue: state.listImages,
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
                );
              } else {
                return CustomShimmer.customImageShimmer(context);
              }
            },
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          BlocBuilder<ImageLoadBloc, ImageLoadState>(
            bloc: trainingStatementLetterImageBloc,
            builder: (context, state){
              if (state is ImageLoadSuccess){
                return CustomImageField(
                  title: "FOTO SURAT PERNYATAAN TRAINING",
                  subtitle: "Silahkan unggah foto surat pernyataan training",
                  allowGallery: Preferences.getInstance().getBool(
                    SharedPreferenceKey.TRAINING_STATEMENT_LETTER_IMAGE_ALLOW_GALLERY,
                  ) ??
                      false,
                  validator: (value) {
                    if (ImageMandatory.getImageMandatory(jobOrder.imageMandatoryType, ImageMandatoryKey.trainingStatementLetter) == "1") {
                      if (value == null || value.isEmpty) {
                        return "Kolom ini harus diisi.";
                      }
                    }

                    if (value != null && value.length > 3) {
                      return "Gambar maksimal 3";
                    }

                    return null;
                  },
                  initialValue: state.listImages,
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
                );
              } else {
                return CustomShimmer.customImageShimmer(context);
              }
            },
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          BlocBuilder<ImageLoadBloc, ImageLoadState>(
            bloc: edcAppImageBloc,
            builder: (context, state){
              if (state is ImageLoadSuccess){
                return CustomImageField(
                  title: "FOTO APLIKASI EDC",
                  subtitle: "Silahkan unggah foto aplikasi edc",
                  allowGallery: Preferences.getInstance().getBool(
                    SharedPreferenceKey.EDC_APP_IMAGE_ALLOW_GALLERY,
                  ) ??
                      false,
                  validator: (value) {
                    if (ImageMandatory.getImageMandatory(jobOrder.imageMandatoryType, ImageMandatoryKey.edcApp) == "1") {
                      if (value == null || value.isEmpty) {
                        return "Kolom ini harus diisi.";
                      }
                    }

                    if (value != null && value.length > 3) {
                      return "Gambar maksimal 3";
                    }

                    return null;
                  },
                  initialValue: state.listImages,
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
                );
              } else {
                return CustomShimmer.customImageShimmer(context);
              }
            },
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          BlocBuilder<ImageLoadBloc, ImageLoadState>(
            bloc: otherImageBloc,
            builder: (context, state){
              if (state is ImageLoadSuccess){
                return CustomImageField(
                  title: "FOTO SURAT LAMPIRAN",
                  subtitle: "Silahkan unggah foto surat lampiran",
                  allowGallery: Preferences.getInstance().getBool(
                    SharedPreferenceKey.OTHER_IMAGE_ALLOW_GALLERY,
                  ) ??
                      false,
                  validator: (value) {
                    if (ImageMandatory.getImageMandatory(jobOrder.imageMandatoryType, ImageMandatoryKey.other) == "1") {
                      if (value == null || value.isEmpty) {
                        return "Kolom ini harus diisi.";
                      }
                    }

                    if (value != null && value.length > 3) {
                      return "Gambar maksimal 3";
                    }

                    return null;
                  },
                  initialValue: state.listImages,
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
                );
              } else {
                return CustomShimmer.customImageShimmer(context);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
