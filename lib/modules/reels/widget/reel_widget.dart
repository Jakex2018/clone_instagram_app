import 'package:flutter/material.dart';
import 'package:front_end_instagram/shared/public_widget.dart';
import 'package:photo_manager/photo_manager.dart';

class ReelWidget extends StatelessWidget {
  const ReelWidget(
      {super.key,
      required this.albumList,
      required this.assetList,
      required this.selectAssetList,
      this.selectedAlbum});
  final List<AssetPathEntity> albumList;
  final List<AssetEntity> assetList;
  final List<AssetEntity> selectAssetList;
  final AssetPathEntity? selectedAlbum;

  @override
  Widget build(BuildContext context) {
    return PublicWidget(
      reel: true,
      albumList: albumList,
      assetList: assetList,
      selectAssetList: selectAssetList,
      selectedAlbum: selectedAlbum,
    );
  }
}

















/*
class ReelWidget extends StatefulWidget {
  const ReelWidget({super.key});

  @override
  State<ReelWidget> createState() => _ReelWidgetState();
}

class _ReelWidgetState extends State<ReelWidget> {
  bool isLoading = false;
  bool isRecording = false; // Estado de grabación
  CameraController? _controller;
  late List<CameraDescription> cameras;
  XFile? _videoFile; // Archivo de video grabado
  VideoPlayerController?
      _videoPlayerController; // Controlador de video para mostrar vista previa

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

  // Iniciar grabación de video
  Future<void> _startRecording() async {
    if (_controller != null && !_controller!.value.isRecordingVideo) {
      try {
        setState(() {
          isRecording = true;
        });
        await _controller!.startVideoRecording();
      } catch (e) {
        print('Error al iniciar la grabación: $e');
      }
    }
  }

  // Detener grabación de video
  Future<void> _stopRecording() async {
    if (_controller != null && _controller!.value.isRecordingVideo) {
      try {
        final file = await _controller!.stopVideoRecording();
        setState(() {
          isRecording = false;
          _videoFile = file;
        });
        _initializeVideoPlayer();
      } catch (e) {
        print('Error al detener la grabación: $e');
      }
    }
  }

  // Inicializar el reproductor de video para vista previa
  Future<void> _initializeVideoPlayer() async {
    if (_videoFile != null) {
      _videoPlayerController = VideoPlayerController.file(
        File(_videoFile!.path),
      )..initialize().then((_) {
          setState(() {});
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _videoPlayerController?.dispose();
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
              SizedBox(width: 30),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.flash_off_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              SizedBox(width: 30),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.settings_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
        if (_controller != null)
          Positioned(
            bottom: 50,
            left: MediaQuery.of(context).size.width * 0.4,
            child: IconButton(
              icon: Icon(
                isRecording ? Icons.stop : Icons.videocam,
                color: Colors.red,
                size: 60,
              ),
              onPressed: () {
                if (isRecording) {
                  _stopRecording();
                } else {
                  _startRecording();
                }
              },
            ),
          ),
        // Si hay un video grabado, mostrar vista previa
        if (_videoFile != null)
          Positioned(
            bottom: 120,
            left: MediaQuery.of(context).size.width * 0.2,
            child: SizedBox(
              width: 100,
              height: 100,
              child: _videoPlayerController != null &&
                      _videoPlayerController!.value.isInitialized
                  ? VideoPlayer(_videoPlayerController!)
                  : CircularProgressIndicator(),
            ),
          ),
      ]),
    );
  }
}

 */






/*

class ReelWidget extends StatelessWidget {
  const ReelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: Center(
        child: Text(
          'Aquí va el reel',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
 */