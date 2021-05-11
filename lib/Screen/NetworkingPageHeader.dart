import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert' as convert;
class NetworkingPageHeader implements SliverPersistentHeaderDelegate {
  NetworkingPageHeader({
    this.data,
    this.minExtent,
    @required this.maxExtent,
  });
  var data;
  final double minExtent;
  final double maxExtent;
  Uint8List
  bytesback;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    bytesback= convert.base64.decode(data['imageName'].split(',').last);
    return Stack(
      fit: StackFit.expand,
      children: [
    data['imageName']==null? Image.asset(
          'Assets/ModalPanel.png',
          fit: BoxFit.cover,
        ):new Container(
   // height: 203.79,
   // width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
    image: DecorationImage(
    fit: BoxFit.fill,
    image: MemoryImage(bytesback),
    ),
    //border: Border.all(width: 1.00, color: Color(0xfff5f5f5).withOpacity(0.4),), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.00), bottomRight: Radius.circular(12.00), ),
    ),
    ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black54],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
          ),
        ),
        Positioned(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
          child: Text(
            'Lorem ipsum',
            style: TextStyle(
              fontSize: 32.0,
              color: Colors.white.withOpacity(titleOpacity(shrinkOffset)),
            ),
          ),
        ),
      ],
    );
  }

  double titleOpacity(double shrinkOffset) {
    // simple formula: fade out text as soon as shrinkOffset > 0
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
    // more complex formula: starts fading out text when shrinkOffset > minExtent
    //return 1.0 - max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  // TODO: implement showOnScreenConfiguration
  PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration => throw UnimplementedError();

  @override
  // TODO: implement stretchConfiguration
  OverScrollHeaderStretchConfiguration get stretchConfiguration => throw UnimplementedError();

  @override
  // TODO: implement vsync
  TickerProvider get vsync => throw UnimplementedError();
}