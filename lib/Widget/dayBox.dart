import 'package:flutter/material.dart';
import 'package:animated_clipper/animated_clipper.dart';
class dayBox extends StatefulWidget {
  bool _bool;
  var data;
  @override
  _dayBoxState createState() => _dayBoxState(_bool,data);
  dayBox(this._bool,data);
}

class _dayBoxState extends State<dayBox> {
  bool _bool;
  var data;
  _dayBoxState(this._bool,data);

  void _toggleBool(bool newValue) {
    setState(() {
      _bool = newValue;
    });
  }
//  bool _bool = false;
  @override
  Widget build(BuildContext context) {
    print(data);
    return ClipSwitch(
      value: _bool,
      onChanged: _toggleBool,
      inactiveWidget: Container(
        height: 105,
        width:110,
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11.0),
          color: const Color(0xffffffff),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(11.0),
          elevation: 2,
          child: Container(
            height: 105,
            width:110,
            // margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.0),
              color: const Color(0xffffffff),

            ),
            child: Column(
              children: [
                Container(
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(11.0),topRight:Radius.circular(11.0)),
                    //color: const Color(0xfff5f5f5),
                    color:Color(0xff38056e) ,
                  ),

                  child: Center(
                    child: Text("الخميس",
                      style: TextStyle(fontWeight:FontWeight.w600,fontSize: 18,color:Colors.white ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(11.0),topRight:Radius.circular(11.0)),
                    //color: const Color(0xfff5f5f5),
                    //  color:Color(0xff38056e) ,
                  ),
                  height: 30,
                  child: Center(
                    child: Text(data['dayDate'].toString(),
                      style: TextStyle(fontWeight:FontWeight.w500,fontSize: 18,color:Colors.black ),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  child: Center(
                    child: Text("إبرايل",
                      style: TextStyle(fontWeight:FontWeight.w500,fontSize: 18,color:Colors.black ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      activeWidget: Container(
        height: 105,
        width:110,
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11.0),
          color: const Color(0xffffffff),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(11.0),
          elevation: 2,
          child: Container(
            height: 105,
            width:110,
            // margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.0),
              color: const Color(0xffffffff),

            ),
            child: Column(
              children: [
                Container(
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(11.0),topRight:Radius.circular(11.0)),
                    //color: const Color(0xfff5f5f5),
                    color:Color(0xff38056e) ,
                  ),

                  child: Center(
                    child: Text("الخميس",
                      style: TextStyle(fontWeight:FontWeight.w600,fontSize: 18,color:Colors.white ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color:Color(0xff38056e).withOpacity(0.9),
                    // borderRadius: BorderRadius.only(topLeft: Radius.circular(11.0),topRight:Radius.circular(11.0)),
                    //color: const Color(0xfff5f5f5),
                    //  color:Color(0xff38056e) ,
                  ),
                  height: 35,
                  child: Center(
                    child: Text("10",
                      style: TextStyle(fontWeight:FontWeight.w500,fontSize: 18,color:Colors.white ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(11.0),bottomRight:Radius.circular(11.0)),
                    color:Color(0xff38056e).withOpacity(0.9) ,
                    // borderRadius: BorderRadius.only(topLeft: Radius.circular(11.0),topRight:Radius.circular(11.0)),
                    //color: const Color(0xfff5f5f5),
                    //  color:Color(0xff38056e) ,
                  ),
                  height: 25.7,
                  child: Center(
                    child: Text("إبرايل",
                      style: TextStyle(fontWeight:FontWeight.w500,fontSize: 18,color:Colors.white ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
