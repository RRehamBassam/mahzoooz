import 'package:animated_clipper/animated_clipper.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class RestaurantData extends StatefulWidget {
  @override
  _RestaurantDataState createState() => _RestaurantDataState();
}

class _RestaurantDataState extends State<RestaurantData> {
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
    return Scaffold(
      backgroundColor:Color(0xffffffff),
      body: Stack(
        children: [
          Container(
            height: 203,
            child: Carousel(

              images: [
                new Container(
                  height: 203.79,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('Assets/ModalPanel.png',),
                    ),
                    //border: Border.all(width: 1.00, color: Color(0xfff5f5f5).withOpacity(0.4),), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.00), bottomRight: Radius.circular(12.00), ),
                  ),
                ),
                new Container(
                  height: 203.79,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('Assets/ModalPanel.png',),
                    ),
                  //  border: Border.all(width: 1.00, color: Color(0xfff5f5f5).withOpacity(0.4),), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.00), bottomRight: Radius.circular(12.00), ),
                  ),
                ),
                new Container(
                  height: 203.79,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('Assets/ModalPanel.png',),
                    ),
                  //  border: Border.all(width: 1.00, color: Color(0xfff5f5f5).withOpacity(0.4),), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.00), bottomRight: Radius.circular(12.00), ),
                  ),
                ),       new Container(
                  height: 203.79,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('Assets/ModalPanel.png',),
                    ),
                 //   border: Border.all(width: 1.00, color: Color(0xfff5f5f5).withOpacity(0.4),), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.00), bottomRight: Radius.circular(12.00), ),
                  ),
                ),
              ],
              dotSize: 8,
              dotIncreaseSize: 1.5,
              dotSpacing: 20,
              dotColor: Colors.white.withOpacity(0.9),
              dotBgColor: Colors.black.withOpacity(0.0),
              boxFit: BoxFit.cover,
              dotIncreasedColor:  Color(0xffffffff),
            ),
          ),

          Positioned(
               child: Stack(
                 children: [
                   Container(
                     height: MediaQuery.of(context).size.height*0.2,
                     child: Stack(
                       children: [
                         Column(
                           children: [
                             SizedBox(height: 50,),
                             Row(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 new Text(
                                   "مطاعم البيك",
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                 fontWeight: FontWeight.w700,
                                     fontSize: 14,
                                     color:Color(0xffffffff),
                                   ),
                                 )
                               ],
                             ),
                           ],
                         ),
                         Positioned(
                           left: 40,
                           top: 47,
                           child: Row(
                             children: [
                               Material(
                                 borderRadius:  BorderRadius.circular(15.00),
                                 elevation: 5,
                                 child: new Container(
                                   height: 25.00,
                                   width: 25.00,
                                   decoration: BoxDecoration(
                                     color: Color(0xffffffff),borderRadius: BorderRadius.circular(15.00),
                                   ),
                                   child:     Center(child: Image.asset("Assets/Upload.png",scale: 0.85,)),
                                 ),
                               ),
                               SizedBox(width: 10,),
                               Material(
                                 borderRadius:  BorderRadius.circular(15.00),
                                 elevation: 5,
                                 child: new Container(
                                   height: 25.00,
                                   width: 25.00,
                                   decoration: BoxDecoration(
                                     color: Color(0xffffffff),borderRadius: BorderRadius.circular(15.00),
                                   ),
                                   child:     Center(child: Image.asset("Assets/Bookmark.png",scale: 0.85,)),
                                 ),
                               ),

                             ],
                           ),
                         ),
                         Positioned(
                           right: 40,
                           top: 50,
                           child: Row(
                             children: [
                               Center(child: Image.asset("Assets/IconLeft.png",)),
                               SizedBox(width: 10,),
                             ],
                           ),
                         ),
                       ],
                     ),
                   ),

                 ],
               ),
             ),

          Positioned(
            top: 190,
             bottom:0,
            child: Expanded(
              flex: 4,
              child: new Container(
                margin:EdgeInsets.only(top:190) ,
                height: 800,
                width:  MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(bottom: 16,right: 16,left: 16,top: 4) ,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.white,  Color(0xffffffff).withOpacity(0.9)],
                      tileMode: TileMode.clamp,
                      begin: Alignment.topCenter,
                      stops: [0.0, 1.0],
                      end: Alignment.bottomCenter),
                  //color: Color(0xffffffff).withOpacity(0.9),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.00,3.00),
                      color: Color(0xff000000).withOpacity(0.16),
                      blurRadius: 16,
                    ),
                  ], borderRadius: BorderRadius.only(topLeft: Radius.circular(16.00), topRight: Radius.circular(16.00), ),
                ),
                child:ListView(
                  children: [
                  //  SizedBox(height: 8,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:MainAxisAlignment.start ,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: new Text(
                            "مطاعم البيك السعودية",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color:Color(0xff242e42),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8,),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star,color:Color(0xff38056e) ,),
                        new Text(
                          "4.9",
                          style: TextStyle(
                            fontFamily: "DIN Next LT Arabic",
                            fontSize: 15,
                            color:Color(0xffc8c7cc),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    new Text(
                      "استعمل مؤخرا منذ دقيقه",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                     fontWeight: FontWeight.w500,
                        fontSize: 7,
                        color:Color(0xff909090),
                      ),
                    )
                  ],
                ),
                    SizedBox(height: 8,),
                    new Text(
                      '''Lorem Ipsum is simply dummy text of the printing and typesetting , ot only five centuries, but also the lith the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including v''',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color:Color(0xff909090),
                      ),
                    ),
                    SizedBox(height: 8,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.88,
                      height: 1,
                    ),
                    SizedBox(height: 8,),
                    Row(
                      children: [
                        new Text(
                          "خصم ١٠٠ ريال سعودي علي اي طلب",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color:Color(0xffc8c7cc),
                          ),
                        ),
                  Spacer(),
                        // Row(
                        //   children: [
                        //     ClipSwitch(
                        //       value: _bool,
                        //       onChanged: _toggleBool,
                        //       inactiveWidget: Container(
                        //         alignment: Alignment.center,
                        //         height: 34.00,
                        //         width: 72.00,
                        //         decoration: BoxDecoration(
                        //           color: Color(0xff38056e),
                        //           border: Border.all(width: 1.00, color: Color(0xff38056e),), borderRadius: BorderRadius.circular(22.00),
                        //         ),
                        //         child: Center(
                        //           child: new Text(
                        //             "نسخ الكود",
                        //             textAlign: TextAlign.center,
                        //             style: TextStyle(
                        //               fontWeight: FontWeight.w500,
                        //               fontSize: 11,
                        //               color:Color(0xffffffff),
                        //             ),
                        //           ),
                        //         ) ,
                        //       ),
                        //       activeWidget: Container(
                        //           alignment: Alignment.center,
                        //           height: 34.00,
                        //           width: 72.00,
                        //           decoration: BoxDecoration(
                        //             color: Color(0xffffffff),
                        //             border: Border.all(width: 1.00, color: Color(0xff38056e),), borderRadius: BorderRadius.circular(22.00),
                        //           ),
                        //           child: Center(
                        //             child: new Text(
                        //               "DFD23322#",
                        //               textAlign: TextAlign.center,
                        //               style: TextStyle(
                        //                 fontWeight: FontWeight.w500,
                        //                 fontSize: 9,
                        //                 color:Color(0xff38056e),
                        //               ),
                        //             ),
                        //           )
                        //       ),
                        //     ),
                        //   ],
                        // ),


                      ],
                    ),

                    SizedBox(height: 16,),
                    Box("ساعات العمل",Image.asset('Assets/Calling.png',color:  Color(0xff38056e),),),
                    SizedBox(height: 4,),
                    Box("شروط الاستخدام وتفاصيل الخصم",Image.asset('Assets/Time Square.png',color:  Color(0xff38056e),),),
                    SizedBox(height: 4,),
                    Box("الفروع المتاحة",Image.asset('Assets/Group 39851.png',color:  Color(0xff38056e),),),
                    SizedBox(height: 4,),
                    Box("القائمة",Image.asset('Assets/Location.png',color:  Color(0xff38056e),),),
                    SizedBox(height: 4,),
                    Box("خدمة الحجز",Image.asset('Assets/Document.png',color:  Color(0xff38056e),),),
                    SizedBox(height: 4,),
                    Box("كوبون الخصم للمدرسه",Image.asset('Assets/Bag 2.png',color:  Color(0xff38056e),),),
                    SizedBox(height: 4,),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 22,
            top: 170,
            child: Material(
              borderRadius:  BorderRadius.circular(6.00),
              elevation: 5,
              child: Container(
                width: 42,
                height: 42,
                // margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    image: AssetImage('Assets/download.png'),
                    fit: BoxFit.cover,
                  ),
                ),),
            ),
          ),
          Positioned(
            left: 22,
            top: 178,

            child:Container(
              height: 27.00,
              width: 76.00,
              decoration: BoxDecoration(
                color: Color(0xffffffff),borderRadius: BorderRadius.circular(12.00),
              ),
              child: Material(
                borderRadius:  BorderRadius.circular(12.00),
                elevation: 5,
                child: Container(
                  height: 27.00,
                  width: 76.00,
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),borderRadius: BorderRadius.circular(12.00),
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
              ),
            ),
          ),

        ],
      ),
    );
  }
  Widget Box(String text,Widget widget){
    return           Container(
      decoration: BoxDecoration(
        color: Color(0xffffffff),borderRadius: BorderRadius.circular(11.00),
      ),
      margin:EdgeInsets.all(2) ,
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(11.00),
        child: new Container(
          height: 59.00,

          width: MediaQuery.of(context).size.width*0.82,
          padding:EdgeInsets.symmetric(vertical: 8,horizontal: 12) ,
          decoration: BoxDecoration(
            color: Color(0xffffffff),borderRadius: BorderRadius.circular(11.00),
          ),
          child: Row(
            children: [

              widget,
              SizedBox(width: 16,),
              new Text(
                text,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color:Color(0xff040303).withOpacity(0.9),
                ),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios,color: Color(0xffD9D9D9),size: 18,)

            ],
          ),
        ),
      ),
    );
  }
}
