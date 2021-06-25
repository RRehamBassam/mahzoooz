
import 'dart:ui';

class Luck{
  final String image;
  final String imageEn;
  final Color color;


  Luck(this.image, this.color,this.imageEn);


  String get asset =>  "$image";
  String get assetEn =>  "$imageEn";
}