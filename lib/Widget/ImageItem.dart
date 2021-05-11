import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:convert' as convert;
class ImageItem extends StatefulWidget {
  var data;

  ImageItem(this.data);

  @override
  _ImageState createState() => _ImageState(data);
}

class _ImageState extends State<ImageItem> {
  var data;  _ImageState(this.data);
  @override
  Widget build(BuildContext context) {
    return  Container(
        height: 203.79,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: MemoryImage(convert.base64.decode(data['imageName'].split(',').last)))));
  }


}
