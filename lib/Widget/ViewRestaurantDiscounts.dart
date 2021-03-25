import 'package:animated_clipper/animated_clipper.dart';
import 'package:flutter/material.dart';
import 'package:mahzoooz/Screen/RestaurantData.dart';
import 'package:page_transition/page_transition.dart';


class ViewRestaurantDiscounts extends StatefulWidget {
  @override
  _ViewRestaurantDiscountsState createState() => _ViewRestaurantDiscountsState();
}

class _ViewRestaurantDiscountsState extends State<ViewRestaurantDiscounts> {
  int _counter = 0;
  bool _bool = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _toggleBool(bool newValue) {
    setState(() {
      _bool = newValue;
    });
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context,PageTransition(
          type: PageTransitionType.leftToRight,
            duration: Duration(milliseconds: 550) ,
            reverseDuration: Duration(milliseconds: 700),
          child: RestaurantData(),
        ),);
      },
      child: Align(
        //   heightFactor: 0.7,
          alignment: Alignment.topCenter,
          child:Container(
            margin: EdgeInsets.only(bottom: 8,top: 2),
            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10.0),),
            child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                  decoration: BoxDecoration(
                    // boxShadow: [BoxShadow(
                    //     color: Color.fromRGBO(34, 134, 234, .3),
                    //     blurRadius: 1,
                    //     offset: Offset(2, 1)
                    // )],
                    borderRadius: BorderRadius.circular(10.0),),
                  // margin:EdgeInsets.all(8.0) ,
                  child:Stack(
                    children: [
                      Container(
                        width:MediaQuery.of(context).size.width*0.9,
                        height:MediaQuery.of(context).size.width*0.68,
                        // margin: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage('Assets/Rectangle.png'),
                            fit: BoxFit.cover,
                          ),
                        ),),
                      Positioned(
                          left: 10, top: 10,
                          child:Row(
                            children: [
                              new Container(
                                height: 25.00,
                                width: 25.00,
                                decoration: BoxDecoration(
                                  color: Color(0xffffffff),borderRadius: BorderRadius.circular(15.00),
                                ),
                                child:     Center(child: Image.asset("Assets/Upload.png",scale: 0.85,)),
                              ),
                              SizedBox(width: 10,),
                              new Container(
                                height: 25.00,
                                width: 25.00,
                                decoration: BoxDecoration(
                                  color: Color(0xffffffff),borderRadius: BorderRadius.circular(15.00),
                                ),
                                child:     Center(child: Image.asset("Assets/Bookmark.png",scale: 0.85,)),
                              ),
                              SizedBox(width: 10,),
                              new Container(
                                height: 27.00,
                                width: 76.00,
                                decoration: BoxDecoration(
                                  color: Color(0xffffffff),borderRadius: BorderRadius.circular(10.00),
                                ),
                                child: Center(
                                  child: new Text(
                                    "٢٥٪ خصم",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Tajawal",fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color:Color(0xff38056e),
                                    ),
                                  ),
                                ),
                              ),

                            ],

                          )),

                      Positioned(
                        bottom:0,
                        right: 0,
                        left: 0,
                        child:Container(
                          width:MediaQuery.of(context).size.width*0.6,
                          height: 110,
                          padding:EdgeInsets.all(16.0) ,
                          // margin: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Color.fromRGBO(34, 134, 234, .3),
                            //     blurRadius: 2,
                            //     offset: Offset(2, 1)
                            // )],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height:18,),
                             Row(
                               children: [
                                 SizedBox(width: 16,),
                                 new Text(
                                   "مطاعم البيك السعودية",
                                   textAlign: TextAlign.right,
                                   style: TextStyle(
                                     fontFamily: "Tajawal",
                                     fontSize: 13,
                                     color:Color(0xff242e42),
                                   ),
                                 ),
                               ],
                             ),
                             // SizedBox(height: 20,),
                              Row(
                                children: [
                                  new Text(
                                    "خصم ١٠٠ ريال سعودي",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontFamily: "Tajawal",fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color:Colors.black,
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      ClipSwitch(
                                        value: _bool,
                                        onChanged: _toggleBool,
                                        inactiveWidget: Container(
                                          alignment: Alignment.center,
                                          height: 34.00,
                                          width: 72.00,
                                          decoration: BoxDecoration(
                                            color: Color(0xff38056e),
                                            border: Border.all(width: 1.00, color: Color(0xff38056e),), borderRadius: BorderRadius.circular(22.00),
                                          ),
                                          child: Center(
                                            child: new Text(
                                              "نسخ الكود",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11,
                                                color:Color(0xffffffff),
                                              ),
                                            ),
                                          ) ,
                                        ),
                                        activeWidget: Container(
                                          alignment: Alignment.center,
                                            height: 34.00,
                                            width: 72.00,
                                            decoration: BoxDecoration(
                                              color: Color(0xffffffff),
                                              border: Border.all(width: 1.00, color: Color(0xff38056e),), borderRadius: BorderRadius.circular(22.00),
                                            ),
                                            child: Center(
                                              child: new Text(
                                                "DFD23322#",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 9,
                                                  color:Color(0xff38056e),
                                                ),
                                              ),
                                            )
                                        ),
                                      ),
                                      SizedBox(width: 6,),
                                      Image.asset('Assets/Send.png',scale: 0.8,)
                                      // new Container(
                                      //   height: 22.00,
                                      //   width: 60.00,
                                      //   decoration: BoxDecoration(
                                      //     color: Color(0xff38056e),
                                      //     border: Border.all(width: 1.00, color: Color(0xff38056e),), borderRadius: BorderRadius.circular(12.00),
                                      //   ),
                                      //   child: Center(
                                      //     child: new Text(
                                      //       "نسخ الكود",
                                      //       textAlign: TextAlign.center,
                                      //       style: TextStyle(
                                      //         fontWeight: FontWeight.w500,
                                      //         fontSize: 9,
                                      //         color:Color(0xffffffff),
                                      //       ),
                                      //     ),
                                      //   ) ,
                                      // ),
                                      // SizedBox(width: 8,),
                                      // new Container(
                                      //     height: 22.00,
                                      //     width: 60.00,
                                      //     decoration: BoxDecoration(
                                      //
                                      //       border: Border.all(width: 1.00, color: Color(0xff38056e),), borderRadius: BorderRadius.circular(12.00),
                                      //     ),
                                      //     child: Center(
                                      //       child: new Text(
                                      //         "DFD23322#",
                                      //         textAlign: TextAlign.center,
                                      //         style: TextStyle(
                                      //           fontWeight: FontWeight.w500,
                                      //           fontSize: 9,
                                      //           color:Color(0xff38056e),
                                      //         ),
                                      //       ),
                                      //     )
                                      // )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),),
                      ),
                      Positioned(
                        right: 20,
                        bottom: 85,
                        child: Container(
                          width: 48,
                          height: 48,
                          // margin: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(5.0),
                            image: DecorationImage(
                              image: AssetImage('Assets/download.png'),
                              fit: BoxFit.cover,
                            ),
                          ),),
                      ),
                    ],
                  )

              ),
            ),
          ) ),
    );
  }
}
