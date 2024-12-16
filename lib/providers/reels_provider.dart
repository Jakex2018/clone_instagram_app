import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/reels_model.dart';

class ReelsProvider extends ChangeNotifier {
  final List<Reelsmodel> _reels = [];
  List<Reelsmodel> get reels => _reels;

  int _currentReelIndex = 0;
  int get currentReelIndex => _currentReelIndex;

  void setReelIndex(int index) {
    _currentReelIndex = index;
    notifyListeners();
  }

  void nextReel() {
    if (currentReelIndex < reels.length - 1) {
      _currentReelIndex++;
    } else {
      _currentReelIndex = 0;
    }
    notifyListeners();
  }

  // Cambiar al reel anterior
  void previousReel() {
    if (currentReelIndex > 0) {
      _currentReelIndex--;
    } else {
      _currentReelIndex = reels.length - 1;
    }
    notifyListeners();
  }

  void addReel(Reelsmodel reel) {
    _reels.add(reel);
    notifyListeners();
  }

  void removeReel(Reelsmodel reel) {
    _reels.remove(reel);
    notifyListeners();
  }
}
