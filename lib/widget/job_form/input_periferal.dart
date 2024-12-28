// ignore_for_file: invalid_use_of_protected_member

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:rtracker/helper/bottom_sheets.dart";
import "package:rtracker/helper/dialogs.dart";
import "package:rtracker/helper/dimensions.dart";
import "package:rtracker/helper/extensions.dart";
import "package:rtracker/helper/strings.dart";
import "package:rtracker/module/job_form/job_form_page.dart";
import "package:rtracker/module/job_form/thermal_count_bloc/thermal_count_bloc.dart";
import "package:rtracker/realm/non_sn_stock_dao.dart";
import "package:rtracker/realm/realms.dart";
import "package:rtracker/realm/schemas.dart";
import "package:rtracker/realm/service_point_dao.dart";
import "package:rtracker/widget/text_sheet.dart";

import "../information/dual_information.dart";

class InputPeriferal extends StatefulWidget {
  final JobFormPageState jobFormPageState;

  const InputPeriferal({
    Key? key,
    required this.jobFormPageState,
  }) : super(key: key);

  @override
  State<InputPeriferal> createState() => InputPeriferalState();
}

class InputPeriferalState extends State<InputPeriferal> with AutomaticKeepAliveClientMixin {
  List<JobOrderInputPeripheral> jobOrderInputPeripherals = [];

  @override
  void initState() {
    super.initState();

    for (JobOrderInputPeripheral jobOrderInputPeripheral in widget.jobFormPageState.widget.jobOrder.inputPeripherals) {
      jobOrderInputPeripherals.add(jobOrderInputPeripheral);
    }
    updateThermalCount();
  }

  void updateThermalCount() {
    context.read<ThermalCountBloc>().add(UpdateThermalCount(jobOrderInputPeripherals));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FormField<List<JobOrderInputPeripheral>?>(
      validator: (value) {
        return null;
      },
      initialValue: jobOrderInputPeripherals,
      onSaved: (value) {},
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: !Strings.equalsAny(
                widget.jobFormPageState.widget.jobOrder.jobType!.id,
                ["21","18"],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.height10,
                  horizontal: Dimensions.height15,
                ),
                child: BlocBuilder<ThermalCountBloc, ThermalCountState>(
                  builder: (context, state) {
                    if (state is ThermalCountInitial){
                      String displayRequired = "0";
                      String? inputRequired = widget.jobFormPageState.widget.jobOrder.requiredThermalCount;
                      if (inputRequired != null){
                        if (inputRequired.isNotEmpty){
                          displayRequired = inputRequired;
                        }
                      }
                      return DualInformation(
                        firstTitle: 'THERMAL DIBUTUHKAN',
                        firstSubtitle: displayRequired,
                        secondTitle: 'THERMAL DIBERIKAN',
                        secondSubtitle: state.total.toString(),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
            Visibility(
              visible: !Strings.equalsAny(
                widget.jobFormPageState.widget.jobOrder.jobType!.id,
                ["21","18"],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: Dimensions.width15,
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
                          BottomSheets.addInputPeripheral(
                            context: context,
                            jobOrder: widget.jobFormPageState.widget.jobOrder,
                            onSelected: (jobOrderInputPeripheral) {
                              for (JobOrderInputPeripheral jobOrderInputPeripheralCheck in field.value!) {
                                if (jobOrderInputPeripheralCheck.productName == jobOrderInputPeripheral.productName) {
                                  Dialogs.message(
                                    context: context,
                                    title: "Data dengan produk yang sama sudah ada.",
                                  );

                                  return;
                                }
                              }

                              setState(() {
                                Realms.get().write(() {
                                  NonSnStockDao.decreaseQuantity(
                                    id: jobOrderInputPeripheral.id,
                                    quantity: jobOrderInputPeripheral.quantity,
                                    servicePointId: widget.jobFormPageState.widget.jobOrder.servicePoint!.id,
                                  );

                                  widget.jobFormPageState.widget.jobOrder.inputPeripherals.add(jobOrderInputPeripheral);

                                  field.value!.add(jobOrderInputPeripheral);
                                });
                              });
                              updateThermalCount();
                            },
                          );
                        },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      SizedBox(
                        width: 10,
                      ),
                      TextSheet("TAMBAH INPUT PERIFERAL"),
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
                JobOrderInputPeripheral jobOrderInputPeripheral = field.value![index];

                return Container(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  padding: EdgeInsets.all(
                    Dimensions.width15,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextSheet(
                              jobOrderInputPeripheral.productName,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            SizedBox(
                              height: Dimensions.height5,
                            ),
                            TextSheet(
                              jobOrderInputPeripheral.category,
                              fontSize: 13,
                            ),
                            SizedBox(
                              height: Dimensions.height5,
                            ),
                            TextSheet(
                              ServicePointDao.name(
                                jobOrderInputPeripheral.servicePoint,
                              ),
                              fontSize: 13,
                            )
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextSheet(
                            "${jobOrderInputPeripheral.quantity} pcs",
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
                                      Realms.get().write(() {
                                        NonSnStockDao.increaseQuantity(
                                          id: jobOrderInputPeripheral.id,
                                          quantity: jobOrderInputPeripheral.quantity,
                                          servicePointId: widget.jobFormPageState.widget.jobOrder.servicePoint!.id,
                                        );

                                        widget.jobFormPageState.widget.jobOrder.inputPeripherals.remove(jobOrderInputPeripheral);

                                        field.value!.remove(jobOrderInputPeripheral);
                                      });
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
            )
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
