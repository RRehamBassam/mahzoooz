import 'package:animated_clipper/animated_clipper.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:mahzoooz/Widget/loading.dart';
import 'package:mahzoooz/api/NetworkRequest.dart';
import 'package:shimmer/shimmer.dart';
class RestaurantDataLoud extends StatefulWidget {

  @override
  _RestaurantDataState createState() => _RestaurantDataState();


}

class _RestaurantDataState extends State<RestaurantDataLoud> {

  var data;



  int _counter = 0;
  bool _bool = false;
  bool _enabled = true;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  NetworkRequest networkRequest=new NetworkRequest();
  void _toggleBool(bool newValue) {
    setState(() {
      _bool = newValue;
    });
  }
  @override
  Widget build(BuildContext context) {
    return   Column(
      //shrinkWrap: true,
        children: [    Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[200],
            highlightColor: Colors.grey[100],
            enabled: _enabled,
            child: Container(
              height: 203,
              child: Carousel(

                images: [
                  new Container(
                    height: 203.79,
                    width: MediaQuery.of(context).size.width,

                  ),
                  new Container(
                    height: 203.79,
                    width: MediaQuery.of(context).size.width,

                  ),
                  new Container(
                    height: 203.79,
                    width: MediaQuery.of(context).size.width,

                  ),       new Container(
                    height: 203.79,
                    width: MediaQuery.of(context).size.width,

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
          ),

          Positioned(
            child: Container(
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

                        ],
                      ),
                    ],
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
          ),

          Positioned(
            top: 190,
            bottom:0,
            child: new Container(
            //  margin:EdgeInsets.only(top:190) ,
             // height: MediaQuery.of(context).size.height,
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


                  SizedBox(height: 30,),
                  Box("وسائل الإتصال",Image.asset('Assets/Calling.png',color:  Color(0xff38056e),)),
                  SizedBox(height: 8,),
                  Box("ساعات العمل",Image.asset('Assets/Time Square.png',color:  Color(0xff38056e),)),
                  SizedBox(height: 8,),
                  Box("شروط الاستخدام وتفاصيل الخصم",Image.asset('Assets/Group 39851.png',color:  Color(0xff38056e),)),
                  SizedBox(height: 8,),
                  Box("الفروع المتاحة",Image.asset('Assets/Location.png',color:  Color(0xff38056e),)),
                  SizedBox(height: 8,),

                ],
              ),
            ),
          ),



        ],
      ),
    )])
    ;
  }
  Widget Box(String text,Widget widget){
    return     InkWell(

      child:    Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[100],
        enabled: _enabled,
        child: Container(
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
        ),
      ),
    );
  }
  BottomSheetExample(context,String text,data){
    return
      Container(
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
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Tajawal",fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color:Color(0xff3d3b39),
                  ),
                ),
              ),
              Container(
                height:130,
                width: 90,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(top: 16, bottom: 40),
                color: Colors.white,
                child:text=="ساعات العمل"? workHours(data):text=="وسائل الإتصال"?contacts(data):Column(
                  children: [
                    text=="ساعات العمل"?Text(
                      'يعمل الفرع في الاولاوقات التالية',
                      style: TextStyle(
                        fontFamily: 'DIN Next LT Arabic',
                        fontSize: 13,
                        color: const Color(0xffc8c7cc),
                      ),
                      textAlign: TextAlign.right,
                    ): Text(
                      '',
                      style: TextStyle(
                        fontFamily: 'DIN Next LT Arabic',
                        fontSize: 13,
                        color: const Color(0xffc8c7cc),
                      ),
                      textAlign: TextAlign.right,
                    ),
                    text=="ساعات العمل"? Text(
                      'يوميا من${data['to']} مساءا حتي ${data['from']} صباحا',
                      style: TextStyle(
                        fontFamily: 'DIN Next LT Arabic',
                        fontSize: 15,
                        color: const Color(0xff242e42),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.right,
                    ):Text(
                      '',
                      style: TextStyle(
                        fontFamily: 'DIN Next LT Arabic',
                        fontSize: 15,
                        color: const Color(0xff242e42),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.right,
                    ), // Row(
                    //   children: [
                    //     new Text(
                    //       text,
                    //       textAlign: TextAlign.right,
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.w500,
                    //         fontSize: 14,
                    //         color:Color(0xff040303).withOpacity(0.9),
                    //       ),
                    //     ),
                    //     Spacer(),
                    //     Icon(Icons.arrow_forward_ios,color: Color(0xffD9D9D9),size: 18,)
                    //   ],
                    // )
                  ],
                ),
              ),
              // GestureDetector(
              //   onTap:()=> {
              //     print("ooo"),
              //     Navigator.pop(context)},
              //   child: new Container(
              //     margin:EdgeInsets.only(right: 30, left: 30),
              //     width:20,
              //     height: 38,
              //     decoration: BoxDecoration(
              //       color: Color(0xff38056e),borderRadius: BorderRadius.circular(25.00),
              //     ),
              //     child: Center(
              //       child: new Text(
              //         "حفظ",
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //           fontWeight: FontWeight.w500,
              //           fontSize: 14,
              //           color:Color(0xffffffff),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
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
  Widget workHours(data){
    return Column(
      children: [
        Text(
          'يعمل الفرع في الاولاوقات التالية',
          style: TextStyle(
            fontFamily: 'DIN Next LT Arabic',
            fontSize: 13,
            color: const Color(0xffc8c7cc),
          ),
          textAlign: TextAlign.right,
        ),
        SizedBox(height: 6,),
        Text(
          'يوميا من${data['workHours'][0]['to'].toString()} مساءا حتي ${data['workHours'][0]['from'].toString()} صباحا'.toString(),
          style: TextStyle(
            fontFamily: 'DIN Next LT Arabic',
            fontSize: 15,
            color: const Color(0xff242e42),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.right,
        )
      ],
    );
  }
  Widget contacts(data){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "يمكنك الاتصال بالرقم التالي",
          style: TextStyle(
            fontFamily: 'DIN Next LT Arabic',
            fontSize: 15,
            color: const Color(0xffa9a7aa),
          ),
          textAlign: TextAlign.right,
        ),
        SizedBox(height: 6,),
        Text(
          '${data['contacts'][0]['mobile'].toString()}  '.toString(),
          style: TextStyle(
            fontFamily: 'DIN Next LT Arabic',
            fontSize: 15,
            color: const Color(0xff242e42),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.right,
        ),
        SizedBox(height: 6,),
        Text(
          '${data['contacts'][0]['phone'].toString()}'.toString(),
          style: TextStyle(
            fontFamily: 'DIN Next LT Arabic',
            fontSize: 15,
            color: const Color(0xff242e42),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.right,
        ),
        Text(
          'او عبر إيميل التالى',
          style: TextStyle(
            fontFamily: 'DIN Next LT Arabic',
            fontSize: 15,
            color: const Color(0xff242e42),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.right,
        ),
        Text(
          '${data['contacts'][0]['email'].toString()}'.toString(),
          style: TextStyle(
            fontFamily: 'DIN Next LT Arabic',
            fontSize: 15,
            color: const Color(0xff242e42),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}
