import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/post_model.dart';
import 'package:front_end_instagram/modules/post/widget/explore_page.dart';
import 'package:front_end_instagram/providers/auth_provider.dart';
import 'package:front_end_instagram/providers/post_provider.dart';
import 'package:front_end_instagram/providers/user_provider.dart';
import 'package:front_end_instagram/utils/utils_class.dart';
import 'package:provider/provider.dart';

class FeedSharedGrid extends StatelessWidget {
  const FeedSharedGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final postProvider = Provider.of<PostProvider>(context);
    final userId = authProvider.currentUserId?.id;
    final user = userProvider.getUserById(userId!);
    final postId = user?.postsShared.first;
    List<Postmodel> filteredPosts = _getFilteredPosts(postProvider, postId);

    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2),
        itemBuilder: (context, index) {
          final post = filteredPosts[index];
          final imageUrl = post.imageUrl;
          return GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ExplorePage(post: post),
                ),
              );
            },
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: UtilsClass().buildImage(imageUrl, context,false,false)),
          );
        },
        itemCount: filteredPosts.length);
  }

  List<Postmodel> _getFilteredPosts(PostProvider postProvider, postId) {
    if (postId != null) {
      return postProvider.posts.where((post) => post.id == postId).toList();
    } else {
      return postProvider.posts;
    }
  }
}
