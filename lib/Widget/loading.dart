import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Container(
     // color: Color(0xfff99b1d),
      child: Center(
        child: SpinKitChasingDots(

          color: Color(0xf238056e),
          size: 50,
        ),
      ),
    );
  }
}