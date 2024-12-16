import 'package:flutter/material.dart';
import 'package:front_end_instagram/modules/reels/widget/icon_button_text.dart';

class VideoInfoBottomRight extends StatelessWidget {
  const VideoInfoBottomRight({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 10,
      child: Column(
        children: [
          IconButtonText(),
          SizedBox(height: 10),
          IconButtonText(),
          SizedBox(height: 10),
          IconButtonText(),
          SizedBox(height: 10),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_horiz_outlined,
              color: Colors.white,
            ),
          ),
          Container(
            height: 30,
            width: 30,
            color: Colors.black38,
            child: Icon(
              Icons.music_note_outlined,
              color: Colors.white,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
