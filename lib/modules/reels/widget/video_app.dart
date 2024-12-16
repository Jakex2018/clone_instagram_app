import 'dart:io';
import 'package:flutter/material.dart';
import 'package:front_end_instagram/modules/reels/widget/video_app_content.dart';
import 'package:front_end_instagram/modules/reels/widget/video_info_bottom_left.dart';
import 'package:front_end_instagram/modules/reels/widget/video_info_bottom_right.dart';
import 'package:front_end_instagram/modules/reels/widget/video_info_top.dart';
import 'package:front_end_instagram/providers/video_provider.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  const VideoApp({super.key, required this.url, this.controller});
  final String url;
  final VideoPlayerController? controller;
  @override
  State<VideoApp> createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> with WidgetsBindingObserver {
  VideoPlayerController? _controller;
  late Future<void> future;
  Future<void>? initializeVideoPlayerFuture;
  final videoProvider = VideoProvider();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addObserver(this); // Agregar el observador del ciclo de vida
    _controller = VideoPlayerController.file(File(widget.url));
    initializeVideoPlayerFuture = _controller?.initialize();
    _controller?.setLooping(true);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // Pausa el video cuando la app pasa a segundo plano (cuando el usuario navega a otras secciones)
    if (state == AppLifecycleState.paused) {
      videoProvider.pause();

      ///_pauseVideo();
    }

    // Reanuda el video cuando la app regresa al primer plano
    if (state == AppLifecycleState.resumed) {
      videoProvider.play();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(
        this); // Elimina el observador cuando se destruye el widget
    _controller?.dispose(); // Libera los recursos del controlador de video
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onLongPress: () {
          _controller!.pause();
        },
        onLongPressUp: () {
          _controller!.play();
        },
        child: Container(
          padding: const EdgeInsets.only(top: 24),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Fondo de video
              VideoAppContent(
                file: File(widget.url),
                autoPlay: true,
              ),
              VideoInfoTop(),
              VideoInfoBottomRight(),
              VideoInfoBottomLeft()
            ],
          ),
        ),
      ),
    );
  }
}



/*
import 'package:flutter/material.dart';
import 'package:front_end_instagram/modules/reels/widget/video_app_content.dart';
import 'package:front_end_instagram/modules/reels/widget/video_info_bottom_left.dart';
import 'package:front_end_instagram/modules/reels/widget/video_info_bottom_right.dart';
import 'package:front_end_instagram/modules/reels/widget/video_info_top.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  const VideoApp({super.key, required this.url, this.controller});
  final String url;
  final VideoPlayerController? controller;
  @override
  State<VideoApp> createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
  late Future<void> _future;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller??VideoPlayerController.asset(widget.url);
    _future = _controller.initialize();
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onLongPress: () {
          _controller.pause();
        },
        onLongPressUp: () {
          _controller.play();
        },
        child: Container(
          padding: const EdgeInsets.only(top: 24),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Fondo de video
              VideoAppContent(future: _future, controller: _controller),
              VideoInfoTop(),
              VideoInfoBottomRight(),
              VideoInfoBottomLeft()
            ],
          ),
        ),
      ),
    );
  }
}
 */