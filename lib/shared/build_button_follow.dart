import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/user_model.dart';
import 'package:front_end_instagram/providers/user_provider.dart';
import 'package:front_end_instagram/shared/button_one.dart';

class BuildButtonFollow extends StatelessWidget {
  const BuildButtonFollow({
    super.key,
    required this.userProvider,
    required this.user,
    required this.currentUser,
    required this.context,
  });

  final UserProvider userProvider;
  final UserModel? user;
  final UserModel? currentUser;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return ButtonOne(
      onTap: () {
        if (!userProvider.isFollowing) {
          userProvider.addFollower(user!.id, currentUser!.id);
          userProvider.setFollowing(true);
        }
      },
      widget: Center(
          child: Text(
        'Seguir',
        style: TextStyle(color: Colors.white),
      )),
      height: MediaQuery.of(context).size.height * .048,
      width: MediaQuery.of(context).size.width * .30,
      color: Color(0xFF1877F2),
      radius: 10,
    );
  }
}
