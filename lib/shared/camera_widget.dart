import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:front_end_instagram/shared/camera_button_play.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraWidget extends StatefulWidget {
  const CameraWidget({super.key});

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  bool isLoading = false;
  CameraController? _controller;
  late List<CameraDescription> cameras;

  @override
  void initState() {
    _initializeCameras();
    super.initState();
  }

  Future<void> _initializeCameras() async {
    await Permission.camera.request();
    await Permission.microphone.request();
    await Permission.storage.request();
    cameras = await availableCameras();
    if (cameras.isEmpty) return;
    final camera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _controller = CameraController(camera, ResolutionPreset.high);
    await _controller?.initialize();

    setState(() {
      isLoading = true;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        if (isLoading)
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: CameraPreview(_controller!),
          ),
        Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.highlight_remove_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.flash_off_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            )),
        if (_controller != null)
          CameraButtonPlay(cameraController: _controller!)
      ]),
    );
  }
}
