import 'package:flutter/material.dart';
import 'package:front_end_instagram/modules/search/widget/search_content.dart';
import 'package:front_end_instagram/modules/search/widget/search_input.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[SliverToBoxAdapter(child: SearchInput())];
        },
        body: SearchContent(),
      ),
    );
  }
}
