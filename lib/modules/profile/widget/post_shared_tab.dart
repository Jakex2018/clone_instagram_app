import 'package:flutter/material.dart';
import 'package:front_end_instagram/modules/profile/widget/feed_shared.grid.dart';

class PostSharedTab extends StatefulWidget {
  const PostSharedTab({super.key});

  @override
  State<PostSharedTab> createState() => _PostSharedTabState();
}

class _PostSharedTabState extends State<PostSharedTab> {
  @override
  Widget build(BuildContext context) {
    return FeedSharedGrid();
  }
}
