import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/post_model.dart';
import 'package:front_end_instagram/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _username;

  UserModel? get username => _username;
  bool _isFollowing = false;
  bool get isFollowing => _isFollowing;

  final List<UserModel> _postsShared = [];
  List<UserModel> get postsShared => _postsShared;

  Future<void> setFollowing(bool followingStatus) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool('isFollowing', followingStatus);
    _isFollowing = followingStatus;
    notifyListeners();
  }

  List<UserModel> menu = [
    UserModel(
        description: 'Enginner Systems',
        posts: [],
        followers: [],
        following: [],
        password: '1234567890',
        id: '1',
        passwordConfirmation: '1234567890',
        username: 'rend.dev',
        email: 'marti@gmail.com',
        postsShared: [],
        photoUser:
            'https://media.istockphoto.com/id/536988396/photo/confident-man-in-blue-sweater-portrait.jpg?s=612x612&w=0&k=20&c=Ww3dK11KMRuru6mqddVQ29u0XZxvq_dFghN2Ta6OCN4='),
    UserModel(
        description: 'Enginner Systems',
        posts: [],
        followers: [],
        following: [],
        password: '1234567890',
        id: '1223',
        passwordConfirmation: '1234567890',
        username: 'Luisa Alves',
        email: 'luisa@gmail.com',
        postsShared: [],
        photoUser:
            'https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?cs=srgb&dl=pexels-olly-733872.jpg&fm=jpg'),
    UserModel(
        description: 'Enginner Systems',
        posts: [],
        followers: [],
        following: [],
        password: '1234567890',
        id: '03123102',
        passwordConfirmation: '1234567890',
        username: 'Lugo Perez',
        email: 'lugo@gmail.com',
        postsShared: [],
        photoUser:
            'https://static.vecteezy.com/system/resources/thumbnails/003/492/377/small/closeup-male-studio-portrait-of-happy-man-looking-at-the-camera-image-free-photo.jpg'),
    UserModel(
        description: 'Enginner Systems',
        posts: [],
        followers: [],
        following: [],
        password: '1234567890',
        id: '00000788',
        passwordConfirmation: '1234567890',
        username: 'Lina Rodriguez',
        email: 'lina@gmail.com',
        postsShared: [],
        photoUser:
            'https://media.istockphoto.com/id/1369508766/es/foto/hermosa-mujer-latina-exitosa-sonriendo.jpg?s=612x612&w=0&k=20&c=f-3MdwiVjpE4UWQdqLC3vpWViYMCiGUPr5aKLCmTnDI='),
  ];

  void addSharedPost(String userId, String postId) {
    final user = getUserById(userId);
    if (!user!.postsShared.contains(postId)) {
      user.postsShared.add(postId);
    }
    notifyListeners();
  }

  Future<void> addFollower(String userId, String currentUserId) async {
    final user = getUserById(userId);
    final currentUser = getUserById(currentUserId)!;

    if (!currentUser.following.contains(userId)) {
      currentUser.following.add(userId);

      if (!user!.followers.contains(currentUserId)) {
        user.followers.add(currentUserId);

        final prefs = await SharedPreferences.getInstance();

        await prefs.setStringList(
            '${currentUserId}_following', currentUser.following);

        await prefs.setStringList('${userId}_followers', user.followers);

        notifyListeners();
      }
    }
  }

  void removeFollower(String userId, String currentUserId) async {
    final user = getUserById(userId);
    final currentUser = getUserById(currentUserId);

    if (currentUser!.following.contains(userId)) {
      currentUser.following.remove(userId);
      if (user!.followers.contains(currentUserId)) {
        user.followers.remove(currentUserId);
        final prefs = await SharedPreferences.getInstance();

        await prefs.setStringList(
            '${currentUserId}_following', currentUser.following);

        await prefs.setStringList('${userId}_followers', user.followers);

        notifyListeners();
      }
    }
  }

  Future<void> loadFollowingStatus() async {
    final prefs = await SharedPreferences.getInstance();

    _isFollowing = prefs.getBool('isFollowing') ?? false;
    notifyListeners();
  }

  Future<void> loadUserData(String userId) async {
    final prefs = await SharedPreferences.getInstance();

    final following = prefs.getStringList('${userId}_following') ?? [];
    final followers = prefs.getStringList('${userId}_followers') ?? [];

    final user = getUserById(userId);

    if (user != null) {
      user.following = following;
      user.followers = followers;

      notifyListeners();
    }
  }

  void saveUser(UserModel user) {
    menu.add(user);
    notifyListeners();
  }

  void updatePost(List<Postmodel> newPost) {
    _username?.posts.addAll(newPost);
    notifyListeners();
  }

  UserModel? getUserById(String id) {
    return menu.firstWhere(
      (user) => user.id == id,
      orElse: () => UserModel(
          description: '',
          posts: [],
          followers: [],
          following: [],
          password: '',
          passwordConfirmation: '',
          username: '',
          email: '',
          photoUser: '',
          id: ''),
    );
  }

  UserModel? getUserByEmail(String email) {
    return menu.firstWhere(
      (user) => user.email == email,
      orElse: () => UserModel(
          description: '',
          posts: [],
          followers: [],
          following: [],
          password: '',
          passwordConfirmation: '',
          username: '',
          email: '',
          photoUser: '',
          id: ''),
    );
  }
}
