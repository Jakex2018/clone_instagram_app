import 'package:flutter/material.dart';
import 'package:front_end_instagram/modules/profile/widget/post_user_grid.dart';

class PostUserTab extends StatefulWidget {
  const PostUserTab({
    super.key,
  });

  @override
  State<PostUserTab> createState() => _PostUserTabState();
}

class _PostUserTabState extends State<PostUserTab> {
  @override
  Widget build(BuildContext context) {
    return PostUserGrid();
  }
}
