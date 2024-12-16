import 'package:flutter/material.dart';
import 'package:front_end_instagram/modules/home/widget/app_home_page.dart';
import 'package:front_end_instagram/modules/home/widget/content_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[SliverToBoxAdapter(child: AppHomePage())];
        },
        body: ContentPage(),
      ),
    ));
  }
}
