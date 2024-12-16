import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/comment_model.dart';
import 'package:front_end_instagram/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostProvider extends ChangeNotifier {
  List<Postmodel> posts = [];
  List<Postmodel> postsUser = [];
  PostProvider() {
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? postsJson = prefs.getString('posts');
    if (postsJson != null) {
      final List<dynamic> postsList = json.decode(postsJson);
      posts =
          postsList.map((postJson) => Postmodel.fromJson(postJson)).toList();
    }
    notifyListeners();
  }

  Future<void> _savePosts() async {
    final prefs = await SharedPreferences.getInstance();
    final String postsJson =
        json.encode(posts.map((post) => post.toJson()).toList());
    await prefs.setString('posts', postsJson);
  }

  List<Comment> getComments(String postId) {
    final post = posts.firstWhere((post) => post.id == postId);
    return post.comments ?? [];
  }

  void addComment(String postId, Comment newComment) {
    final post = posts.firstWhere(
      (post) => post.id == postId,
      orElse: () => Postmodel(
        timeAgo: '',
        id: '',
        userId: '',
        imageUrl: '',
        createdAt: DateTime.now(),
      ),
    );
    post.comments ??= [];
    post.comments!.add(newComment);

    _savePosts();
    notifyListeners();
  }

  // Método para compartir un post
  void sharePost(String postId) {
    final post = posts.firstWhere(
      (post) => post.id == postId,
      orElse: () => Postmodel(
        timeAgo: '',
        id: '',
        userId: '',
        imageUrl: '',
        createdAt: DateTime.now(),
        likes: [],
        comments: [],
        shareCount: 0,
      ),
    );

    post.shareCount = (post.shareCount ?? 0) + 1;
    _savePosts();
    notifyListeners();
  }

  int getShareCount(String postId) {
    final post = posts.firstWhere(
      (post) => post.id == postId,
      orElse: () => Postmodel(
        timeAgo: '',
        id: '',
        userId: '',
        imageUrl: '',
        createdAt: DateTime.now(),
        likes: [],
        comments: [],
        shareCount: 0,
      ),
    );

    return post.shareCount!;
  }

  void addPost(Postmodel post) {
    posts.add(post);

    _savePosts();
    notifyListeners();
  }

  void deletePostId(String postId) {
    // Eliminar el post de la lista
    posts.removeWhere((post) => post.id == postId);

    _savePosts();
    notifyListeners();
  }

  Future<void> loadUserPosts(List<String> followingUserIds) async {
    if (followingUserIds.isNotEmpty) {
      List<Postmodel> allPosts = await fetchAllPosts();

      //postsUser.clear();

      for (String userId in followingUserIds) {
        postsUser
            .addAll(allPosts.where((post) => post.userId == userId).toList());
      }
    } else {
      return;
    }
    notifyListeners();
  }

  void toggleLike(String postId, String userId) {
    final post = posts.firstWhere(
      (post) => post.id == postId,
      orElse: () => Postmodel(
          timeAgo: '',
          id: '',
          userId: '',
          imageUrl: '',
          createdAt: DateTime.now(),
          likes: []),
    );

    post.likes ??= [];

    if (!post.likes!.contains(userId)) {
      post.likes!.add(userId);
    } else {
      post.likes!.remove(userId);
    }
    _savePosts();
    notifyListeners();
  }

  Future<List<Postmodel>> fetchAllPosts() async {
    await Future.delayed(Duration(seconds: 2));
    return posts;
  }

  List<Postmodel> getPostsByUserId(String userId) {
    return posts.where((post) => post.userId == userId).toList();
  }

  Postmodel? getPosts(String userId) {
    return posts.firstWhere((post) => post.userId == userId);
  }
}
