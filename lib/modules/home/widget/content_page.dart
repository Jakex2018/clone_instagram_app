import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/post_model.dart';
import 'package:front_end_instagram/modules/home/widget/post_image.card.dart';
import 'package:front_end_instagram/providers/auth_provider.dart';
import 'package:front_end_instagram/providers/post_provider.dart';
import 'package:front_end_instagram/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({
    super.key,
  });

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  late PostProvider postProvider;
  late AuthProvider authProvider;
  late UserProvider userProvider;
  List<Postmodel> postList = [];

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    postProvider = Provider.of<PostProvider>(context, listen: false);
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    final userId = authProvider.currentUserId?.id;
    if (userId == null) {
      return;
    }

    final user = userProvider.getUserById(userId);
    if (user != null) {
      await postProvider.loadUserPosts(user.following);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeW = MediaQuery.of(context).size.width;
    final sizeH = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Consumer<PostProvider>(
          builder: (context, postProvider, child) {
            if (postProvider.posts.isEmpty) {
              return const Center(
                child: Text(
                  'No hay publicaciones de las cuentas que sigues.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }

            return Container(
              color: Colors.black,
              width: sizeW,
              height: sizeH,
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return PostImageCard(
                    post: postProvider.posts[index],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: postProvider.posts.length,
              ),
            );
          },
        ));
  }
}
