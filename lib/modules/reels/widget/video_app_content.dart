import 'dart:io';
import 'package:flutter/material.dart';
import 'package:front_end_instagram/providers/video_provider.dart';
import 'package:video_player/video_player.dart';

class VideoAppContent extends StatefulWidget {
  const VideoAppContent({
    super.key,
    this.file,
    required this.autoPlay,
    this.heightVideoY,
  });
  final File? file;
  final bool autoPlay;
  final double? heightVideoY;

  @override
  State<VideoAppContent> createState() => _VideoAppContentState();
}

class _VideoAppContentState extends State<VideoAppContent>
    with WidgetsBindingObserver {
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  final videoProvider = VideoProvider();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addObserver(this); // Agregar el observador del ciclo de vida
    _controller = VideoPlayerController.file(widget.file!);
    _initializeVideoPlayerFuture = _controller?.initialize();
    _controller?.setLooping(true);

    // Si autoPlay es true, comienza a reproducir el video
    if (widget.autoPlay) {
      _playVideo();
    }
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
    return FutureBuilder<void>(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        final vWidth = _controller?.value.size.width;
        final vHeight = _controller?.value.size.height;

        final vHorizontal = vWidth! > vHeight!;
        if (snapshot.connectionState == ConnectionState.done) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: vHorizontal
                ? MediaQuery.of(context).size.height * .35
                : MediaQuery.of(context).size.height,
            child: FittedBox(
              fit: vHorizontal ? BoxFit.fitWidth : BoxFit.cover,
              child: SizedBox(
                height: vHorizontal
                    ? MediaQuery.of(context).size.height * .36
                    : MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: VideoPlayer(_controller!),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void _playVideo() {
    _controller?.play();
  }
}


/*
class VideoAppContent extends StatelessWidget {
  const VideoAppContent({
    super.key,
    required Future<void> future,
    required VideoPlayerController controller,
  }) : _future = future, _controller = controller;

  final Future<void> _future;
  final VideoPlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
 */