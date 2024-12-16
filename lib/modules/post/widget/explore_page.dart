import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/post_model.dart';
import 'package:front_end_instagram/modules/application/application_page.dart';
import 'package:front_end_instagram/modules/home/widget/post_image.card.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key, this.post, this.image});
  final Postmodel? post;
  final String? image;
  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ApplicationPage()));
              },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              )),
          backgroundColor: Colors.black,
          title: Text(
            'Publicaciones',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
            child: PostImageCard(
          post: widget.post,
        )));
  }
}
