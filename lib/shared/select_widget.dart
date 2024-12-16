import 'package:flutter/material.dart';

class LiveStreamWidget extends StatelessWidget {
  const LiveStreamWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: Center(
        child: Text(
          'Aquí va el directo',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
