import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/user_model.dart';
import 'package:front_end_instagram/modules/profile/widget/image_add_reel.dart';
import 'package:front_end_instagram/modules/profile/widget/profile_user_menu.dart';
import 'package:front_end_instagram/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ProfileInfoUser extends StatelessWidget {
  const ProfileInfoUser({
    super.key,
    this.user,
    this.userId,
  });
  final UserModel? user;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    final isAuthProfile =
        user?.id == Provider.of<AuthProvider>(context).currentUserId?.id;

    if (user == null) return SizedBox();

    return isAuthProfile ? _buildAuthProfile(user) : _buildOtherProfile(user);
  }

  Padding _buildOtherProfile(UserModel? user) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageAddReel(
                user: user,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                user!.username,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
              ),
              Text(
                user.description,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
              )
            ],
          ),
          SizedBox(
            width: 20,
          ),
          ProfileUserMenu(user: user)
        ],
      ),
    );
  }

  Padding _buildAuthProfile(UserModel? user) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageAddReel(
                user: user,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                user!.username,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
              ),
              Text(
                user.description,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
              )
            ],
          ),
          SizedBox(
            width: 20,
          ),
          ProfileUserMenu(user: user,)
        ],
      ),
    );
  }
}
