
import 'dart:ui';

class Luck{
  final String image;
  final String imageEn;
  final Color color;
  final Map data;
  final String NameAr;
  final String NameEn;


  Luck(this.image, this.color,this.imageEn,this.data,this.NameAr,this.NameEn);


  String get asset =>  "$image";
  String get assetEn =>  "$imageEn";
  String get NameReAr =>  NameAr;
  String get NameReEn =>  NameEn;
  Map get dataLuck =>  data;
}