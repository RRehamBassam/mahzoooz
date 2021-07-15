import 'dart:io';
import 'dart:convert' as convert;
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mahzoooz/Screen/bottomNavigationBar/homeWidget.dart';
import 'package:mahzoooz/Screen/bottomNavigationBar/Discounts.dart';
import 'package:mahzoooz/Screen/bottomNavigationBar/Profile.dart';
import 'package:mahzoooz/Widget/loading.dart';
import 'package:mahzoooz/api/NetworkRequest.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mahzoooz/services/helperFunctions.dart';
import 'package:mahzoooz/Screen/Auth/welcome.dart';
import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'bottomNavigationBar/noDataLocation.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LatLng latLnglocation;
  List dataLocation;
  double lat;
  double lng;
  bool DataEmapty;
  getDataEmptyState() async {
    await HelperFunctions.getDataEmptyInSharedPreference().then((value){
      if(value!=null) {
        setState(() {
          DataEmapty = value;
          print("kdkd");
          print(DataEmapty);
        });
      }
    });
  }
var addresses;
  m(lat,lng) async {
    try
    {
      final coordinates=await new Coordinates(lat,lng);
      addresses=await Geocoder.local.findAddressesFromCoordinates(coordinates);

      HelperFunctions.saveUserAddressChangeSharedPreference(" ${addresses.first.addressLine}");
      print("kkkkooo ${addresses.first.addressLine}");
    }catch(e){
      print("kkkkooo");
      print(e);
    }
  }
  var DataEmapty2;//             "latitude": "24.75007441712588",
//             "longitude": "46.775951958232405"
  getDataRandom() async {
    print(latLnglocation.longitude);
    print(latLnglocation.latitude);
    await m(latLnglocation.latitude,latLnglocation.longitude);
    print("rrrrrrr $AddressChangموقعك  ");
    await networkRequest.getLuck(latLnglocation).then((value){
      try {
        DataEmapty2 = null;
        if (value != null) {
          setState(() {
            DataEmapty2 = value['data'];

            print(DataEmapty);
          });
        }
      }catch(val){
        DataEmapty2 = null;
      }
      setState(() {

      });
    });
  }
  var AddressChang;

  getAddressChangeState() async {
    await HelperFunctions.getUserAddressChangeSharedPreference().then((value){
      setState(() {
        AddressChang  = value;
      });
    });}
  getLatInState() async {
    await HelperFunctions.getUserLatInSharedPreference().then((value){
      setState(() {
        lat  = value;
      });
    });
    await HelperFunctions.getUserLngSharedPreference().then((value){
      setState(() {
        lng  = value;
        latLnglocation=LatLng(lat ==null?1:lat,lng==null?1:lng);
      });
    });
    getDataRandom();
   // await checkLocationServicesInDevice();
  }
  getLngInState() async {

  }


  int _selectedIndex ;

  var token;
  void gettoken()async{
    await HelperFunctions.getUserEmailSharedPreference().then((value){
      token  = value ;
    });
  }
  getDatatoken()async{
    await gettoken();
    if(token==null){
      Fluttertoast.showToast(
          msg: " يجب عليك تسجيل دخول",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff38056e).withOpacity(0.9),
          textColor: Colors.white,
          fontSize: 16.0
      );
      await getData();

        if (!initSign){
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.leftToRight,
              duration: Duration(milliseconds: 550),
              reverseDuration: Duration(milliseconds: 700),
              child: welcome(true),
            ),
          );
          setState(() {
            initSign=true;
          });
      }
    }

  }
  bool initSign;
  Future<String> getData() async {
    await Future<void>.delayed(Duration(seconds: 3));
  }
  void _onItemTapped(int index) {
    if(index==3){
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
            child: BottomSheetExample(context),
          ),
        ),
      );
     // FlutterOpenWhatsapp.sendSingleMessage("+9665665151191", "Hello");//+972598390185
    }else  if(index==2){
      print("pp $index");
      if(token==null) {
        print("pp1 $index");
        getDatatoken();
      }else{
        setState(() {
          print("pp2 $index");
          _selectedIndex = index;
        });
      }
    }else{
      setState(() {
        print("pp3 $index");
        _selectedIndex = index;
      });
    }


  }
  // launchWhatsApp() async {
  //   final link = WhatsAppUnilink(
  //     phoneNumber: '+001-(555)1234567',
  //     text: "Hey! I'm inquiring about the apartment listing",
  //   );
  //   // Convert the WhatsAppUnilink instance to a string.
  //   // Use either Dart's string interpolation or the toString() method.
  //   // The "launch" method is part of "url_launcher".
  //   await launch('$link');
  // }
  bool loud;
  var dataProfile;
  getProfileState() async {
    NetworkRequest networkRequest=new NetworkRequest();
    await networkRequest.getProfile().then((value){
      setState(() {
        dataProfile=value;
        //    bytes = convert.base64.decode(value);
      });
    });
  }
  @override
  void initState() {
  //  getImageInState();
    gettoken();
    getProfileState();
    DataEmapty2="1";
    getDataEmptyState();
    getAddressChangeState();
    getLatInState();
    getLngInState();
    _selectedIndex=0;
    dataLocation=[];
    DataEmapty=true;
    initSign=false;

    loud=false;
    //checkLocationServicesInDevice();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor( Color(0x00ffffff));
    List<Widget> _widgettajerAccount = <Widget>[
      homeWidget(latLnglocation),
      Discounts(latLnglocation),
      Profile(),

      homeWidget(latLnglocation),

    ];
    return  //dataLocation.isEmpty?
      DataEmapty2=="1"?Scaffold(
          body:Container(child: Loading())): DataEmapty2==null?Scaffold(
      body:noDataLocation()):
    Scaffold(
      body: _widgettajerAccount.elementAt(_selectedIndex),
      bottomNavigationBar: bottomNavigationBar(),
    );
    //:Scaffold(
     //   body:Loading());
    // Container(
    //
    //
    //   child: Center(
    //     child: Column(
    //       crossAxisAlignment:CrossAxisAlignment.center ,
    //       mainAxisAlignment:MainAxisAlignment.center ,
    //       children: [
    //
    //         Container(
    //           width: 260.0,
    //           height: 260.0,
    //           padding:EdgeInsets.all(45),
    //           decoration: new BoxDecoration(
    //             color:Color(0xffF3FDE5), // Color(0xffF0FAF9),C5E697
    //             shape: BoxShape.circle,
    //           ),
    //           child: Container(
    //             width: 120.0,
    //             height: 120.0,
    //
    //             padding:EdgeInsets.all(50),
    //             decoration: new BoxDecoration(
    //               color: Color(0xffC5E696),// Color(0xffCEEAE7),
    //               shape: BoxShape.circle,
    //             ),
    //             child: Container(
    //               width: 60.0,
    //               height: 60.0,
    //               decoration: new BoxDecoration(
    //                 color:Color(0xff91B958),//Color(0xff029789),
    //                 shape: BoxShape.circle,
    //               ),
    //               child:  Image.asset("Assets/sad.png") ,
    //             ),
    //           ),
    //         ),
    //         SizedBox(height: 68,),
    //         // new Text(
    //         //   "لايوجد عروض متوفرة في موقعك الحالى", //data['providerNameAr'] ==null? "مطاعم البيك السعودية":translator.currentLanguage == 'ar' ? data['providerNameAr']:data['providerNameEn'],
    //         //   textAlign: TextAlign.center,
    //         //   style: TextStyle(
    //         //
    //         //     fontWeight: FontWeight.w800,
    //         //     fontSize: 14,
    //         //     color:Color(0xff91B958),
    //         //   ),
    //         // ),
    //         //SizedBox(height: 11,),
    //         new Text(
    //           "شويات وراجعين بخصومتنا", //data['providerNameAr'] ==null? "مطاعم البيك السعودية":translator.currentLanguage == 'ar' ? data['providerNameAr']:data['providerNameEn'],
    //           textAlign: TextAlign.center,
    //           style: TextStyle(
    //
    //             fontWeight: FontWeight.w800,
    //             fontSize: 16,
    //             color:Color(0xff91B958),
    //           ),
    //         ),
    //         SizedBox(height: 88,),
    //         // InkWell(
    //         //   onTap: (){
    //         //     Navigator.push(context, new MaterialPageRoute(builder: (context)=>new maps()));
    //         //   },
    //         //   child:    new Text(
    //         //     "تغيير الموقع الحالى", //data['providerNameAr'] ==null? "مطاعم البيك السعودية":translator.currentLanguage == 'ar' ? data['providerNameAr']:data['providerNameEn'],
    //         //     textAlign: TextAlign.center,
    //         //     style: TextStyle(
    //         //
    //         //       fontWeight: FontWeight.w600,
    //         //       fontSize: 14,
    //         //       color:Colors.black,
    //         //     ),
    //         //   ),
    //         // )
    //
    //       ],
    //     ),
    //   ),
    // )
  }
  NetworkRequest networkRequest=new NetworkRequest();

  Widget bottomNavigationBar(){
    return Container(

      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,


        items: [
          BottomNavigationBarItem(
            icon: Container(
              margin:EdgeInsets.only(bottom: 6,top: 2) ,
                child: Image.asset("Assets/Home.png",color: _selectedIndex==0?Color(0xff38056e):Color(0xFF748A9D),)),
            label: translator.translate('home'),

          ),
          BottomNavigationBarItem(
            icon:Container(
                margin:EdgeInsets.only(bottom: 6,top: 2) ,
                child: Image.asset("Assets/Stroke 7.png",color: _selectedIndex==1?Color(0xff38056e):Color(0xFF748A9D),)),
            label: translator.translate('Discounts'),
          ),
          BottomNavigationBarItem(
            icon:Container( margin:EdgeInsets.only(bottom: 6,top: 2) ,
                child: Image.asset("Assets/Profile.png",color: _selectedIndex==2?Color(0xff38056e):Color(0xFF748A9D),)),
            label: translator.translate('Profile'),
          ),
          BottomNavigationBarItem(
            icon: Container(
                margin:EdgeInsets.only(bottom: 6,top: 2) ,
                child: Image.asset("Assets/Chat.png",color: _selectedIndex==3?Color(0xff38056e):Color(0xFF748A9D),)),
            label: translator.translate('Help'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff38056e),
        onTap: _onItemTapped,
      ),
    );
  }
  BottomSheetExample(context){
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
                  translator.translate("customers service"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Tajawal",fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color:Color(0xff3d3b39),
                  ),
                ),
              ),
              Container(
                height:15,
                width: 90,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(top: 16, bottom: 30),
                color: Colors.white,
                child: Column(
                  children: [
                    // Row(
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
              GestureDetector(
                onTap:()=> {
                FlutterOpenWhatsapp.sendSingleMessage("+966566515191", " هلا فريق محظوووظ انا${dataProfile['name']}"),
                  print("ooo"),
                  Navigator.pop(context)},
                child: new Container(
                  margin:EdgeInsets.only(right: 30, left: 30),
                  width:20,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Color(0xff38056e),borderRadius: BorderRadius.circular(25.00),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        new Text(
                    translator.translate( "Contact us via WhatsApp"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color:Color(0xffffffff),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Container(
                            margin:EdgeInsets.only(bottom: 5),
                            child: Image.asset("Assets/whatsapp.png",width: 20,)),
                      ],
                    )
                  ),
                ),
              ),
              SizedBox(width: 18,),
            ],
          ),
        ),
      );
  }
}
