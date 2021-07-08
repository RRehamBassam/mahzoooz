import 'package:animated_clipper/animated_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mahzoooz/Screen/CouponDiscount.dart';
import 'package:mahzoooz/Screen/RestaurantData.dart';
import 'package:mahzoooz/api/NetworkRequest.dart';
import 'package:mahzoooz/services/helperFunctions.dart';
import 'package:page_transition/page_transition.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:convert' as convert;
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
class ViewRestaurantDiscounts extends StatefulWidget {
  var data;

  ViewRestaurantDiscounts(this.data);

  @override
  _ViewRestaurantDiscountsState createState() => _ViewRestaurantDiscountsState(data);
}

class _ViewRestaurantDiscountsState extends State<ViewRestaurantDiscounts> {
  var data;

  _ViewRestaurantDiscountsState(this.data);
  var rate;
  int _counter = 0;
  bool _bool = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  Future<void> share() async {
    await FlutterShare.share(
        title:  " ${translator.currentLanguage == 'ar' ?data['titeAr']:data['titleEn']} من ${translator.currentLanguage == 'ar' ?data['providerNameAr']:data['providerNameEn']} للتفاصيل  حمل تطبيق محظوووظ من الرابط ",
        text:  " ${translator.currentLanguage == 'ar' ?data['titeAr']:data['titleEn']} من ${translator.currentLanguage == 'ar' ?data['providerNameAr']:data['providerNameEn']} للتفاصيل  حمل تطبيق محظوووظ من الرابط ",
        linkUrl: data['webSite'],
        chooserTitle: 'لتفاصيل');
  }
  void _toggleBool(bool newValue) {
    if(newValue){
      getLoggedInState();
      Fluttertoast.showToast(
          msg: "تم نسخ الكود",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff38056e).withOpacity(0.9),
          textColor: Colors.white,
          fontSize: 16.0
      );
      setState(() {
        Clipboard.setData(new ClipboardData(text: data['code']));
      });
    }
    setState(() {

      _bool = newValue;
    });
  }
  NetworkRequest networkRequest=new NetworkRequest();
  getLoggedInState() async {
    await networkRequest.Copy(data['id']).then((value){

    });
  }

  DateTime now = DateTime.now();

  //print(now.hour.toString() + ":" + now.minute.toString() + ":" + now.second.toString());{data['lastDate'].toString().split('T')[1]}
 // Uint8List bytes; Uint8List bytesback;

  var token;
  void gettoken()async{
    await HelperFunctions.getUserEmailSharedPreference().then((value){
      token  = value ;
    });
  }
  @override
  void initState() {
    gettoken();
       //  if(data['providerLogo']!= null)
       // {bytes= convert.base64.decode(data['providerLogo'].split(',').last);}
       // if(data['offerImages'][0]['imageName']!=null)
       // {  bytesback= convert.base64.decode(data['offerImages'][0]['imageName'].split(',').last);}

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final fifteenAgo = new DateTime.now().subtract(new Duration(minutes: 15));
   // print(timeago.format(fifteenAgo));
    DateTime time = DateTime.parse(data['lastDate']);
   // print(timeago.format(time));
   // print(now.hour.toString() + ":" + now.minute.toString() + ":" + now.second.toString());
  //  print(data['providerLogo']);print(data['offerImages'][0]['imageName']);

    //  bytes = convert.base64.decode(data['offerImages'][0]['imageName']);
    //bytes= convert.base64.decode(data['providerLogo']);

    return data['providerLogo']!= null ||data['offerImages'][0]['imageName']!=null? InkWell(
      onTap: (){
        Navigator.push(context,PageTransition(
          type: PageTransitionType.leftToRight,
            duration: Duration(milliseconds: 550) ,
            reverseDuration: Duration(milliseconds: 700),
          child: RestaurantData(data),
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
                            image:data['offerImages'][0]['imageName']==null?AssetImage('Assets/ModalPanel.png',):NetworkImage(data['offerImages'][0]['imageName']),//, MemoryImage(bytesback),
                            fit: BoxFit.cover,
                          ),
                        ),),
                      Positioned(
                          left: 10, top: 10,
                          child:Row(
                            children: [
                              InkWell(
                                onTap:(){
                                  share();
                      },
                                child: new Container(
                                  height: 25.00,
                                  width: 25.00,
                                  decoration: BoxDecoration(
                                    color: Color(0xffffffff),borderRadius: BorderRadius.circular(15.00),
                                  ),
                                  child:     Center(child:Icon(Icons.reply_outlined,color:Color(0xff38056e),size: 18,) ),//Image.asset("Assets/Upload.png",scale: 0.85,)
                                ),
                              ),
                              SizedBox(width: 10,),
                              InkWell(
                                onTap: ()async{
                                  if(token==null){
                                    Fluttertoast.showToast(
                                        msg: "عفوا سجل دخولك اولا",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Color(0xff38056e).withOpacity(0.9),
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  }else {
                                    if (token == null) {
                                      Fluttertoast.showToast(
                                          msg:"عفوا سجل دخولك اولا",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Color(0xff38056e)
                                              .withOpacity(0.9),
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    } else {
                                      await addFavourites();
                                      if (message ==
                                          "Data Inserted Successfully") {
                                        Fluttertoast.showToast(
                                            msg: translator.currentLanguage ==
                                                'ar'
                                                ? "تم إضافة للمفضلة بنجاح"
                                                : message,
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Color(0xff38056e)
                                                .withOpacity(0.9),
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: message,
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Color(0xff38056e)
                                                .withOpacity(0.9),
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );
                                      }
                                    }
                                  }
                                },
                                child: new Container(
                                  height: 25.00,
                                  width: 25.00,
                                  decoration: BoxDecoration(
                                    color: Color(0xffffffff)
                                    ,borderRadius: BorderRadius.circular(15.00),
                                  ),
                                  child:     Center(child: Icon(Icons.favorite_border,color:Color(0xff38056e),size: 18,)),
                                ),
                              ),
                              SizedBox(width: 10,),
                              data['discount']==0.0?Container(): new Container(
                                height: 27.00,
                                width: 76.00,
                                decoration: BoxDecoration(
                                  color: Color(0xffffffff),borderRadius: BorderRadius.circular(10.00),
                                ),
                                child: Center(
                                  child: new Text(" %${data['discount'].toString().split('.')[0]} خصم ",
                                    //"٢٥٪ خصم",
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
                          height: 160,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(height:16,),
                             Row(
                               children: [
                                 SizedBox(width: 4,),
                                 new Text(
                                   data['providerNameAr'] ==null? "":translator.currentLanguage == 'ar' ?data['providerNameAr']:data['providerNameEn'],
                                   textAlign: TextAlign.right,
                                   style: TextStyle(
                                     fontWeight: FontWeight.w700,
                                     fontFamily: "Tajawal",
                                     fontSize: 14,
                                     color:Color(0xff242e42),
                                   ),
                                 ),
                               ],
                             ),

                              Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      if(!data['canComment']){
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
                                              child: BottomSheetExample(context,"text",data,data),
                                            ),
                                          ),
                                        );
                                      }else{
                                        Fluttertoast.showToast(
                                            msg: "قمت بالتقييم من قبل ب ${data['rate']}",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Color(0xff38056e).withOpacity(0.9),
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );
                                      }

                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.star,color:Color(0xff38056e) ,),
                                        new Text(
                                          data['rate'].toString().split(".").first,
                                          style: TextStyle(

                                            fontSize: 15,
                                            color:Color(0xffc8c7cc),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),// Adobe XD layer: '4.9' (text)
                                  Image.asset('Assets/Ticket.png'),
                                SizedBox(width: 4,),
                                Text(
                                  'استخدم ${data['numberUsed']} مرة',
                                  style: TextStyle(
                                    fontFamily: 'DIN Next LT Arabic',
                                    fontSize: 10,
                                    color: const Color(0xff80ab40),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(width: 14,)  ,
                                  Row(
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
                                      new Text(//{data['lastDate'].toString().split('T')[1]}
                                        " ${timeago.format(time)}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                          color:Color(0xff909090),
                                        ),
                                      ),

                                    ],
                                  ),
                                  // new Text(//{data['lastDate'].toString().split('T')[1]}
                                  //   " ${timeago.format(time)}  استعمل مؤخرا",
                                  //   textAlign: TextAlign.center,
                                  //   style: TextStyle(
                                  //     fontWeight: FontWeight.w500,
                                  //     fontSize: 10,
                                  //     color:Color(0xff909090),
                                  //   ),
                                  // )
                                ],
                              ),
                             // SizedBox(height: 20,),
                              Row(
                                children: [
                                 Container (
                                   width:MediaQuery.of(context).size.width*0.48,
                                    child: new Text(
                                      data['titeAr']==null? "خصم ١٠٠ ريال سعودي":translator.currentLanguage == 'ar' ?data['titeAr']:data['titleEn'],
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontFamily: "Tajawal",fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color:Colors.black,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      data['schoolTypeAr']!=null?InkWell(
                                        onTap: (){
                                          Navigator.push(context,PageTransition(
                                            type: PageTransitionType.bottomToTop,
                                            duration: Duration(milliseconds: 550) ,
                                            reverseDuration: Duration(milliseconds: 700),
                                            child:CouponDiscount(data),
                                          ),);
                                        },
                                        child: Container(
                                        alignment: Alignment.centerLeft,
                                        height: 34.00,
                                        width: 82.00,
                                        padding: EdgeInsets.all(5) ,
                                        decoration: BoxDecoration(
                                          color:Color(0xff38056e),
                                          border: Border.all(width: 1.00, color: Color(0xff38056e),), borderRadius: BorderRadius.circular(22.00),
                                        ),
                                        child: Directionality(
                                          textDirection:translator.currentLanguage == 'ar' ? TextDirection.rtl:TextDirection.ltr,
                                          child: Center(
                                            child: new Text(
                                              translator.translate("كوبون خصم"),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Color(0xffffffff),
                                              ),
                                            ),
                                          ),
                                        )
                                  ),
                                      ):data['code']==null?Container():  ClipSwitch(
                                        pathBuilder:	PathBuilders.slideRight,
                                        value: _bool,
                                        onChanged: _toggleBool,
                                        inactiveWidget: Stack(
                                          children: [
                                            Container(
                                                alignment: Alignment.centerLeft,
                                                height: 34.00,
                                                width: 82.00,
                                                padding: EdgeInsets.all(5) ,
                                                decoration: BoxDecoration(
                                                  color: Color(0xffffffff),
                                                  border: Border.all(width: 1.00, color: Color(0xff38056e),), borderRadius: BorderRadius.circular(22.00),
                                                ),
                                                child: Directionality(
                                                  textDirection:translator.currentLanguage == 'ar' ? TextDirection.rtl:TextDirection.ltr,
                                                  child: new Text(

                                                    data['code'],
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12,
                                                      color:Color(0xff38056e),
                                                    ),
                                                  ),
                                                )
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              height: 34.00,
                                              width: 65.00,
                                              decoration: BoxDecoration(
                                                color: Color(0xff38056e),
                                                border: Border.all(width: 1.00, color: Color(0xff38056e),), borderRadius: BorderRadius.circular(22.00),
                                              ),
                                              child: Center(
                                                child: new Text(
                                                  translator.translate("Copy Code"),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11,
                                                    color:Color(0xffffffff),
                                                  ),
                                                ),
                                              ) ,
                                            ),
                                          ],
                                        ),
                                        activeWidget: Container(
                                          alignment: Alignment.center,
                                            height: 34.00,
                                            width: 82.00,
                                            decoration: BoxDecoration(
                                              color: Color(0xffffffff),
                                              border: Border.all(width: 1.00, color: Color(0xff38056e),), borderRadius: BorderRadius.circular(22.00),
                                            ),
                                            child: Center(
                                              child: new Text(
                                                data['code']==null?"dd":data['code'],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color:Color(0xff38056e),
                                                ),
                                              ),
                                            )
                                        ),
                                      ),
                                      SizedBox(width: 6,),

                                      data['schoolTypeAr']!=null?Container(): InkWell(
                                        onTap: () => setState(() {
                                          launch(data['webSite']);

                                        }),
                                        child: Transform(
                                            alignment: Alignment.center,
                                          transform:  translator.currentLanguage == 'en' ? Matrix4.rotationY(math.pi):Matrix4.rotationY(0),
                                            child: Image.asset('Assets/Send.png',scale: 0.8,)),
                                      )

                                    ],
                                  )
                                ],
                              )
                            ],
                          ),),
                      ),
                      data['providerLogo']!=null?   translator.currentLanguage == 'en' ?Positioned(
                        left:  20,
                        bottom: 130,
                        child: Container(
                          width: 48,
                          height: 48,
                          // margin: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(5.0),
                            image: DecorationImage(
                              image:data['providerLogo']==null? AssetImage('Assets/download.png'):NetworkImage(data['providerLogo']),// MemoryImage(bytes),
                              fit: BoxFit.cover,
                            ),
                          ),
                      //  child: Image.memory(bytes),
                        ),
                      ): Positioned(
                        right:  20,
                        bottom: 130,
                        child: Container(
                          width: 48,
                          height: 48,
                        //  child: Image.memory(bytes),
                          // margin: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(5.0),
                            image: DecorationImage(
                              image:data['providerLogo']==null? AssetImage('Assets/download.png'):NetworkImage(data['providerLogo']),// MemoryImage(bytes),
                              fit: BoxFit.cover,
                            ),
                          ),),
                      ):Container(
                        width: 48,
                        height: 48,),
                    ],
                  )

              ),
            ),
          ) ),
    ):Container();
  }
  var comment;
  BottomSheetExample(context,String text,data,dataoffer){
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
                        //    print(rating);
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
                      onTap:()async { Navigator.pop(context);
                        if(rate!=null)
                          {
                          if(token==null){
                          Fluttertoast.showToast(
                          msg: "عفوا سجل دخولك اولا",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color(0xff38056e).withOpacity(0.9),
                          textColor: Colors.white,
                          fontSize: 16.0
                          );
                          }else{
                            await  addRate(comment, int.parse(rate.toString().split(".").first),
                              dataoffer['id']);
                            Fluttertoast.showToast(
                                msg: Ratemessage,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Color(0xff38056e).withOpacity(0.9),
                                textColor: Colors.white,
                                fontSize: 16.0
                            );

                          };}

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
  var Ratemessage;
  addRate(comment,rate,id) async {
    await  networkRequest.AddRate(comment,rate ,id).then((value){
      setState(() {
        Ratemessage  = value;
      });
    });
  }
 var message;
  addFavourites() async {
    await  networkRequest.AddFavourites(data['id']).then((value){
      setState(() {
        message  = value;
      });
    });
  }}