import 'package:shimmer/shimmer.dart';
import 'dart:typed_data';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
class ItemCarouselSliderLoud extends StatefulWidget {

  @override
  _ItemCarouselSliderState createState() => _ItemCarouselSliderState();
}

class _ItemCarouselSliderState extends State<ItemCarouselSliderLoud> {

  bool _enabled = true;


  @override
  Widget build(BuildContext context) {

    return
      Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        enabled: _enabled,
      child: Stack(
        children: [
          Container(


           margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image:AssetImage("Assets/Rectangle.png"),
                  fit: BoxFit.fill,
                )
            ),
            // child: Image.memory(bytes,fit: BoxFit.fitWidth),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top:0,
            child: Container(
              margin: EdgeInsets.all(5.0),
              padding: EdgeInsets.all(5.0) ,
              decoration: BoxDecoration(color: Colors.white.withOpacity(1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),


              height: 66,

            ),
          )
        ],
      ),
    );
  }
}
