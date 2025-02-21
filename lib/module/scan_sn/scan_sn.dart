import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:rtracker/helper/dimensions.dart';
import 'package:rtracker/helper/navigators.dart';
import 'package:rtracker/module/scan_sn/scan_sn_bloc/scan_sn_bloc.dart';
import 'package:rtracker/widget/custom_menu.dart';
import 'package:rtracker/widget/text_sheet.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key, required this.onSubmitted}) : super(key: key);
  final Function(String) onSubmitted;

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  ScanSnBloc bloc = ScanSnBloc();
  ScanSnBloc displaySnBloc = ScanSnBloc();

  @override
  void initState() {
    super.initState();
  }

  MobileScannerArguments? arguments;
  MobileScannerController? controller;

  ScanType? scanType;
  bool _process = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (controller != null) {
      controller!.dispose();
    }
    bloc.close();
    displaySnBloc.close();
  }

  void submitScan(Barcode barcode) {
    if (barcode.displayValue != null) {
      widget.onSubmitted(
        barcode.displayValue!,
      );
      Navigators.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MultiBlocListener(
        listeners: [
          BlocListener(
            bloc: bloc,
            listener: (context, state){
              if (state is ScanSelected){
                scanType = state.scanType;
              }
            },
          ),
          BlocListener(
            bloc: displaySnBloc,
            listener: (context, state){
              if (state is BarcodeCaptured){
                submitScan(state.barcode);
              }
            },
          ),
        ],
        child: Builder(
          builder: (context) {
            controller = MobileScannerController();
            return BlocBuilder(
              bloc: bloc,
              builder: (context, state) {
                if (state is ScanSelected){
                  final scanWindow = Rect.fromCenter(
                    center: MediaQuery.of(context).size.center(Offset.zero),
                    width: state.scanType == ScanType.qrCode ? 200 : 400,
                    height: state.scanType == ScanType.qrCode ? 200 : 80,
                  );
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      MobileScanner(
                        fit: BoxFit.contain,
                        scanWindow: scanWindow,
                        controller: controller,
                        onScannerStarted: (arguments){
                          if (arguments != null) {
                            this.arguments = arguments;
                          }
                        },
                        onDetect: (capture) {
                          if (!_process) {
                            _process = true;
                            for (final barcode in capture.barcodes) {
                              print(
                                  "SN : ${barcode.displayValue!} - Type : ${barcode.format}");
                              if (scanType == ScanType.qrCode) {
                                if (barcode.format == BarcodeFormat.qrCode) {
                                  // Select this
                                  displaySnBloc
                                      .add(DisplayBarcode(barcode, capture));
                                  // submitScan(barcode);
                                  break;
                                }
                              } else {
                                if (barcode.format != BarcodeFormat.qrCode) {
                                  // Select this
                                  displaySnBloc
                                      .add(DisplayBarcode(barcode, capture));
                                  // submitScan(barcode);
                                  break;
                                }
                              }
                            }
                          }
                        },
                      ),
                      BlocBuilder(
                        bloc: displaySnBloc,
                        builder: (context, state){
                          if (state is DisplayBarcode){
                            return CustomPaint(
                              painter: BarcodeOverlay(
                                barcode: state.barcode,
                                arguments: arguments!,
                                boxFit: BoxFit.contain,
                                capture: state.barcodeCapture,
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      CustomPaint(
                        painter: ScannerOverlay(scanWindow),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          height: 100,
                          color: Colors.black.withOpacity(0.4),
                          child: Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 120,
                                height: 50,
                                child: FittedBox(
                                  child: BlocBuilder(
                                    bloc: displaySnBloc,
                                    builder: (context, state) {
                                      if (state is BarcodeCaptured){
                                        return Text(
                                          state.barcode.displayValue!,
                                          overflow: TextOverflow.fade,
                                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white),
                                        );
                                      } else {
                                        return Text(
                                          'Silahkan lakukan scan',
                                          overflow: TextOverflow.fade,
                                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                              BlocBuilder(
                                bloc: displaySnBloc,
                                builder: (context, state) {
                                  if (state is BarcodeCaptured){
                                    return ElevatedButton(
                                      onPressed: () {
                                        if (state.barcode.displayValue != null) {
                                          widget.onSubmitted(
                                            state.barcode.displayValue!,
                                          );
                                          Navigators.pop(context);
                                        }
                                      },
                                      child: const TextSheet('Submit'),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 40,
                        right: 10,
                        child: Container(
                          alignment: Alignment.topRight,
                          height: 100,
                          child: Row(
                            children: [
                              TextSheet(
                                state.scanType == ScanType.qrCode ? "QR Code" : "Barcode",
                                color: Colors.white,
                              ),
                              SizedBox(width: Dimensions.width5),
                              ElevatedButton(
                                onPressed: (){
                                  if (state.scanType == ScanType.qrCode){
                                    bloc.add(ChooseType(ScanType.barcode));
                                  } else {
                                    bloc.add(ChooseType(ScanType.qrCode));
                                  }
                                },
                                child: TextSheet(
                                  "Ganti ${state.scanType == ScanType.qrCode ? "Barcode" : "QR Code"}",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 40,
                        left: 10,
                        child: IconButton(
                          onPressed: () {
                            Navigators.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        menu(
                          color: const Color(0xff219653),
                          onTap: () {
                            bloc.add(ChooseType(ScanType.barcode));
                          },
                          iconData: Icons.qr_code_scanner_outlined,
                          name: "Barcode",
                        ),
                        SizedBox(height: Dimensions.height5),
                        menu(
                          color: const Color(0xff2F80ED),
                          onTap: () {
                            bloc.add(ChooseType(ScanType.qrCode));
                          },
                          iconData: Icons.qr_code_2_outlined,
                          name: "QR Code",
                        ),
                        SizedBox(height: Dimensions.height5),
                        menu(
                          color: const Color(0xffEB5757),
                          onTap: () {
                            Navigator.pop(context);
                          },
                          iconData: Icons.arrow_back_outlined,
                          name: "Batal",
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class ScannerOverlay extends CustomPainter {
  ScannerOverlay(this.scanWindow);

  final Rect scanWindow;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()..addRect(Rect.largest);
    final cutoutPath = Path()..addRect(scanWindow);

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );
    canvas.drawPath(backgroundWithCutout, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class BarcodeOverlay extends CustomPainter {
  BarcodeOverlay({
    required this.barcode,
    required this.arguments,
    required this.boxFit,
    required this.capture,
  });

  final BarcodeCapture capture;
  final Barcode barcode;
  final MobileScannerArguments arguments;
  final BoxFit boxFit;

  @override
  void paint(Canvas canvas, Size size) {
    if (barcode.corners == null) return;
    final adjustedSize = applyBoxFit(boxFit, arguments.size, size);

    double verticalPadding = size.height - adjustedSize.destination.height;
    double horizontalPadding = size.width - adjustedSize.destination.width;
    if (verticalPadding > 0) {
      verticalPadding = verticalPadding / 2;
    } else {
      verticalPadding = 0;
    }

    if (horizontalPadding > 0) {
      horizontalPadding = horizontalPadding / 2;
    } else {
      horizontalPadding = 0;
    }

    final ratioWidth = (Platform.isIOS ? capture.width! : arguments.size.width) / adjustedSize.destination.width;
    final ratioHeight = (Platform.isIOS ? capture.height! : arguments.size.height) / adjustedSize.destination.height;

    final List<Offset> adjustedOffset = [];
    for (final offset in barcode.corners!) {
      adjustedOffset.add(
        Offset(
          offset.dx / ratioWidth + horizontalPadding,
          offset.dy / ratioHeight + verticalPadding,
        ),
      );
    }
    final cutoutPath = Path()..addPolygon(adjustedOffset, true);

    final backgroundPaint = Paint()
      ..color = Colors.red.withOpacity(0.3)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    canvas.drawPath(cutoutPath, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
