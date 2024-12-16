import 'package:flutter/material.dart';

class VideoInfoTop extends StatelessWidget {
  const VideoInfoTop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reels',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.linked_camera_outlined,
                    color: Colors.white,
                  )),
            ],
          ),
        ));
  }
}
