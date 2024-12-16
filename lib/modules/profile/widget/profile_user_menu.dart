import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/post_model.dart';
import 'package:front_end_instagram/models/user_model.dart';
import 'package:front_end_instagram/providers/post_provider.dart';
import 'package:front_end_instagram/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProfileUserMenu extends StatelessWidget {
  const ProfileUserMenu({
    super.key,
    this.user,
  });

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    //final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    if (user == null) {
      return SizedBox();
    }

    final userPosts = postProvider.getPostsByUserId(user!.id);
    userProvider.getUserById(user!.id)!.followers;

    return user!.posts.isNotEmpty
        ? _buildAuthInfo(userPosts, user!)
        : _buildOthersInfo(userPosts, user!);
  }

  Padding _buildAuthInfo(List<Postmodel> userPosts, UserModel user) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                userPosts.isNotEmpty ? userPosts.length.toString() : '0',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text('posts',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            children: [
              Text(
                user.followers.toString(),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text('followers',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            children: [
              Text(
                user.following.isEmpty ? '0' : user.following.length.toString(),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text('following',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ],
          )
        ],
      ),
    );
  }

  Padding _buildOthersInfo(List<Postmodel> userPosts, UserModel user) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                userPosts.isNotEmpty ? userPosts.length.toString() : '0',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text('posts',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            children: [
              Text(
                user.followers.isNotEmpty
                    ? user.followers.length.toString()
                    : '0',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text('followers',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            children: [
              Text(
                user.following.isEmpty ? '0' : user.following.length.toString(),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text('following',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
