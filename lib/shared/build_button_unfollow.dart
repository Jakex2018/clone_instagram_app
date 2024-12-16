import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/user_model.dart';
import 'package:front_end_instagram/providers/user_provider.dart';
import 'package:front_end_instagram/shared/button_one.dart';
class BuildButtonUnfollow extends StatelessWidget {
  const BuildButtonUnfollow({
    super.key,
    required this.userProvider,
    required this.currentUser,
    required this.context,
    this.user,
  });

  final UserProvider userProvider;
  final UserModel? currentUser;
  final BuildContext context;
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return ButtonOne(
      onTap: () {
        if (userProvider.isFollowing) {
          userProvider.removeFollower(user!.id, currentUser!.id);
          userProvider.setFollowing(false);
        }
      },
      widget: Center(
          child: Text(
        'Siguiendo',
        style: TextStyle(color: Colors.white),
      )),
      height: MediaQuery.of(context).size.height * .04,
      width: MediaQuery.of(context).size.width * .30,
      color: const Color.fromARGB(255, 101, 100, 100),
      radius: 10,
    );
  }
}
