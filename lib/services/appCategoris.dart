import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mahzoooz/Models/category.dart';
class AppCategoris extends ChangeNotifier {
  var categoriesData = [];
  int count = -1;
  int id = -1;
  int ok = 0;
  bool show=true;
  String Search = "1";
  int Empty=-1;
  int CountEmpty=-1;
  void updatecategoriesData(var count) {
    this.categoriesData = count;
    notifyListeners();
  }
  void updateshowData() {
    this.show = false;
    notifyListeners();
  }
  void updateEmptyData() {
    this.Empty = 1;
    notifyListeners();
  }
  void updateCountEmpty(int c) {
    this.CountEmpty=  c;
    notifyListeners();
  }

  void updateCount(int count) {
    this.count = count;
    notifyListeners();
  }
  void updateSearch(String Search) {
    this.Search = Search;
    notifyListeners();
  }
  void updateid(int count) {
    this.id = count;
    notifyListeners();
  }
  void updateok(int selectedCatgory) {
    this.ok = selectedCatgory;
    notifyListeners();
  }
}