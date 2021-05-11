import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AppState extends ChangeNotifier {
  int selectedCategory = 0;
  int count = 0;
  int ok = 0;
  void updateCategory(int selectedCatgory) {
    this.selectedCategory = selectedCatgory;
    notifyListeners();
  }
  void updateCount(int count) {
    this.count = count;
    notifyListeners();
  }
  void updateok(int selectedCatgory) {
    this.ok = selectedCatgory;
    notifyListeners();
  }
}