import 'dart:async';
import 'dart:io';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mahzoooz/services/helperFunctions.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mahzoooz/Screen/Auth/login.dart';
import 'Screen/Auth/welcome.dart';
import 'Screen/Home.dart';
import 'package:provider/provider.dart';
import 'package:mahzoooz/services/providerUser.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'package:flutter/services.dart';
import 'dart:convert' as convert;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await translator.init(
    localeDefault: LocalizationDefaultType.device,
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'Assets/langs/',
    apiKeyGoogle: '<Key>', // NOT YET TESTED
  ); // intialize

  runApp( MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => providerUser()),
  ],child:   LocalizedApp(child: MyApp())),
  );
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor( Color(0xff38056e));
    return MaterialApp(
      title: 'محظوظ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Tajawal',
        primarySwatch: Colors.blue,
        primaryColor: Color(0xff38056e),
      ),
      routes: <String, WidgetBuilder> {
        '/login': (BuildContext context) => login("+9705941025",true),
      },
      home: MyHomePage(),
      localizationsDelegates: translator.delegates, // Android + iOS Delegates
      locale: translator.locale, // Active locale
      supportedLocales: translator.locals(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool userIsLoggedIn;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LatLng latLnglocation;
  List dataLocation;
  double lat;
  var addresses;
  double lng;
  var currentLocation;

  getUserLocation() async {//call this async method from whereever you need

    LocationData myLocation;
    String error;
    Location location = new Location();
    try {
      myLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'please grant permission';
      //  print(error);
      }
      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'permission denied- please enable it from app settings';
       // print(error);
      }
      myLocation = null;
    }
    currentLocation = myLocation;
    final coordinates = new Coordinates(
        myLocation.latitude, myLocation.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);
    var first = addresses.first;
    HelperFunctions.saveUserAddressLocalSharedPreference(' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
  //  print(' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
    return first;
  }
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
    // await checkLocationServicesInDevice();
  }
  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn  = value;
      });
    });
  }
  Future<void> checkLocationServicesInDevice() async {
    //print("1");
    await getLatInState();
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

          if(lat==null){

            HelperFunctions.saveUserlocationLatSharedPreference(currentLocation.latitude);
            HelperFunctions.saveUserlocationlngSharedPreference(currentLocation.longitude);
            latLnglocation=LatLng(currentLocation.latitude,currentLocation.longitude);
           // getUserLocation();

          }else{

print("1");
            latLnglocation=LatLng(lat ==null?1:lat,lng==null?1:lng);

          }
          // List<Placemark> placemarks =  placemarkFromCoordinates(52.2165157, 6.9437819);
//           HttpClient client = new HttpClient();
//           client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
//           String url ='http://ahmed453160-001-site1.etempurl.com/Offers/GetRandomOffers';
//           print("3");
//           Map map ={
//             "latitude": "24.75007441712588",
//             "longitude": "46.775951958232405"
//             //   "latitude": "${latLnglocation.latitude}",
//             //   "longitude": "${latLnglocation.longitude}"
//           };
//           var itemCount ;
//           HttpClientRequest request = await client.postUrl(Uri.parse(url));
//           request.headers.set('content-type', 'application/json');
//           request.add(convert.utf8.encode(convert.json.encode(map)));
//           HttpClientResponse response = await request.close();
//           String reply = await response.transform(convert.utf8.decoder).join();
//           // print(reply);
//           print("2");
//           var jsonResponse = convert.jsonDecode(reply);
//         //  await Future<void>.delayed(Duration(seconds: 2));
// try{
//             if (jsonResponse['data']==null){
//               print("7");
//               HelperFunctions.saveDataEmptyInSharedPreference(true);
//             }else{
//               dataLocation=jsonResponse['data']['data'];
//               print("8");
//               //loud=true;
//               HelperFunctions.saveDataEmptyInSharedPreference(false);
//             }}catch(val){
//   HelperFunctions.saveDataEmptyInSharedPreference(true);  print("9");
//             }






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

  getLoctoinState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn  = value;
      });
    });
  }

  void initState(){
     getLatInState();
     getLoctoinState();
     userIsLoggedIn=false;
    checkLocationServicesInDevice();
    //getLoggedInState();
    getLoggedInState();
    super.initState();
    start();
  }
  start()async{

    return Timer(const Duration(seconds: 3), (){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_){
            return userIsLoggedIn != null ?  userIsLoggedIn ? Home() :  welcome(false): welcome(false);;//
          })
      );
    }) ;
  }
  bool _enabled = true;
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor( Color(0x00ffffff));

    // TODO: implement build
    return  Scaffold(
      body: Container(
          width: double.infinity,
          child: Center(
            child:Image.asset("Assets/1.png",fit: BoxFit.fill,height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width ,),// Text(translator.translate('appTitle')),//
          )),
    );


  }
}