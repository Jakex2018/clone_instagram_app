import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/history_model.dart';
import 'package:front_end_instagram/models/user_model.dart';

class HistoryProvider with ChangeNotifier {
  int _currentStoryIndex = 0;

  int get currentStoryIndex => _currentStoryIndex;

  set currentStoryIndex(int value) {
    _currentStoryIndex = value;
    notifyListeners();
  }

  final List<UserModel> users; // Lista de usuarios

  HistoryProvider({required this.users});

  List<Storymodel> getStoriesForUser(String userId) {
    return users
        .firstWhere((user) => user.id == userId)
        .stories
        .where((story) => story != null && story.videoPath.isNotEmpty)
        .cast<Storymodel>()
        .toList();
  }

  void addStory(String videoPath, int duration, String userId) {
    final user = users.firstWhere((user) => user.id == userId);

    // Crear una nueva lista con las historias anteriores y la nueva historia
    user.stories = [
      ...user.stories,
      Storymodel(userId: userId, videoPath: videoPath, duration: duration)
    ];

    notifyListeners();
  }

  void removeStory(Storymodel story, String userId) {
    final user = users.firstWhere((user) => user.id == userId);
    user.stories.remove(story);
    notifyListeners();
  }
}
