class Storymodel {
  final String videoPath;
  final String userId;

  final int duration;
  double progress;

  Storymodel(
      {required this.userId, required this.videoPath, required this.duration})
      : progress = 0.0;

  @override
  String toString() {
    return 'Storymodel(videoPath: $videoPath, duration: $duration, progress: $progress)';
  }
}
