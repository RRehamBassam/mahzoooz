import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AppState extends ChangeNotifier {
  int selectedCategory = 0;
  String colId="CreatedDate";
  bool loud=false;
  int count = 0;
  int ok = 0;
  void updateCategory(int selectedCatgory) {
    this.selectedCategory = selectedCatgory;
    notifyListeners();
  }
  void updateloud(bool loud) {
    this.loud = loud;
    notifyListeners();
  }
  void updateColId(String colId) {
    this.colId = colId;
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