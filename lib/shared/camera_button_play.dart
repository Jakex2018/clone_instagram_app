// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:front_end_instagram/providers/video_provider.dart';
import 'package:front_end_instagram/shared/video_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class CameraButtonPlay extends StatefulWidget {
  const CameraButtonPlay({
    super.key,
    required this.cameraController,
  });
  final CameraController cameraController;

  @override
  State<CameraButtonPlay> createState() => _CameraButtonPlayState();
}

class _CameraButtonPlayState extends State<CameraButtonPlay> {
  CameraController? _controller;
  late List<CameraDescription> cameras;
  bool _isRecording = false;
  double _recordingProgress = 0.0;
  late Stopwatch _stopwatch;
  String? videoPath;
  double _zoomLevel = 1.0;

  @override
  void initState() {
    super.initState();
    _controller = widget.cameraController;
    _stopwatch = Stopwatch();
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      // Detener la grabación
      final videoData = await _controller?.stopVideoRecording();
      final videoBytes = await videoData?.readAsBytes();

      if (videoBytes != null) {
        final directory = await getTemporaryDirectory();
        final dirPath =
            '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';
        final dirFile = File(dirPath);

        await dirFile.writeAsBytes(videoBytes);

        Provider.of<VideoProvider>(context, listen: false)
            .setVideo(File(dirPath));

        setState(() {
          _isRecording = false;
          _stopwatch.stop();
          _stopwatch.reset();
          _recordingProgress = 0.0;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VideoScreen(videoPath: dirPath)),
        );
      }
    } else {
      await _controller?.startVideoRecording();

      setState(() {
        _isRecording = true;
      });

      _stopwatch.start();
      _updateProgress();
    }
  }

  void _updateProgress() {
    if (_isRecording) {
      Future.delayed(Duration(milliseconds: 100), () {
        if (_isRecording) {
          setState(() {
            _recordingProgress =
                _stopwatch.elapsedMilliseconds / 30000; // Máximo de 10 segundos
          });
          _updateProgress();
        }
      });
    }
  }

  void _onVerticalZoom(DragUpdateDetails details) {
    setState(() {
      double zoomChange = details.primaryDelta! / 1000;
      _zoomLevel = (_zoomLevel - zoomChange).clamp(1.0, 5.0);
    });
    if (_controller != null) {
      _controller?.setZoomLevel(_zoomLevel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 90,
        left: 130,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              top: 0,
              child: CircularProgressIndicator(
                value: _recordingProgress,
                strokeWidth: 6,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
            GestureDetector(
              onLongPress: _toggleRecording,
              onLongPressEnd: (details) {
                _toggleRecording();
              },
              onVerticalDragUpdate: (details) {
                if (_isRecording) {
                  _onVerticalZoom(
                      details); // Permitir zoom durante la grabación
                }
              },
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Container(
                  height: 50,
                  width: 50,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
