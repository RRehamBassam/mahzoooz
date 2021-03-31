import 'package:flutter/material.dart';

import 'dart:typed_data';
import 'dart:convert' as convert;
import 'package:shimmer/shimmer.dart';
class CategoriesLoud extends StatefulWidget {
  var data ;
  bool louding;
  CategoriesLoud(this.data,this.louding);

  @override
  _CategoriesLoudState createState() => _CategoriesLoudState(data,louding);
}

class _CategoriesLoudState extends State<CategoriesLoud> {
  var data ;
  bool louding;

  _CategoriesLoudState(this.data,this.louding);
  Uint8List bytesback;
  bool _enabled = true;
  @override
  Widget build(BuildContext context) {
    //  bytesback= convert.base64.decode(data['imageName'].split(',').last);
    return Stack(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          enabled: _enabled,
         // highlightColor: Colors.white,
          child: Container(
            width: 95,
            height: 160,
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: Colors.black26.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10.0),
            ),),
        ),


      ],
    );
  }
}
