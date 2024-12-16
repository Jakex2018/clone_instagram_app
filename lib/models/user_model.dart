import 'package:front_end_instagram/models/history_model.dart';
import 'package:front_end_instagram/models/post_model.dart';

class UserModel {
  final String id;
  final String username;
  final String email;
  final String photoUser;
  final String password;
  final String passwordConfirmation;
  List<Storymodel?> stories;
  List<String> followers;
  List<String> following;
  final List<Postmodel> posts;
  final String description;
  List<String> postsShared;

  UserModel({
    this.stories = const [], 
    required this.id,
    required this.username,
    required this.email,
    required this.photoUser,
    required this.password,
    required this.passwordConfirmation,
    this.followers = const [],
    this.following = const [],
    required this.posts,
    required this.description,
    this.postsShared = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      photoUser: json['photo_user'] as String,
      password: json['password'] as String,
      passwordConfirmation: json['password_confirmation'] as String,
      followers: List<String>.from(json['followers'] ?? []),
      following: List<String>.from(json['following'] ?? []),
      posts: (json['posts'] as List)
          .map((postJson) => Postmodel.fromJson(postJson))
          .toList(),
      description: json['description'] as String,
      postsShared: List<String>.from(json['posts_shared'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'photo_user': photoUser,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'followers': followers,
      'following': following,
      'posts': posts.map((post) => post.toJson()).toList(),
      'description': description,
      'posts_shared': postsShared,
    };
  }

  @override
  String toString() {
    return ' Usermodel(stories: $stories)';
  }
}
