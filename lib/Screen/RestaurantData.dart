import 'dart:io';

import 'package:animated_clipper/animated_clipper.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mahzoooz/Screen/Map.dart';
import 'package:mahzoooz/Screen/ReservationService.dart';
import 'package:mahzoooz/Widget/loading.dart';
import 'package:mahzoooz/api/NetworkRequest.dart';
import 'package:mahzoooz/Widget/RestaurantDataLoud.dart';
import 'package:mahzoooz/services/helperFunctions.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:typed_data';
import 'dart:convert' as convert;
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:mahzoooz/Widget/ImageItem.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:mahzoooz/Screen/CouponDiscount.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_share/flutter_share.dart';
class RestaurantData extends StatefulWidget {
  var data;
  @override
  _RestaurantDataState createState() => _RestaurantDataState(data);

  RestaurantData(this.data);
}

class _RestaurantDataState extends State<RestaurantData> {


var data;
  _RestaurantDataState(this.data);

  int _counter = 0;
  bool _bool = false;

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
  Uint8List bytes; Uint8List bytesback;Uint8List bytesMenu;

  @override
  void initState() {
    gettoken();

    initPage=false;
    // TODO: implement initState
    super.initState();
  }
List dataS =[]; //edited line

Future<String> getSWData(id) async {
  await HelperFunctions.getUserEmailSharedPreference().then((value){
    token  = value ;
  });
  HttpClient client = new HttpClient();
  client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
  var itemCount ;
  HttpClientRequest request = await client.getUrl(Uri.parse("http://ahmed453160-001-site1.etempurl.com/SchoolStages/GetAllStagesBySchoolType/$id"));
  request.headers.set('content-type', 'application/json');
  // request.headers.set('content-type', 'application/json');
  request.headers.set('Authorization', 'Bearer $token');
  // request.add(convert.utf8.encode(convert.json.encode(map)));
  HttpClientResponse response = await request.close();
  String reply = await response.transform(convert.utf8.decoder).join();
  print(response.statusCode);
  print(reply);
  var jsonResponse = convert.jsonDecode(reply);

  //return jsonResponse['data'];
  // var res = await http
  //     .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
  // var resBody = json.decode(res.body);
  // print(resBody);
  setState(() {
    dataS = jsonResponse['data'];
    // newStudentsid==data[0]["id"];
    // newStudentsNameid=data[0]["nameAr"];
  });
  print(data);

  return "Sucess";
}
bool initPage;
Future<void> share() async {
  await FlutterShare.share(
      title: 'Example share',
      text: 'Example share text',
      linkUrl: data['webSite'],
      chooserTitle: 'Example Chooser Title');
}
  var token;
  void gettoken()async{
    await HelperFunctions.getUserEmailSharedPreference().then((value){
      token  = value ;
    });
  }
  @override
  Widget build(BuildContext context) {
    final fifteenAgo = new DateTime.now().subtract(new Duration(minutes: 15));
    print(timeago.format(fifteenAgo));
   // DateTime time = DateTime.parse('2021-04-28T01:31:35.3605982');
    // print(timeago.format(time));
    return Scaffold(
      backgroundColor:Color(0xffffffff),
      body: FutureBuilder<dynamic>(
      future: networkRequest.OfferGetDetails(data['id']),
    builder: (context, snapshot) {
    if (snapshot.hasData) {
      if(snapshot.data['offer']['providerNameAr'].toString().split(' ')[0]=='مدرسة'){
        if(!initPage) {

                  getSWData(1);
                  initPage=true;
                }
              }

    //  time = DateTime.parse(data['lastDate']);
      if(snapshot.data['offer']['providerLogo']!= null)
      {bytes= convert.base64.decode(snapshot.data['offer']['providerLogo'].split(',').last);}
      if(snapshot.data['offer']['offerImages'][0]['imageName']!=null)
      {  bytesback= convert.base64.decode(snapshot.data['offer']['offerImages'][0]['imageName'].split(',').last);}
      if(snapshot.data['menu']!= null)
      {bytesMenu= convert.base64.decode(snapshot.data['menu'].split(',').last);}
    return     Column(
      //shrinkWrap: true,
        children: [   Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(
          children: [
            Container(
              height: 203,
              child: Carousel(

                images: [
            //       snapshot.data['offerImages'].map((name) {
            // return  ImageItem(name);
            // },
            //       ),
                  new Container(
                    height: 203.79,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: MemoryImage(bytesback),
                      ),
                      //border: Border.all(width: 1.00, color: Color(0xfff5f5f5).withOpacity(0.4),), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.00), bottomRight: Radius.circular(12.00), ),
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
                               new Text(
                                 snapshot.data['offer']['providerNameAr'] ==null? "مطاعم البيك السعودية":translator.currentLanguage == 'ar' ? snapshot.data['offer']['providerNameAr']:snapshot.data['offer']['providerNameEn'],
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
                         child: InkWell(
                           onTap: (){
                             share();
                           },
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
                                   child:      Center(child:Icon(Icons.reply_outlined,color:Color(0xff38056e),size: 18,) ),// Center(child: Image.asset("Assets/Upload.png",scale: 0.85,)),
                                 ),
                               ),
                               SizedBox(width: 10,),
                               InkWell(
                                 onTap: ()async{
                                   if(token==null){
                                     Fluttertoast.showToast(
                                         msg: "يجب عليك تسجيل الدخول",
                                         toastLength: Toast.LENGTH_SHORT,
                                         gravity: ToastGravity.BOTTOM,
                                         timeInSecForIosWeb: 1,
                                         backgroundColor: Color(0xff38056e).withOpacity(0.9),
                                         textColor: Colors.white,
                                         fontSize: 16.0
                                     );
                                   }else{
                                     await addFavourites();
                                     if(message=="Data Inserted Successfully"){
                                       Fluttertoast.showToast(
                                           msg:translator.currentLanguage == 'ar' ?"تم إضافة للمفضلة بنجاح": message,
                                           toastLength: Toast.LENGTH_SHORT,
                                           gravity: ToastGravity.BOTTOM,
                                           timeInSecForIosWeb: 1,
                                           backgroundColor: Color(0xff38056e).withOpacity(0.9),
                                           textColor: Colors.white,
                                           fontSize: 16.0
                                       );
                                     }else{
                                       Fluttertoast.showToast(
                                           msg: message,
                                           toastLength: Toast.LENGTH_SHORT,
                                           gravity: ToastGravity.BOTTOM,
                                           timeInSecForIosWeb: 1,
                                           backgroundColor: Color(0xff38056e).withOpacity(0.9),
                                           textColor: Colors.white,
                                           fontSize: 16.0
                                       );

                                     }
                                   }


                                 },
                                 child: Material(
                                   borderRadius:  BorderRadius.circular(15.00),
                                   elevation: 5,
                                   child: new Container(
                                     height: 25.00,
                                     width: 25.00,
                                     decoration: BoxDecoration(
                                       color: Color(0xffffffff),borderRadius: BorderRadius.circular(15.00),
                                     ),
                                     child:     Center(child:Icon(Icons.favorite_border,color:Color(0xff38056e),size: 20,)),
                                   ),
                                 ),
                               ),

                             ],
                           ),
                         ),
                       ),
                       Positioned(
                         right: 40,
                         top: 50,
                         child: InkWell(
                           onTap: ()=>Navigator.pop(context),
                           child: Row(
                             children: [
                               Center(child: Image.asset("Assets/IconLeft.png",)),
                               SizedBox(width: 10,),
                             ],
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
               ),

            Positioned(
              top: 190,
               bottom:0,
              child:   Directionality(
                textDirection:translator.currentLanguage == 'ar' ? TextDirection.rtl:TextDirection.ltr,
                child: new Container(
                 // margin:EdgeInsets.only(top:190) ,
                 // height: MediaQuery.of(context).size.height*0.9,
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
                            alignment:translator.currentLanguage == 'ar' ? Alignment.centerRight:Alignment.centerLeft,
                            child: new Text(
                              snapshot.data['offer']['providerNameAr'] ==null? "مطاعم البيك السعودية":translator.currentLanguage == 'ar' ? snapshot.data['offer']['providerNameAr']:snapshot.data['offer']['providerNameEn'],
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
                      InkWell(onTap: (){
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => SingleChildScrollView(
                            child: Container(
                              decoration: BoxDecoration(
                                color:Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),

                              padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: BottomSheetExampleRate(context,"text",data,snapshot.data['offer']),
                            ),
                          ),
                        );
                      },
                        child: Row(
                          children: [
                            Icon(Icons.star,color:Color(0xff38056e) ,),
                            new Text(
                              snapshot.data['offer']['rate'] .toString(),
                              style: TextStyle(

                                fontSize: 15,
                                color:Color(0xffc8c7cc),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 60,),
                      snapshot.data['offer']['providerNameAr'].toString().split(' ')[0]=='مدرسة' ?Text(
                        "للبنين",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color:Color(0xff080700),
                        ),
                      ):Container(),
                      Spacer(),
                      snapshot.data['offer']['providerNameAr'].toString().split(' ')[0]=='مدرسة' ?Container():    Row(
                        children: [
                          new Text(//{data['lastDate'].toString().split('T')[1]}
                            "استعمل مؤخراً منذ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color:Color(0xff909090),
                            ),
                          ),
                          // new Text(//{data['lastDate'].toString().split('T')[1]}
                          //   " ${timeago.format(time)}",
                          //   textAlign: TextAlign.center,
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.w500,
                          //     fontSize: 10,
                          //     color:Color(0xff909090),
                          //   ),
                          // ),

                        ],
                      ),
                      // new Text(
                      //   translator.currentLanguage == 'ar' ? "استعمل مؤخرا ${data['lastDate'].toString().split('T')[1]}":"Recently used ${data['lastDate'].toString().split('T')[1]}",
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //  fontWeight: FontWeight.w500,
                      //     fontSize: 7,
                      //     color:Color(0xff909090),
                      //   ),
                      // )
                    ],
                  ),
                      SizedBox(height: 8,),
                      new Text(
                        translator.currentLanguage == 'ar' ? snapshot.data['offer']['descriptionAr']: snapshot.data['offer']['descriptionEn'],
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
                            snapshot.data['offer']['titeAr']==null? "خصم ١٠٠ ريال سعودي":translator.currentLanguage == 'ar' ?snapshot.data['offer']['titeAr']:snapshot.data['offer']['titleEn'],
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
                      Box("وسائل الإتصال",Image.asset('Assets/Calling.png',color:  Color(0xff38056e),),snapshot.data,data),
                      SizedBox(height: 4,),
                      Box("ساعات العمل",Image.asset('Assets/Time Square.png',color:  Color(0xff38056e),),snapshot.data,data),
                      SizedBox(height: 4,),
                      Box("شروط الاستخدام وتفاصيل الخصم",Image.asset('Assets/Group 39851.png',color:  Color(0xff38056e),),snapshot.data,data),
                      SizedBox(height: 4,),
                      Box("الفروع المتاحة",Image.asset('Assets/Location.png',color:  Color(0xff38056e),),snapshot.data,data),
                      SizedBox(height: 4,),
                      snapshot.data['offer']['providerNameAr'].toString().split(' ')[0]=='مدرسة' ?Box("مراحل",Image.asset('Assets/Document.png',color:  Color(0xff38056e),),snapshot.data,data) :snapshot.data['menu']!=null?Box("القائمة",Image.asset('Assets/Document.png',color:  Color(0xff38056e),),snapshot.data,data):Container(),
                      SizedBox(height: 4,),
                      snapshot.data['branches'][0]['hasBooking'] && snapshot.data['bookingSettings'].length!=0? Box("خدمة الحجز",Image.asset('Assets/Bag 2.png',color:  Color(0xff38056e),),snapshot.data,data):Container(),//"كوبون الخصم للمدرسه"
                      snapshot.data['branches'][0]['hasBooking']&&snapshot.data['bookingSettings'].length!=0?SizedBox(height: 4,):Container(),
                      snapshot.data['offer']['providerNameAr'].toString().split(' ')[0]=='مدرسة' ?Box("كوبون الخصم للمدرسة",Image.asset('Assets/Bag 2.png',color:  Color(0xff38056e),),snapshot.data,data):Container(),

                         ],
                  ),
                ),
              ),
            ),
            snapshot.data['offer']['providerLogo']==null?Container(): translator.currentLanguage == 'ar' ?   Positioned(
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
                      image: MemoryImage(bytes),
                      fit: BoxFit.cover,
                    ),
                  ),),
              ),
            ): Positioned(
              left: 22,
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
                      image: MemoryImage(bytes),
                      fit: BoxFit.cover,
                    ),
                  ),),
              ),
            ),
            snapshot.data['offer']['providerNameAr'].toString().split(' ')[0]=='مدرسة' ?Container():   translator.currentLanguage == 'ar' ?snapshot.data['offer']['discount'].toString().split('.')[0]==0?Container():  Positioned(
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
                        " %${snapshot.data['offer']['discount'].toString().split('.')[0]} خصم ",
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
            ):snapshot.data['offer']['discount'].toString().split('.')[0]==0?Container():Positioned(
              right: 22,
              top: 178,

              child:Container(
                height: 27.00,
                width: 89.00,
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
                        " %${snapshot.data['offer']['discount'].toString().split('.')[0]} Discount ",
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
    )]);}
    else if (snapshot.hasError) {
      return Center(child: Text("تأكد من إتصال بالإنرنت"));
    }
    return RestaurantDataLoud();}),
    );
  }
  //  snapshot.data['branches'][0]['hasBooking']
  Widget Box(String text,Widget widget,data,dataRestaurantData){
    return     InkWell(
      onTap:(){
        if(text=="خدمة الحجز"){
          print("${data['offer']['id']}  id");
          Navigator.push(context,PageTransition(
            type: PageTransitionType.bottomToTop,
            duration: Duration(milliseconds: 550) ,
            reverseDuration: Duration(milliseconds: 700),
            child:ReservationService(data['bookingSettings'],data['offer']['id'],dataRestaurantData),
          ),);
        } else  if(text=="كوبون الخصم للمدرسة"){
          print("${data['offer']['id']}  id");
          Navigator.push(context,PageTransition(
            type: PageTransitionType.bottomToTop,
            duration: Duration(milliseconds: 550) ,
            reverseDuration: Duration(milliseconds: 700),
            child:CouponDiscount(data),
          ),);
        }else
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),

              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: BottomSheetExample(context,text,data,),
            ),
          ),
        );
      },
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
    );
  }
  var rate;
  var comment;
BottomSheetExampleRate(context,String text,data,dataoffer){
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
              child: // Adobe XD layer: 'How is your trip?' (text)
              Text(
                'كيف كانت تجربتك ؟',
                style: TextStyle(
                  fontSize: 24,
                  color: const Color(0xff242e42),
                  letterSpacing: 0.2894117431640625,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              //  height:342,
              width: 90,
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(top: 16, bottom: 20),
              color: Colors.white,
              child:Column(
                children: [
                  // Adobe XD layer: 'Your feedback will h' (text)
                  Text(
                    'ساعدنا على تقييم منتجاتنا برجاء تقييم عروضنا و مقدمينها .. و شكرا',
                    style: TextStyle(
                      fontFamily: 'DIN Next LT Arabic',
                      fontSize: 17,
                      color: const Color(0xff8a8a8f),
                      letterSpacing: 0.41000000190734864,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.15,
                    child: Center(
                      child: RatingBar.builder(
                        initialRating: 1,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        glowColor:Color(0xff38056e).withOpacity(0.1),
                        unratedColor:Colors.grey.withOpacity(0.1) ,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Color(0xff38056e),
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            rate=rating;
                          });
                          print(rating);
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.15,
                    width:MediaQuery.of(context).size.width*0.9,
                    child: TextFormField(//onChanged: (val)=>setState((){searchWord=val;}),
                      cursorColor: Color(0xff38056e),
                      keyboardType:TextInputType.text,
                      autofocus: false,
                      textAlign: TextAlign.right,//(val)=>setState(()=>Name=val)
                      onChanged:(val){
                        setState(() {
                          comment=val;
                        });
                      },
                      // controller:controller ,
                      minLines: 3,
                      maxLines: 6,

                      obscureText: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(width: 0.5,color: Colors.grey[300]),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(width: 0.5,color:Color(0xff38056e))
                          ),
                          filled: true,
                          fillColor: Color(0xFFF8F8F8).withOpacity(0.7),
                          // prefixIcon:tajerAccount?Image.asset("Assets/icon-store.png",color:Color(0xfff99b1d),):Image.asset("Assets/icon-account.png") ,

                          hintText:"إضافة تعليق",

                          // icon:tajerAccount?Image.asset("Assets/icon-store.png",color:Color(0xfff99b1d),):Image.asset("Assets/icon-account.png") ,
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color:Color(0xff5e5e5e).withOpacity(0.48),
                          ),
                          labelStyle: null
                      ),

                    ),
                  ),
                  InkWell(
                    onTap:()=> { Navigator.pop(context),
                      if(rate!=null)
                        {

                          addRate(comment,rate.toString() , dataoffer['id']),
                Fluttertoast.showToast(
                    msg:Ratemessage==null?"حاول مرة اخرى": Ratemessage,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Color(0xff38056e).withOpacity(0.9),
                    textColor: Colors.white,
                    fontSize: 16.0
                ),

                        },

                    },
                    child: new Container(
                      margin:EdgeInsets.only(right: 30, left: 30),
                      width:MediaQuery.of(context).size.width*0.67,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Color(0xff38056e),borderRadius: BorderRadius.circular(25.00),
                      ),
                      child: Center(
                        child: new Text(
                          "إرسال",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color:Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
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
                height:text=="الفروع المتاحة"?356:text=="القائمة"?456:text=="مراحل"?230:142,
                width: 90,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(top: 16, bottom: text=="الفروع المتاحة"?6:16),
                color: Colors.white,
               child:text=="ساعات العمل"? workHours(data):text=="وسائل الإتصال"?contacts(data):text=="الفروع المتاحة"?Branches(data):text=="مراحل"?SchoolStages(data):text=="القائمة"?menu(data):text=="شروط الاستخدام وتفاصيل الخصم"?condition(data):Column(
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
            data.length==0?'' :  'يوميا من${data['to']} مساءا حتي ${data['from']} صباحا',
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

              fontSize: 15,
              color: const Color(0xff242e42),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
                 ],
               ),
              ),

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
    data['workHours'].length==0?'' :'يوميا من${data['workHours'][0]['from'].toString()} مساءا حتي  صباحا${data['workHours'][0]['to'].toString()}'.toString(),
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
  Widget Branches(data){
    return Container(
      height: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data['branches'][0]['nameAr'],
            style: TextStyle(
              fontFamily: 'DIN Next LT Arabic',
              fontSize: 15,
              color: const Color(0xffa9a7aa),
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(height: 6,),
          Text(
            'فيس بوك',
            style: TextStyle(
              fontFamily: 'DIN Next LT Arabic',
              fontSize: 15,
              color: const Color(0xffa9a7aa),
            ),
            textAlign: TextAlign.right,
          ),
          InkWell(
            onTap: () => setState(() {
              launch(data['branches'][0]['facebook']);

            }),
            child: Row(children: [
              Text(
                data['branches'].length==0?'' :'${data['branches'][0]['facebook'].toString()}  '.toString(),
                style: TextStyle(
                  fontFamily: 'DIN Next LT Arabic',
                  fontSize: 15,
                  color: const Color(0xff242e42),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.right,
              ),

            ],),
          ),

          SizedBox(height: 6,),
          Text(
            'تويتر',
            style: TextStyle(
              fontFamily: 'DIN Next LT Arabic',
              fontSize: 15,
              color: const Color(0xffa9a7aa),
            ),
            textAlign: TextAlign.right,
          ),
          InkWell(
            onTap: () => setState(() {
              launch(data['branches'][0]['twitter']);

            }),
            child: Row(children: [
              Text(
                data['branches'].length==0?'' : '${data['branches'][0]['twitter'].toString()}'.toString(),
                style: TextStyle(

                  fontSize: 15,
                  color: const Color(0xff242e42),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.right,
              ),

            ],),
          ),
          Text(
            'إنستجرام',
            style: TextStyle(
              fontFamily: 'DIN Next LT Arabic',
              fontSize: 15,
              color: const Color(0xffa9a7aa),
            ),
            textAlign: TextAlign.right,
          ),
          InkWell(
            onTap: () => setState(() {
              launch(data['branches'][0]['instagram']);

            }),
            child: Row(children: [
              Text(
                data['branches'].length==0?'' : '${data['branches'][0]['instagram'].toString()}'.toString(),
                style: TextStyle(

                  fontSize: 15,
                  color: const Color(0xff242e42),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.right,
              ),

            ],),
          ),
          Text(
            'سناب شات',
            style: TextStyle(
              fontFamily: 'DIN Next LT Arabic',
              fontSize: 15,
              color: const Color(0xffa9a7aa),
            ),
            textAlign: TextAlign.right,
          ),
          InkWell(
            onTap: () => setState(() {
              launch(data['branches'][0]['snapchat']);

            }),
            child: Row(children: [
              Text(
                data['branches'].length==0?'' : '${data['branches'][0]['snapchat'].toString()}'.toString(),
                style: TextStyle(

                  fontSize: 15,
                  color: const Color(0xff242e42),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.right,
              ),

            ],),
          ),
          Text(
            ' تيك توك',
            style: TextStyle(
              fontFamily: 'DIN Next LT Arabic',
              fontSize: 15,
              color: const Color(0xffa9a7aa),
            ),
            textAlign: TextAlign.right,
          ),
          InkWell(
            onTap: () => setState(() {
              launch(data['branches'][0]['tikTok']);

            }),
            child: Row(children: [
              Text(
                data['branches'].length==0?'' : '${data['branches'][0]['tikTok'].toString()}'.toString(),
                style: TextStyle(

                  fontSize: 15,
                  color: const Color(0xff242e42),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.right,
              ),

            ],),
          ),
          Text(
            ' يوتيوب',
            style: TextStyle(
              fontFamily: 'DIN Next LT Arabic',
              fontSize: 15,
              color: const Color(0xffa9a7aa),
            ),
            textAlign: TextAlign.right,
          ),
          InkWell(
            onTap: () => setState(() {
              launch(data['branches'][0]['youtube']);

            }),
            child: Row(children: [
              Text(
                data['branches'].length==0?'' : '${data['branches'][0]['youtube'].toString()}'.toString(),
                style: TextStyle(

                  fontSize: 15,
                  color: const Color(0xff242e42),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.right,
              ),

            ],),
          ),
          SizedBox(height: 16,),
          InkWell(
            onTap: (){
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new maps(data['branches'][0]['latitude'],data['branches'][0]['longitude'])));
            },
            child: Row(
              children: [
                Spacer(),
                Icon(Icons.location_on,color: Color(0xff38056e),size: 18,),
                SizedBox(width: 8,),
                Text(
                  'الحصول على اتجاهات',
                  style: TextStyle(

                    fontSize: 8,
                    color: Color(0xff38056e),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          )

        ],
      ),
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
        Row(children: [
          Text(
            data['contacts'].length==0?'' :'${data['contacts'][0]['mobile'].toString()}  '.toString(),
            style: TextStyle(
              fontFamily: 'DIN Next LT Arabic',
              fontSize: 15,
              color: const Color(0xff242e42),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          Spacer(),
          InkWell(
            onTap: (){
              customLaunch('tel:${data['contacts'][0]['mobile']}');
            },
            child: Row(
              children: [
                Icon(Icons.call,size: 18,color:Color(0xff38056e)),
                SizedBox(width: 4,),
                Text(
                  'اتصل الآن ',
                  style: TextStyle(

                    fontSize: 13,
                    color: const Color(0xff38056e),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          )
        ],),

        SizedBox(height: 6,),
        Row(children: [
          Text(
            data['contacts'].length==0?'' : '${data['contacts'][0]['phone'].toString()}'.toString(),
            style: TextStyle(

              fontSize: 15,
              color: const Color(0xff242e42),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
// Spacer(),
//           InkWell(
//             onTap: (){
//               customLaunch('tel:${data['contacts'][0]['phone']}');
//             },
//             child: Row(
//               children: [
//                 Icon(Icons.call,size: 18,color:Color(0xff38056e)),
//                 SizedBox(width: 4,),
//                 Text(
//                   'اتصل الآن ',
//                   style: TextStyle(
//
//                     fontSize: 13,
//                     color: const Color(0xff38056e),
//                     fontWeight: FontWeight.w700,
//                   ),
//                   textAlign: TextAlign.right,
//                 ),
//               ],
//             ),
//           )
        ],),

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
      Row(
        children: [
          Text(
            data['contacts'].length==0?'' : '${data['contacts'][0]['email'].toString()}'.toString(),
            style: TextStyle(
              fontFamily: 'DIN Next LT Arabic',
              fontSize: 15,
              color: const Color(0xff242e42),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          Spacer(),
          InkWell(
            onTap: (){
              customLaunch('mailto:${data['contacts'][0]['email']}');
            },
            child: Row(
              children: [
                Icon(Icons.email,size: 18,color: Color(0xff38056e),),
                SizedBox(width: 4,),
                Text(
                  'ارسل الآن ',
                  style: TextStyle(

                    fontSize: 13,
                    color: const Color(0xff38056e),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          )

        ],
      )
      ],
    );
  }
  Widget menu(data){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        data['menu']==null?Container():  Container(
          height: 433.79,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
    borderRadius: BorderRadius.all(
    Radius.circular(5.0),

    ),
            image: DecorationImage(

              fit: BoxFit.fill,
              image: MemoryImage(bytesMenu),
            ),
            //border: Border.all(width: 1.00, color: Color(0xfff5f5f5).withOpacity(0.4),), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.00), bottomRight: Radius.circular(12.00), ),
          ),
        ),

      ],
    );
  }
  Widget condition(data){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        data['offer']['notesAr']==null?Container():Column(
          children: [
            Text(
              translator.currentLanguage == 'ar' ? '${data['offer']['notesAr']}':'${data['offer']['notesEn']}',
              style: TextStyle(
               // fontFamily: 'DIN Next LT Arabic',
                fontSize: 15,
                color: const Color(0xff242e42),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),

      ],
    );
  }
  Widget SchoolStages(data){
    return  Column(
      children: [
        // Text(
        //   'مراحل',
        //   style: TextStyle(
        //     fontFamily: 'DIN Next LT Arabic',
        //     fontSize: 13,
        //     color: const Color(0xffc8c7cc),
        //   ),
        //   textAlign: TextAlign.right,
        // ),
        SizedBox(height: 6,),
        // Text(
        //   '${data['branches'][0]['schoolStages']}',
        //     style: TextStyle(
        //     fontFamily: 'DIN Next LT Arabic',
        //     fontSize: 15,
        //     color: const Color(0xff242e42),
        //     fontWeight: FontWeight.w700,
        //   ),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 16),
            width: MediaQuery.of(context).size.width*0.7,
            child: Text(
              'المرحلة',
              style: TextStyle(

                fontSize: 15,
                color:  Colors.black54,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Container(
            height:150,
            width: MediaQuery.of(context).size.width*0.8,
            padding: EdgeInsets.all(0),
            // margin: EdgeInsets.only(top: 16, bottom: 40),
            color: Colors.white,
            child: ListWheelScrollView(
                itemExtent: 50,
                diameterRatio: 1.2,
                offAxisFraction: -0.4,
                squeeze: 0.8,
                // clipToSize: true
                //  itemExtent: 40,
                useMagnifier: true,
                // onSelectedItemChanged: (int){
                //   {setState(()=>{newStudentsid=data[int]['id'],newStudentsNameid=data[int]['nameAr']});}
                // },
                // diameterRatio: 1.6,
                children: <Widget>[
                  ...dataS.map((name) {
                    print(name['nameAr']);
                    print("lll");
                    return InkWell(
                     // onTap: ()=>{setState(()=>{newStudentsid=name['id'],newStudentsNameid=name['nameAr']}),},
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
        //  textAlign: TextAlign.right,

      ],
    );

  }
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }
  var message;
  addFavourites() async {
    await  networkRequest.AddFavourites(data['id']).then((value){
      setState(() {
        message  = value;
      });
    });
  }
  var Ratemessage;
addRate(comment,rate,id) async {
  await  networkRequest.AddRate(comment,rate,id).then((value){
    setState(() {
      Ratemessage  = value;
    });
  });
}
}
