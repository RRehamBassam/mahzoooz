import 'package:animated_clipper/animated_clipper.dart';
import 'package:flutter/material.dart';

import 'package:localize_and_translate/localize_and_translate.dart';

import 'package:shimmer/shimmer.dart';
class ViewRestaurantDiscountsLoud extends StatefulWidget {


  @override
  _ViewRestaurantDiscountsState createState() => _ViewRestaurantDiscountsState();
}

class _ViewRestaurantDiscountsState extends State<ViewRestaurantDiscountsLoud> {


  bool _enabled = true;

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //  print(data['providerLogo']);print(data['offerImages'][0]['imageName']);

    //  bytes = convert.base64.decode(data['offerImages'][0]['imageName']);
    //bytes= convert.base64.decode(data['providerLogo']);

    return    Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        enabled: _enabled,
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

                              ],
                            ),
                            // SizedBox(height: 20,),
                            Row(
                              children: [

                                Spacer(),
                                Row(
                                  children: [

                                    SizedBox(width: 6,),


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
                    translator.currentLanguage == 'en' ?Positioned(
                      left:  20,
                      bottom: 85,
                      child: Container(
                        width: 48,
                        height: 48,
                        // margin: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(5.0),

                        ),
                        //  child: Image.memory(bytes),
                      ),
                    ): Positioned(
                      right:  20,
                      bottom: 85,
                      child: Container(
                        width: 48,
                        height: 48,
                        //  child: Image.memory(bytes),
                        // margin: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(5.0),

                        ),),
                    ),
                  ],
                )

            ),
          ),
        ) );
  }
}
