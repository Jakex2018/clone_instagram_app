import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/user_model.dart';
import 'package:front_end_instagram/shared/image_container.dart';

class ImageAddReel extends StatelessWidget {
  const ImageAddReel({
    super.key,
    this.user,
  });

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ImageContainer(
        imageContent: user!.photoUser,
        radius: 45,
        height: 80,width: 80,
      ),
      Positioned(
        bottom: -12,
        right: -10,
        child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add_circle_sharp,
              color: Colors.blue,
            )),
      )
    ]);
  }
}
