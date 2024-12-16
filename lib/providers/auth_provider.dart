import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/user_model.dart';
import 'package:front_end_instagram/providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  UserModel? _currentUserId;
  bool _isLoading = true;

  //GETTERS
  bool get isLoggedIn => _isLoggedIn;
  UserModel? get currentUserId => _currentUserId;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _loadLoginState();
  }

  void setLoggedIn(UserModel? user) {
    _currentUserId = user;
    _isLoggedIn = true;
    _saveLogin();
    notifyListeners();
  }

  void logOut() {
    _currentUserId = null;
    _isLoggedIn = false;
    _saveLogin();
    notifyListeners();
  }

  void _saveLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (_currentUserId != null) {
      await prefs.setString('userId', _currentUserId!.id);
    } else {
      await prefs.remove('userId');
    }
  }

  Future<void> _loadLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    if (userId != null) {
      _currentUserId = await _getUserById(userId);
      _isLoggedIn = _currentUserId != null;
    } else {
      _isLoggedIn = false;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<UserModel?> _getUserById(String userId) async {
    return UserProvider().getUserById(userId);
  }
}
