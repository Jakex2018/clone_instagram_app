import 'package:flutter/material.dart';

class ButtonOne extends StatelessWidget {
  const ButtonOne(
      {super.key,
      this.onTap,
      required this.widget,
      this.width,
      this.height,
      this.color, this.radius});
  final Function()? onTap;
  final Widget widget;
  final double? width;
  final double? height;
  final Color? color;
  final double?radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: height ?? 0,
          width: width ?? 0,
          
          decoration: BoxDecoration(
            color: color ?? Colors.transparent,
            borderRadius: BorderRadius.circular(radius??0),
          ),
          child: widget,
        ));
  }
}
