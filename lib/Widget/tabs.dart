import 'package:flutter/material.dart';
import 'package:mahzoooz/Models/category.dart';
import 'package:mahzoooz/Widget/catgeory_widget.dart';
import 'package:mahzoooz/services/app_state.dart';
import 'package:provider/provider.dart';


class MyTabs extends StatefulWidget {
   var categoriesList;

   MyTabs(this.categoriesList);

  @override
  _MyTabsState createState() => _MyTabsState(categoriesList);
}

class _MyTabsState extends State<MyTabs> {
  var categoriesList;

  _MyTabsState(this.categoriesList);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: ChangeNotifierProvider<AppState>(
        create: (_) => AppState(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
          child: Consumer<AppState>(
            builder: (context, appState, _) => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 42.0,
                width: MediaQuery.of(context).size.width ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    for (final category in categoriesList)
                      CategoryWidget(
                        category: category,
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
