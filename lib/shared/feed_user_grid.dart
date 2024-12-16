import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/post_model.dart';
import 'package:front_end_instagram/modules/post/widget/explore_page.dart';
import 'package:front_end_instagram/providers/post_provider.dart';
import 'package:front_end_instagram/utils/utils_class.dart';
import 'package:provider/provider.dart';

class FeedUserGrid extends StatelessWidget {
  const FeedUserGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    List<Postmodel> filteredPosts = postProvider.posts;

    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2),
        itemBuilder: (context, index) {
          final post = filteredPosts[index];
          final imageUrl = filteredPosts[index].imageUrl;
          return GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ExplorePage(post: post),
                ),
              );
            },
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: UtilsClass().buildImage(imageUrl, context,false,false)),
          );
        },
        itemCount: filteredPosts.length);
  }
}
/*
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/post_model.dart';
import 'package:front_end_instagram/modules/post/widget/explore_page.dart';
import 'package:front_end_instagram/modules/reels/widget/video_app_content.dart';
import 'package:front_end_instagram/providers/auth_provider.dart';
import 'package:front_end_instagram/providers/post_provider.dart';
import 'package:provider/provider.dart';

class FeedUserGrid extends StatelessWidget {
  const FeedUserGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.currentUserId;
    final postProvider = Provider.of<PostProvider>(context);
    List<Postmodel> filteredPosts = _getFilteredPosts(postProvider, user);

    if (filteredPosts.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(
            'No hay publicaciones',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
      );
    }

    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2),
        itemBuilder: (context, index) {
          final post = filteredPosts[index];
          final imageUrl = filteredPosts[index].imageUrl;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExplorePage(post: post),
                ),
              );
            },
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: buildImage(imageUrl, context)),
          );
        },
        itemCount: filteredPosts.length);
  }

  Widget buildImage(String? mediaUrl, context) {
    if (mediaUrl == null || mediaUrl.isEmpty) {
      return const Icon(Icons.error);
    }

    if (mediaUrl.endsWith('.mp4')) {
      return VideoAppContent(
        file: File(mediaUrl),
        autoPlay: false,
      );
    }

    // Verifica si la URL tiene el esquema 'http' o 'https'
    if (mediaUrl.startsWith('http://') || mediaUrl.startsWith('https://')) {
      // Si es una URL válida, utiliza Image.network
      return Image.network(
        mediaUrl,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.5,
      );
    } else {
      return FutureBuilder<File>(
        future: _getFile(mediaUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData && snapshot.data != null) {
            return FutureBuilder<Uint8List>(
              future:
                  snapshot.data?.readAsBytes(), // Leer el archivo como bytes
              builder: (context, byteSnapshot) {
                if (byteSnapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (byteSnapshot.hasData && byteSnapshot.data != null) {
                  return Image.memory(
                    byteSnapshot.data!, // Usar los bytes de la imagen
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.5,
                  );
                } else {
                  return const Icon(Icons.error); // Si no puede leer los bytes
                }
              },
            );
          } else {
            return const Icon(Icons.error); // Si no encuentra el archivo
          }
        },
      );
    }
  }

  List<Postmodel> _getFilteredPosts(PostProvider postProvider, user) {
    if (user != null) {
      return postProvider.posts
          .where((post) => post.userId == user!.id)
          .toList();
    } else {
      return postProvider.posts;
    }
  }

  Future<File> _getFile(String? filePath) async {
    if (filePath == null || filePath.isEmpty) {
      throw Exception("Invalid file path");
    }
    final file = File(filePath.replaceFirst(
        'file://', '')); // Quitar 'file://' si es necesario
    return file;
  }
}

 */