import 'package:flutter/material.dart';

class SelectOptionProvider extends ChangeNotifier {
  String _selectedOption = 'PUBLICAR'; // Opción por defecto

  String get selectedOption => _selectedOption;

  void setSelectedOption(String option) {
    _selectedOption = option;
    notifyListeners();
  }
}
