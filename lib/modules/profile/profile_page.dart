import 'package:flutter/material.dart';
import 'package:front_end_instagram/modules/profile/widget/app_profile_page.dart';
import 'package:front_end_instagram/modules/profile/widget/profile_content_page.dart';
import 'package:front_end_instagram/providers/profile_provider.dart';
import 'package:front_end_instagram/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    this.userId,
  });

  final String? userId;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
          Consumer<ProfileProvider>(builder: (context, profileProvider, child) {
        final userId = widget.userId ?? profileProvider.selectedUserId;

        if (userId == null) return SizedBox();
        final user = Provider.of<UserProvider>(context).getUserById(userId);

        return NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(child: AppProfilePage(user: user))
            ];
          },
          body: ProfileContentPage(user: user),
        );
      }),
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:front_end_instagram/modules/profile/widget/app_profile_page.dart';
import 'package:front_end_instagram/modules/profile/widget/profile_content_page.dart';
import 'package:front_end_instagram/providers/profile_provider.dart';
import 'package:front_end_instagram/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    this.userId,
  });

  final String? userId;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
          Consumer<ProfileProvider>(builder: (context, profileProvider, child) {
        final userId = widget.userId ?? profileProvider.selectedUserId;

        if (userId == null) return SizedBox();
        final user = Provider.of<UserProvider>(context).getUserById(userId);

        return NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(child: AppProfilePage(user: user))
            ];
          },
          body: ProfileContentPage(user: user),
        );
      }),
    );
  }
}

 */