import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/post_model.dart';
import 'package:front_end_instagram/modules/post/widget/explore_page.dart';
import 'package:front_end_instagram/providers/auth_provider.dart';
import 'package:front_end_instagram/providers/post_provider.dart';
import 'package:front_end_instagram/utils/utils_class.dart';
import 'package:provider/provider.dart';

class PostUserGrid extends StatelessWidget {
  const PostUserGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.currentUserId;
    final postProvider = Provider.of<PostProvider>(context);
    List<Postmodel> filteredPosts = _getFilteredPosts(postProvider, user);

    if (filteredPosts.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(
            'No hay publicaciones',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
      );
    }
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2),
        itemBuilder: (context, index) {
          final post = filteredPosts[index];
          final imageUrl = filteredPosts[index].imageUrl;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExplorePage(
                    post: post,
                  ),
                ),
              );
            },
            child: UtilsClass().buildImage(imageUrl, context,false,false),
          );
        },
        itemCount: filteredPosts.length);
  }

  List<Postmodel> _getFilteredPosts(PostProvider postProvider, user) {
    if (user != null) {
      return postProvider.posts
          .where((post) => post.userId == user!.id)
          .toList();
    } else {
      return postProvider.posts;
    }
  }
}
