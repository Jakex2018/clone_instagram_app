import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPostContent extends StatefulWidget {
  const VideoPostContent({
    super.key,
    this.file,
    required this.autoPlay,
  });
  final File? file;
  final bool autoPlay;

  @override
  State<VideoPostContent> createState() => _VideoPostContentState();
}

class _VideoPostContentState extends State<VideoPostContent>
    with WidgetsBindingObserver {
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Inicializar el controlador de video con el archivo
    _controller = VideoPlayerController.file(widget.file!);
    _initializeVideoPlayerFuture = _controller?.initialize();
    _controller?.setLooping(true);
    if (widget.autoPlay) {
      _playVideo();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Pausa el video cuando la app pasa a segundo plano
    if (state == AppLifecycleState.paused) {
      _pauseVideo();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Elimina el observador
    _controller?.dispose(); // Libera los recursos del controlador de video
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height:100,
            child: SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: VideoPlayer(_controller!),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void _pauseVideo() {
    _controller?.pause();
  }

  void _playVideo() {
    _controller?.play();
  }
}
