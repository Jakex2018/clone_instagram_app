import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoProvider extends ChangeNotifier {
  String? _video;
  int? _duration;
  bool _isPlaying = false;

  int? get duration => _duration;
  String? get video => _video;

  VideoPlayerController? _controller;

  VideoPlayerController? get controller => _controller;
  bool get isPlaying => _isPlaying;

  void updateVideo(String videoPath, int duration) {
    _video = videoPath;
    _duration = duration;
    notifyListeners();
  }

  // Inicializa el controlador de video
  void setVideo(File file) {
    _controller = VideoPlayerController.file(file);
    _controller?.initialize().then((_) {
      _controller?.setLooping(true);
      notifyListeners();
    });
  }

  void play() {
    _controller?.play();
    _isPlaying = true;
    notifyListeners();
  }

  void pause() {
    _controller?.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // Detener el controlador de video
  void disposeController() {
    _controller?.dispose();
    _controller = null;
    notifyListeners();
  }

  // Función para pausar o reanudar el video
  void setPlayingState(bool isPlaying) {
    if (isPlaying) {
      play();
    } else {
      pause();
    }
  }
}
