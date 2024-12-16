import 'package:flutter/material.dart';
import 'package:front_end_instagram/providers/auth_provider.dart';
import 'package:front_end_instagram/shared/custom_gallery.dart';
import 'package:front_end_instagram/shared/image_container.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

class BottomAppBarContent extends StatefulWidget {
  const BottomAppBarContent({
    super.key,
  });

  @override
  State<BottomAppBarContent> createState() => _BottomAppBarContentState();
}

class _BottomAppBarContentState extends State<BottomAppBarContent> {
  Future<void> _pickImage(requestType) async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CustomGallery(maxCount: 10, requestType: requestType)));
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthProvider>(context);

    final userPhoto = userProvider.currentUserId?.photoUser;

    return Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: TabBar(
        indicatorColor: Colors.transparent,
        tabs: [
          const Tab(
            icon: Icon(
              Icons.home_filled,
              color: Colors.white,
              size: 30,
            ),
          ),
          Tab(
            icon: Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
          ),
          Tab(
            icon: IconButton(
              onPressed: () {
                _pickImage(RequestType.common);
              },
              icon: Icon(
                Icons.add_box_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          const Tab(
            icon: Icon(
              Icons.movie_filter_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
          Tab(
              child: userPhoto != null
                  ? ImageContainer(
                      imageContent: userPhoto,
                      radius: 13,
                    )
                  : Text('error')),
        ],
      ),
    );
  }
}
