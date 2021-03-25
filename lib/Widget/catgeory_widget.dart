import 'package:flutter/material.dart';
import 'package:mahzoooz/Models/category.dart';
import 'package:provider/provider.dart';
import 'package:mahzoooz/services/app_state.dart';
import 'package:mahzoooz/utilities/themeColors.dart';


class CategoryWidget extends StatelessWidget {
   Category category;
   CategoryWidget({Key key, this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isSelected = appState.selectedCategory == category.categoryId;

    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          appState.updateCategory(category.categoryId);
        }
      },
      child: Container(

        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? ThemeColors.green : Colors.transparent,
          borderRadius: BorderRadius.circular(22.0),
        ),
        child: Center(
          child: Text(
            category.name,

            style: isSelected
                ? TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold)
                : TextStyle(color: Colors.black45,fontSize: 12,fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
