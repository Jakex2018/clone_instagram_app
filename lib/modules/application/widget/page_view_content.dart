import 'package:flutter/material.dart';
import 'package:front_end_instagram/modules/home/home_page.dart';
import 'package:front_end_instagram/modules/profile/profile_page.dart';
import 'package:front_end_instagram/modules/reels/reels_page.dart';
import 'package:front_end_instagram/modules/search/search_page.dart';
import 'package:front_end_instagram/providers/auth_provider.dart';
import 'package:front_end_instagram/shared/custom_gallery.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

class PageViewContent extends StatelessWidget {
  const PageViewContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<AuthProvider>(context).currentUserId?.id;

    TabController? tabController;
    return Flexible(
      child: TabBarView(
        controller: tabController,
        children: [
          HomePage(),
          SearchPage(),
          CustomGallery(maxCount: 10, requestType: RequestType.common),
          ReelsPage(),
          ProfilePage(
            userId: userId,
          ),
        ],
      ),
    );
  }
}
