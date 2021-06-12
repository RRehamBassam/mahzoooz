import 'dart:io';
import 'dart:convert' as convert;
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mahzoooz/Screen/bottomNavigationBar/homeWidget.dart';
import 'package:mahzoooz/Screen/bottomNavigationBar/Discounts.dart';
import 'package:mahzoooz/Screen/bottomNavigationBar/Profile.dart';
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
  Future<void> checkLocationServicesInDevice() async {

    Location location = new Location();

    _serviceEnabled = await location.serviceEnabled();

    if(_serviceEnabled)
    {

      _permissionGranted = await location.hasPermission();

      if(_permissionGranted == PermissionStatus.granted)
      {

        // _location = await location.getLocation();

        // print(_location.latitude.toString() + " " + _location.longitude.toString());


        location.onLocationChanged.listen((LocationData currentLocation) async {
          //  print(currentLocation.latitude.toString() + " yess" + currentLocation.longitude.toString());
          latLnglocation=LatLng(currentLocation.latitude,currentLocation.longitude);
          // List<Placemark> placemarks =  placemarkFromCoordinates(52.2165157, 6.9437819);
          HttpClient client = new HttpClient();
          client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
          String url ='http://ahmed453160-001-site1.etempurl.com/Offers/GetPaged';

          Map map ={
            "pageNumber": 1,
            "pageSize": 10,
            "filter": {
              "searchText": "",
              "isSpecial": false,
              "latitude": latLnglocation.latitude,
              "longitude": latLnglocation.longitude
            }
          };
          var itemCount ;
          HttpClientRequest request = await client.postUrl(Uri.parse(url));
          request.headers.set('content-type', 'application/json');
          request.add(convert.utf8.encode(convert.json.encode(map)));
          HttpClientResponse response = await request.close();
          String reply = await response.transform(convert.utf8.decoder).join();
          print(response.statusCode);  var jsonResponse = convert.jsonDecode(reply);
          print(jsonResponse['data']['data']);

          dataLocation=jsonResponse['data']['data'];

        });
      }else{

        _permissionGranted = await location.requestPermission();
        if(_permissionGranted == PermissionStatus.granted)
        {
          print('user allowed');
        }else{
          //   SystemNavigator.pop();
        }

      }

    }else{

      _serviceEnabled = await location.requestService();

      if(_serviceEnabled)
      {
        _permissionGranted = await location.hasPermission();

        if(_permissionGranted == PermissionStatus.granted)
        {

          print('user allowed before');

        }else{
          _permissionGranted = await location.requestPermission();
          if(_permissionGranted == PermissionStatus.granted)
          {
            print('user allowed');
          }else{
            //   SystemNavigator.pop();
          }}
      }else{

        //  SystemNavigator.pop();

      }

    }

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
      Navigator.push(context,PageTransition(
        type: PageTransitionType.leftToRight,
        duration: Duration(milliseconds: 550) ,
        reverseDuration: Duration(milliseconds: 700),
        child: welcome(true),
      ),);
    }

  }
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
  @override
  void initState() {
    _selectedIndex=0;
    dataLocation=[];
    gettoken();
    checkLocationServicesInDevice();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> _widgettajerAccount = <Widget>[
      homeWidget(latLnglocation),
      Discounts(latLnglocation),
      Profile(),

      homeWidget(latLnglocation),

    ];
    return// dataLocation.isEmpty?Scaffold(
    //  body:noDataLocation()):
    Scaffold(
      body: _widgettajerAccount.elementAt(_selectedIndex),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }
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
                  "خدمة العملاء",
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
                FlutterOpenWhatsapp.sendSingleMessage("+966566515191", "Hello"),
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
                          "تواصل معنا عبر WhatsApp",
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
