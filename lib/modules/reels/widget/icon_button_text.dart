import 'package:flutter/material.dart';
class IconButtonText extends StatelessWidget {
  const IconButtonText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_border_outlined,
              color: Colors.white,
            )),
        Text(
          '1.689',
          style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}