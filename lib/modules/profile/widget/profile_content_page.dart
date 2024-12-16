import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/user_model.dart';
import 'package:front_end_instagram/modules/profile/widget/profile_info_user.dart';
import 'package:front_end_instagram/modules/profile/widget/profile_options.dart';
import 'package:front_end_instagram/modules/profile/widget/profile_tab_menu.dart';

class ProfileContentPage extends StatefulWidget {
  const ProfileContentPage({super.key, this.user});
  final UserModel? user;
  @override
  State<ProfileContentPage> createState() => _ProfileContentPageState();
}

class _ProfileContentPageState extends State<ProfileContentPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileInfoUser(
            user: widget.user,
          ),
          ProfileOptions(user:widget.user),
          ProfileTabMenu()
        ],
      ),
    );
  }
}
