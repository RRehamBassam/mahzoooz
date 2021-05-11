import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountProvider extends ChangeNotifier {
  int selectedCategory = 0;
  void updateCategory(int selectedCatgory) {
    this.selectedCategory = selectedCatgory;
    notifyListeners();
  }
}
