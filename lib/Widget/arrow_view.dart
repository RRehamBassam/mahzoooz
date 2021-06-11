import 'dart:math';

import 'package:flutter/material.dart';

class ArrowView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   // print( MediaQuery.of(context).size.height);
    return Align(
      alignment: Alignment.center,
      child: Transform.rotate(
        angle: pi,
        child: Container(
           margin: EdgeInsets.only(right: 5,bottom: 7),
          child: Padding(

            padding: EdgeInsets.only(top:MediaQuery.of(context).size.height<800? 82:90,right:MediaQuery.of(context).size.height<800?4: 0,left: MediaQuery.of(context).size.height<800?0:5),
            child: ClipPath(
              clipper: _ArrowClipper(),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black12,Color(0xffFFA500), Color(0xffFFA500)])),
                height: 45,
                width: 45,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path _path = Path();
    Offset _center = size.center(Offset.zero);
    _path.lineTo(_center.dx, size.height);
    _path.lineTo(size.width, 0);
    _path.lineTo(_center.dx, _center.dy);
    _path.close();
    return _path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
