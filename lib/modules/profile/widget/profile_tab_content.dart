import 'package:flutter/material.dart';
import 'package:front_end_instagram/modules/profile/widget/post_shared_tab.dart';
import 'package:front_end_instagram/modules/profile/widget/post_user_tab.dart';

class ProfileTabContent extends StatelessWidget {
  const ProfileTabContent({
    super.key, 
  });


  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return SizedBox(
      height: MediaQuery.of(context).size.height * .44,
      width: MediaQuery.of(context).size.width,
      child: PageView(controller: pageController,
        children: [PostUserTab(), PostSharedTab()],
      ),
    );
  }
}
