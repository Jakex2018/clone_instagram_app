import 'package:flutter/material.dart';
import 'package:front_end_instagram/shared/feed_user_grid.dart';

class SearchContent extends StatelessWidget {
  const SearchContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black,
      child: FeedUserGrid(),
    );
  }
}
