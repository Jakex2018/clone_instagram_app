import 'package:flutter/material.dart';
import 'package:front_end_instagram/modules/profile/widget/profile_tab.dart';
import 'package:front_end_instagram/modules/profile/widget/profile_tab_content.dart';

class ProfileTabMenu extends StatelessWidget {
  const ProfileTabMenu({
    super.key, 
  });

  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            ProfileTab(),
            ProfileTabContent()
          ],
        ));
  }
}