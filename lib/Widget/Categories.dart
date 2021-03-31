import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:typed_data';
import 'dart:convert' as convert;
import 'package:shimmer/shimmer.dart';
import 'package:mahzoooz/Screen/CountriesData.dart';

class Categories extends StatefulWidget {
  var data ;
  bool louding;
  Categories(this.data,this.louding);

  @override
  _CategoriesState createState() => _CategoriesState(data,louding);
}

class _CategoriesState extends State<Categories> {
  var data ;
  bool louding;

  _CategoriesState(this.data,this.louding);
  Uint8List bytesback;
@override
  void initState() {
  bytesback= convert.base64.decode(data['imageName'].split(',').last);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        Navigator.push(context,PageTransition(
          type: PageTransitionType.leftToRight,
          duration: Duration(milliseconds: 550) ,
          reverseDuration: Duration(milliseconds: 700),
          child: CountriesData(data['nameAr']),
        ));
       // Navigator.push(context, new MaterialPageRoute(builder: (context)=>new CountriesData(data['nameAr'])));
      },
      child: Stack(
        children: [
          louding? Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
           enabled: true,
            child: Container(
              width: 95,
              height: 160,
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),),
          ):  Container(
            width: 95,
            height: 160,
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: MemoryImage(bytesback),
                fit: BoxFit.cover,
              ),
            ),),
          louding?Container() :Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              width: 95,
              height: 200,
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10.0),

              ),),
          ),
          Positioned(
            bottom: 25,
            right: 8,
            child:  Container(
              width:60,
              child: Text(data['nameAr'],
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
               // "محلات\n وخدمات",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color:Color(0xffffffff),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}