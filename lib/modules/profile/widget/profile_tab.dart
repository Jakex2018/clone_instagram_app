import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .05,
      child: TabBar(
          dividerColor: Colors.transparent,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            const Tab(
              icon: Icon(
                Icons.space_dashboard_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
            const Tab(
              icon: Icon(
                Icons.supervised_user_circle_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
          ]),
    );
  }
}
