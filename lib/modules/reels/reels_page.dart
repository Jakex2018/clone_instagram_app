import 'package:flutter/material.dart';
import 'package:front_end_instagram/providers/reels_provider.dart';
import 'package:front_end_instagram/utils/utils_class.dart';
import 'package:provider/provider.dart';

class ReelsPage extends StatefulWidget {
  const ReelsPage({super.key});

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final reelsProvider = Provider.of<ReelsProvider>(context);
    final reels = reelsProvider.reels;

    if (reels.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            'No hay reels disponibles.',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
      );
    }

    return Scaffold(
        backgroundColor: Colors.black,
        body: PageView.builder(
            scrollDirection: Axis.vertical,
            controller: pageController,
            itemCount: reels.length,
            onPageChanged: (index) {
              if (index > reelsProvider.currentReelIndex) {
                reelsProvider.nextReel();
              } else if (index < reelsProvider.currentReelIndex) {
                reelsProvider.previousReel();
              }
            },
            itemBuilder: (context, index) {
              final reel = reels[index];
              return UtilsClass()
                  .buildImage(reel.videoPath, context, true, true);
            }));
  }
}
