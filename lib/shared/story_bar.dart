// ignore_for_file: library_private_types_in_public_api
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/history_model.dart';
import 'package:front_end_instagram/models/user_model.dart';

class StoryBar extends StatefulWidget {
  final Storymodel story;
  final bool isFirstStoryCompleted;
  final VoidCallback onStoryComplete;
  final UserModel? user;

  const StoryBar({
    super.key,
    required this.story,
    required this.isFirstStoryCompleted,
    required this.onStoryComplete,
    this.user,
  });

  @override
  _StoryBarState createState() => _StoryBarState();
}

class _StoryBarState extends State<StoryBar> {
  Timer? _timer;
  int elapsedTime = 0;

  @override
  void initState() {
    super.initState();

    // Iniciar el temporizador solo si la historia es la actual
    if (widget.isFirstStoryCompleted) {
      _startStoryTimer();
    }
  }

  void _startStoryTimer() {
    final durationInMilliseconds = widget.story.duration * 1000;

    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        elapsedTime += 50;
        widget.story.progress = elapsedTime / durationInMilliseconds;
      });

      if (elapsedTime >= durationInMilliseconds) {
        _timer?.cancel();
        widget
            .onStoryComplete(); // Llamamos a onStoryComplete cuando la historia termine
      }
    });
  }

  @override
  void didUpdateWidget(covariant StoryBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Si la historia actual no era la misma, reiniciar el temporizador
    if (widget.isFirstStoryCompleted &&
        oldWidget.isFirstStoryCompleted != widget.isFirstStoryCompleted) {
      setState(() {
        elapsedTime = 0; // Reiniciamos el tiempo
      });
      _startStoryTimer(); // Volver a iniciar el temporizador
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalStories = widget.user?.stories.length ?? 0;

    final double storyW = totalStories > 1
        ? MediaQuery.of(context).size.width / totalStories
        : MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Container(
        width: storyW,
        height: 6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey[300],
        ),
        child: Stack(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 50),
              width: widget.story.progress * storyW,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*
class StoryBar extends StatefulWidget {
  final Storymodel story;
  final bool isFirstStoryCompleted;
  final VoidCallback onStoryComplete;

  const StoryBar(
      {super.key,
      required this.story,
      required this.isFirstStoryCompleted,
      required this.onStoryComplete});

  @override
  _StoryBarState createState() => _StoryBarState();
}

class _StoryBarState extends State<StoryBar> {
  Timer? _timer;
  int elapsedTime = 0;

  @override
  void initState() {
    super.initState();

    // Iniciar el temporizador solo si la historia es la actual
    if (widget.isFirstStoryCompleted) {
      _startStoryTimer();
    }
  }

  void _startStoryTimer() {
    final durationInMilliseconds = widget.story.duration * 1000;

    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        elapsedTime += 50;
        widget.story.progress = elapsedTime / durationInMilliseconds;
      });

      if (elapsedTime >= durationInMilliseconds) {
        _timer?.cancel();
        widget
            .onStoryComplete(); // Llamamos a onStoryComplete cuando la historia termine
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<HistoryProvider>(context);
    final totalStories = historyProvider.stories.length;

    final double storyW = totalStories > 1
        ? MediaQuery.of(context).size.width / totalStories
        : MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: storyW,
        height: 6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey[300],
        ),
        child: Stack(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 50),
              width: widget.story.progress * storyW,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

 */