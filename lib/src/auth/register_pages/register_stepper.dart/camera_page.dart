import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:merchant_gerbook_flutter/components/controller/listen.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';

class CameraPageArguments {
  ListenController listenController;
  CameraPageArguments({required this.listenController});
}

class CameraPage extends StatefulWidget {
  static const routeName = '/CameraPage';
  final ListenController listenController;
  const CameraPage({super.key, required this.listenController});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late List<CameraDescription> cameras;
  late final CameraController cameraController;
  int direction = 0;
  String status = 'TAP';
  File? image;
  bool isInitCamera = false;
  @override
  void initState() {
    startCamera(direction);
    super.initState();
    print('====test===');
    print(isInitCamera);
    print('====test===');
  }

  startCamera(int direction) async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameras[direction],
      ResolutionPreset.high,
      enableAudio: false,
    );
    await cameraController.initialize().then((value) {
      setState(() {
        isInitCamera = true;
      });
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isInitCamera == true) {
      return Scaffold(
        floatingActionButton: status == "TAP"
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: white,
                        shape: const CircleBorder(),
                        foregroundColor: const Color(0xff2e3192),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Icon(Icons.arrow_back, color: black),
                    ),
                    Container(
                      padding: const EdgeInsets.all(2),
                      height: 63,
                      width: 63,
                      decoration: BoxDecoration(
                        border: Border.all(color: white, width: 2),
                        shape: BoxShape.circle,
                      ),
                      child: ElevatedButton(
                        clipBehavior: Clip.hardEdge,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff2e3192),
                          shape: const CircleBorder(),
                          foregroundColor: white,
                          padding: const EdgeInsets.all(5),
                        ),
                        onPressed: () {
                          cameraController.takePicture().then((XFile? file) {
                            if (file != null) {
                              setState(() {
                                image = File(file.path);
                                status = "TAPPED";
                              });
                            }
                          });
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: SizedBox(),
                        ),
                      ),
                    ),
                    SizedBox(width: 60),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     setState(() {
                    //       direction == 1 ? direction = 0 : direction = 1;
                    //       startCamera(direction);
                    //     });
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: white,
                    //     shape: const CircleBorder(),
                    //     foregroundColor: const Color(0xff2e3192),
                    //     padding: EdgeInsets.zero,
                    //   ),
                    //   child: const Icon(
                    //     Icons.refresh_rounded,
                    //     color: black,
                    //   ),
                    // ),
                  ],
                ),
              )
            : SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          image = null;
                          status = "TAP";
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: white,
                        shape: const CircleBorder(),
                        foregroundColor: const Color(0xff2e3192),
                        padding: EdgeInsets.zero,
                      ),
                      child: Icon(Icons.close),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        widget.listenController.changeVariable(image!.path);
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: white,
                        shape: const CircleBorder(),
                        foregroundColor: const Color(0xff2e3192),
                        padding: EdgeInsets.zero,
                      ),
                      child: Icon(Icons.check),
                    ),
                  ],
                ),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: status == "TAP"
            ? SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: CameraPreview(cameraController),
              )
            : Container(
                color: black,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.file(image!, fit: BoxFit.contain),
              ),
      );
    } else {
      return Container(
        color: white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      );
    }
  }
}
