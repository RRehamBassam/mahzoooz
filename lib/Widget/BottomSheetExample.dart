import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class BottomSheetExample extends StatelessWidget {
  List data;
Function(String) callBack;
  BottomSheetExample(this.data);

  @override
  Widget build(BuildContext context) {
    print(data);
    return Container(
      color: Colors.black45.withOpacity(0.56),

      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color:Colors.white,
          boxShadow: [BoxShadow(
              color: Color.fromRGBO(34, 134, 234, .3),
              blurRadius: 20,
              offset: Offset(0, 10)
          )],


          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35.0),
            topRight: Radius.circular(35.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 16,),
            Center(
              child:  Text(
                "اختر الدولة",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Tajawal",fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color:Color(0xff3d3b39),
                ),
              ),
            ),
            Container(
              height:170,
              width: 90,
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(top: 40, bottom: 40),
              color: Colors.white,
              child: ListWheelScrollView(
                  itemExtent: 50,
                    diameterRatio: 1.2,
                    offAxisFraction: -0.4,
                    squeeze: 0.8,
                  // clipToSize: true
                //  itemExtent: 40,
                  useMagnifier: true,

                 // diameterRatio: 1.6,
                  children: <Widget>[
                    ...data.map((name) {
                      print(name['nameAr']);
                      return InkWell(
                        onTap: ()=>callBack(name['nameAr']),
                        child: Container(
                          width: double.infinity,

                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 1, color: Colors.black12)),
                          padding: EdgeInsets.all(5),
                margin:EdgeInsets.all(3) ,
                          child: Center(
                            child: Text(name['nameAr'],
                              style: TextStyle(
                              fontFamily: "Tajawal",fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color:Color(0xff3d3b39),
                            )),
                          ),
                        ),
                      );
                    })
                  ]),
            ),

            // ListWheelScrollView(
            //   itemExtent: 100,
            //
            //   // diameterRatio: 1.6,
            //   // offAxisFraction: -0.4,
            //   // squeeze: 0.8,
            // //  clipToSize: true
            //
            // )
          ],
        ),
      ),
    );
  }
}



