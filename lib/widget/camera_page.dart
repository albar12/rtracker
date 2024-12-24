import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rtracker/helper/navigators.dart';
import 'package:rtracker/widget/camera_preview_page.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription>? cameraDescriptions;
  final void Function(Uint8List bytes) callback;

  const CameraPage({
    Key? key,
    required this.cameraDescriptions,
    required this.callback,
  }) : super(key: key);

  @override
  State<CameraPage> createState() => CameraPageState();
}

class CameraPageState extends State<CameraPage> {
  bool holdCamera = false;
  bool rearCameraSelected = true;
  bool flashOn = false;

  late CameraController cameraController;

  double _zoomLevel = 1.0; // Initial zoom level
  double minZoomLevel = 1.0;
  double maxZoomLevel = 10.0;

  @override
  void initState() {
    super.initState();
    getZoomLevel();
    initCamera(widget.cameraDescriptions![0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            body(),
            Visibility(
              visible: holdCamera,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: const Text(
                    "Tahan Posisi Kamera",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.20,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  color: Colors.black,
                ),
                child: Column(
                  children: [
                    Slider(
                      thumbColor: Colors.white,
                      inactiveColor: Colors.white,
                      value: _zoomLevel,
                      min: minZoomLevel,
                      max: maxZoomLevel,
                      onChanged: _setZoomLevel,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 30,
                            icon: Icon(
                              rearCameraSelected
                                  ? Icons.switch_camera
                                  : Icons.switch_camera_outlined,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(
                                () => rearCameraSelected = !rearCameraSelected,
                              );

                              setState(() {
                                flashOn = false;
                              });

                              initCamera(
                                widget.cameraDescriptions![
                                    rearCameraSelected ? 0 : 1],
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: takePicture,
                            iconSize: 50,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(
                              Icons.circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () async {
                              if (flashOn == false) {
                                await cameraController
                                    .setFlashMode(FlashMode.torch);
                                setState(() {
                                  flashOn = true;
                                });
                              } else {
                                await cameraController
                                    .setFlashMode(FlashMode.off);
                                setState(() {
                                  flashOn = false;
                                });
                              }
                            },
                            iconSize: 50,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: flashOn
                                ? const Icon(
                                    Icons.flash_on,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.flash_off,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                        // const Spacer()
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();

    super.dispose();
  }

  Widget body() {
    if (cameraController.value.isInitialized) {
      return CameraPreview(cameraController);
    } else {
      return Container(
        color: Colors.black,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
  }

  Future takePicture() async {
    if (!cameraController.value.isInitialized) {
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      return null;
    }

    try {
      setState(() {
        holdCamera = true;
      });

      if (flashOn == false) {
        await cameraController.setFlashMode(FlashMode.off);
      }

      cameraController.setFocusMode(FocusMode.locked);
      // cameraController.setExposureMode(ExposureMode.locked);

      XFile xFile = await cameraController.takePicture();

      Uint8List bytesFile = Uint8List.fromList(
        await xFile.readAsBytes(),
      );

      Uint8List compressedBytes = await FlutterImageCompress.compressWithList(
        bytesFile,
        quality: 97,
      );

      Navigators.pushReplacement(
        context,
        CameraPreviewPage(
          bytes: compressedBytes,
          // bytes: bytesFile,
          cameraDescriptions: widget.cameraDescriptions,
          callback: widget.callback,
        ),
      );
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');

      return null;
    } finally {
      setState(() {
        holdCamera = false;
      });
    }
  }

  Future initCamera(CameraDescription cameraDescription) async {
    cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await cameraController.initialize().then((_) {
        if (!mounted) return;

        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  void _setZoomLevel(double level) {
    setState(() {
      _zoomLevel = level;
    });
    cameraController.setZoomLevel(level);
  }

  Future<void> getZoomLevel() async {
    maxZoomLevel = await cameraController.getMaxZoomLevel();
    minZoomLevel = await cameraController.getMinZoomLevel();
    setState(() {});
  }
}
