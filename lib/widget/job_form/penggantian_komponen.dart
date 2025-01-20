// ignore_for_file: invalid_use_of_protected_member

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:loader_overlay/loader_overlay.dart";
import "package:rtracker/constant.dart";
import "package:rtracker/helper/app_colors.dart";
import "package:rtracker/helper/bottom_sheets.dart";
import "package:rtracker/helper/dialogs.dart";
import "package:rtracker/helper/dimensions.dart";
import "package:rtracker/helper/extensions.dart";
import "package:rtracker/helper/strings.dart";
import "package:rtracker/module/job_form/job_form_page.dart";
import "package:rtracker/module/job_form/replacement_bloc/replacement_bloc.dart";
import "package:rtracker/realm/realms.dart";
import "package:rtracker/realm/schemas.dart";
import "package:rtracker/realm/sn_stock_dao.dart";
import "package:rtracker/widget/custom_chips.dart";
import "package:rtracker/widget/text_sheet.dart";

class PenggantianKomponen extends StatefulWidget {
  final JobFormPageState jobFormPageState;

  const PenggantianKomponen({
    Key? key,
    required this.jobFormPageState,
  }) : super(key: key);

  @override
  State<PenggantianKomponen> createState() => PenggantianKomponenState();
}

class PenggantianKomponenState extends State<PenggantianKomponen> with AutomaticKeepAliveClientMixin {
  List<JobOrderReplacement> jobOrderReplacements = [];
  Map<String, List<SpinnerItem>> mapData = {};

  @override
  void initState() {
    super.initState();
    context.read<ReplacementBloc>().add(GetAllProduct(vendorId: widget.jobFormPageState.widget.jobOrder.vendorId!));
    for (JobOrderReplacement jobOrderReplacement in widget.jobFormPageState.widget.jobOrder.replacements) {
      jobOrderReplacements.add(jobOrderReplacement);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocListener<ReplacementBloc, ReplacementState>(
      listener: (context, state) {
        if (state is ReplacementLoading){
          context.loaderOverlay.show();
        }
        if (state is ReplacementLoaded){
          mapData["MESIN"] = state.listMachine;
          mapData["PROVIDER"] = state.listSimcard;
          mapData["SAMCARD"] = state.listSamcard;
          context.loaderOverlay.hide();
        }
      },
      child: FormField<List<JobOrderReplacement>?>(
        initialValue: jobOrderReplacements,
        onSaved: (value) {
          if (value != null) {
            Realms.get().write(() {
              widget.jobFormPageState.widget.jobOrder.replacements.clear();
              widget.jobFormPageState.widget.jobOrder.replacements.addAll(value);
            });
          }
        },
        builder: (field) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(
                  Dimensions.width15,
                ),
                child: Visibility(
                  visible: widget.jobFormPageState.widget.jobOrder.jobType != null &&
                      !Strings.equalsAny(
                        widget.jobFormPageState.widget.jobOrder.jobType!.id,
                        ["21", "18"],
                      ),
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: widget.jobFormPageState.widget.readOnly
                        ? null
                        : () {
                      BottomSheets.addReplacementPart(
                        context: context,
                        jobOrder: widget.jobFormPageState.widget.jobOrder,
                        replacementTypes: widget.jobFormPageState.replacementTypes,
                        map: mapData,
                        onSelected: (jobOrderReplacement) {
                          if (Strings.equalsIgnoreCase(
                            jobOrderReplacement.oldSerialNumber,
                            jobOrderReplacement.newSerialNumber,
                          )) {
                            Dialogs.message(
                              context: context,
                              title: "Nomor seri baru tidak boleh sama dengan nomor seri lama.",
                            );
                          } else {
                            if (Strings.equals(
                              jobOrderReplacement.category,
                              SnStockCategory.MESIN.name,
                            )) {
                              int count = 0;

                              if (field.value != null) {
                                for (JobOrderReplacement jobOrderReplacementCheck in field.value!) {
                                  if (Strings.equals(
                                    jobOrderReplacementCheck.category,
                                    jobOrderReplacement.category,
                                  )) {
                                    count++;
                                  }
                                }

                                if (count < 1) {
                                  setState(() {
                                    field.value!.add(jobOrderReplacement);
                                  });
                                } else {
                                  Dialogs.message(
                                    context: context,
                                    title: "Nomor seri mesin maksimal 1.",
                                  );
                                }
                              }
                            } else if (Strings.equals(
                              jobOrderReplacement.category,
                              SnStockCategory.PROVIDER.name,
                            )) {
                              int count = 0;

                              if (field.value != null) {
                                for (JobOrderReplacement jobOrderReplacementCheck in field.value!) {
                                  if (Strings.equals(
                                    jobOrderReplacementCheck.category,
                                    jobOrderReplacement.category,
                                  )) {
                                    count++;
                                  }
                                }

                                if (count < 1) {
                                  setState(() {
                                    field.value!.add(jobOrderReplacement);
                                  });
                                } else {
                                  Dialogs.message(
                                    context: context,
                                    title: "Nomor simcard maksimal 1.",
                                  );
                                }
                              }
                            } else if (Strings.equals(
                              jobOrderReplacement.category,
                              SnStockCategory.SAMCARD.name,
                            )) {
                              int count = 0;

                              if (field.value != null) {
                                for (JobOrderReplacement jobOrderReplacementCheck in field.value!) {
                                  if (Strings.equals(
                                    jobOrderReplacementCheck.category,
                                    jobOrderReplacement.category,
                                  )) {
                                    count++;
                                  }
                                }

                                if (count < 3) {
                                  setState(() {
                                    field.value!.add(jobOrderReplacement);
                                  });
                                } else {
                                  Dialogs.message(
                                    context: context,
                                    title: "Nomor samcard maksimal 3.",
                                  );
                                }
                              }
                            }
                          }
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.add),
                        SizedBox(
                          width: 10,
                        ),
                        TextSheet("TAMBAH PENGGANTIAN")
                      ],
                    ),
                  ),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: field.value!.length,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 1,
                    thickness: 1,
                  );
                },
                itemBuilder: (context, index) {
                  JobOrderReplacement jobOrderReplacement = field.value![index];

                  return Container(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    padding: EdgeInsets.all(
                      Dimensions.width15,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextSheet(
                                jobOrderReplacement.category,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              SizedBox(
                                height: Dimensions.height5,
                              ),
                              TextSheet(
                                jobOrderReplacement.name,
                                fontWeight: FontWeight.bold,
                                color: AppColors.success,
                                fontSize: 13,
                              ),
                              SizedBox(
                                height: Dimensions.height5,
                              ),
                              Wrap(
                                spacing: 5,
                                runSpacing: 0,
                                children: [
                                  CustomChip(
                                    label: RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: "SN Lama ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.textAccent,
                                            ),
                                          ),
                                          TextSpan(
                                            text: jobOrderReplacement.oldSerialNumber,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context).colorScheme.primary,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                  ),
                                  CustomChip(
                                    label: RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: "SN Baru ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.textAccent,
                                            ),
                                          ),
                                          TextSpan(
                                            text: jobOrderReplacement.newSerialNumber,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.success,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    backgroundColor: AppColors.success.lighten(80),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.height5,
                              ),
                              TextSheet(
                                jobOrderReplacement.reason,
                                fontSize: 12,
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextSheet(
                              "${jobOrderReplacement.quantity} pcs",
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            SizedBox(
                              height: Dimensions.height15,
                            ),
                            FilledButton(
                              onPressed: widget.jobFormPageState.widget.readOnly
                                  ? null
                                  : () {
                                setState(() {
                                  field.value!.remove(jobOrderReplacement);
                                });
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.red.lighten(20),
                              ),
                              child: Row(
                                children: [const Icon(Icons.delete), SizedBox(width: Dimensions.width5), const Text("HAPUS")],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
              Visibility(
                visible: field.hasError,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width15,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: AppColors.primaryDark,
                          ),
                          SizedBox(width: Dimensions.width5),
                          Flexible(
                            child: TextSheet(
                              field.errorText ?? "",
                              fontSize: Dimensions.size14,
                              color: AppColors.primaryDark,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
