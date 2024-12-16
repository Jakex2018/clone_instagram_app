import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  String? _selectedUserId;

  String? get selectedUserId => _selectedUserId;

  // Cambiar la ID del usuario seleccionado
  void selectUser(String userId) {
    _selectedUserId = userId;
    notifyListeners();
  }
}
