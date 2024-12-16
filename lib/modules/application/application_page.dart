import 'package:flutter/material.dart';
import 'package:front_end_instagram/modules/application/widget/bottom_page.dart';
import 'package:front_end_instagram/modules/application/widget/page_view_content.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Material(
        color: Colors.black,
        child: Column(
          children: [
            PageViewContent(),
            const BottomAppBarContent(),
          ],
        ),
      ),
    );
  }
}
