import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppPageMenu extends StatelessWidget {
  const AppPageMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            'asset/vector/ins_logo.svg',
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_outline_rounded,
                    color: Colors.white,
                    size: 25,
                  )),
              Stack(children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.send_outlined,
                      color: Colors.white,
                      size: 25,
                    )),
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    height: 18,
                    width: 18,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                        child: Text(
                      '6',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                )
              ]),
            ],
          )
        ],
      ),
    );
  }
}
