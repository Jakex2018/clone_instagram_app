import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ButtonImage extends StatelessWidget {
  const ButtonImage({
    super.key,
    this.onPressed,
  });
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          'asset/vector/save.svg',
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }
}

final String imageUser =
    'https://media.istockphoto.com/id/536988396/photo/confident-man-in-blue-sweater-portrait.jpg?s=612x612&w=0&k=20&c=Ww3dK11KMRuru6mqddVQ29u0XZxvq_dFghN2Ta6OCN4=';
