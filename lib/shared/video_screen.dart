import 'dart:io';
import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/reels_model.dart';
import 'package:front_end_instagram/modules/application/application_page.dart';
import 'package:front_end_instagram/modules/reels/widget/video_app_content.dart';
import 'package:front_end_instagram/providers/auth_provider.dart';
import 'package:front_end_instagram/providers/history_provider.dart';
import 'package:front_end_instagram/providers/reels_provider.dart';
import 'package:front_end_instagram/providers/select_option_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key, required this.videoPath});
  final String videoPath;

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  late Future<void> future;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.file(File(widget.videoPath));
    future = _controller.initialize().then((_) {
      setState(() {});
      _controller.setLooping(true);
      _controller.play();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<HistoryProvider>(context);
    final reelsProvider = Provider.of<ReelsProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final userId = authProvider.currentUserId?.id;

    final selectedOption =
        Provider.of<SelectOptionProvider>(context).selectedOption;

    if (widget.videoPath.isEmpty) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: Text(
                'No hay video',
                style: TextStyle(color: Colors.black, fontSize: 24),
              ))));
    }

    return Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    VideoAppContent(
                      file: File(widget.videoPath),
                      autoPlay: true,
                    ),
                    Positioned(
                      top: 24,
                      left: 10,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: 28,
                            color: Colors.white,
                          )),
                    ),
                    Positioned(
                        bottom: 20,
                        right: 20,
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueAccent),
                              child: IconButton(
                                  onPressed: () {
                                    int duration =
                                        _controller.value.duration.inSeconds;
                                    if (selectedOption == 'HISTORIA') {
                                      historyProvider.addStory(
                                          widget.videoPath, duration, userId!);
                                    } else if (selectedOption == 'REEL') {
                                      reelsProvider.addReel(Reelsmodel(
                                          videoPath: widget.videoPath,
                                          duration: duration));
                                    }

                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ApplicationPage(),
                                        ));
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ))),
                        ))
                  ],
                ),
              ],
            )));
  }
}


/*
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key, required this.videoPath});
  final String videoPath;

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController? _controller;
  late Future<void> _future;
  late File fileDoc = File(widget.videoPath);
  bool isInitialized = false;
  @override
  void initState() {
    super.initState();
    _future = _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      _initializeVideoPlayer();
    } else {
      print('Permiso de almacenamiento denegado');
    }
  }

  Future<void> _initializeVideoPlayer() async {
    if (await fileDoc.exists()) {
      _controller = VideoPlayerController.file(fileDoc)
        ..initialize().then((_) {
          setState(() {
            isInitialized = true; // Cambiar el estado cuando se inicialice
          });
          _controller?.setLooping(true);
          _controller?.play();
        });
    } else {
      print('El archivo de video no existe en la ruta especificada.');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: MediaQuery.of(context).size.height * .5,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder<void>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(_controller!));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }
}

 */