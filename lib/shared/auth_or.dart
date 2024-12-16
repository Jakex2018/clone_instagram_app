import 'package:flutter/material.dart';
class AuthOr extends StatelessWidget {
  const AuthOr({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 100,
          height: 2,
          color: Colors.black26,
        ),
        Text('Or'),
        Container(
          width: 100,
          height: 2,
          color: Colors.black26,
        )
      ],
    );
  }
}
