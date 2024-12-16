class Reelsmodel {
  final String videoPath;
  final int duration;
  double progress;
  final String? userId;

  Reelsmodel(
      {this.userId, required this.videoPath, required this.duration})
      : progress = 0.0;

  @override
  String toString() {
    return 'Reelsmodel(videoPath: $videoPath, duration: $duration, progress: $progress)';
  }
}
