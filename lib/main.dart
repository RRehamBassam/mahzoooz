import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mahzoooz/Widget/utils.dart';
import 'package:mahzoooz/services/helperFunctions.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mahzoooz/Screen/Auth/login.dart';
import 'Screen/Auth/aa.dart';
import 'Screen/Auth/welcome.dart';
import 'Screen/Home.dart';
import 'package:provider/provider.dart';
import 'package:mahzoooz/services/providerUser.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
// import 'package:geolocator/geolocator.dart';

import 'package:flutter/services.dart';
import 'dart:convert' as convert;
// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// @dart=2.9

import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  WidgetsFlutterBinding.ensureInitialized();
  await translator.init(
    localeType: LocalizationDefaultType.device,
    languagesList: <String>['ar', 'en'],


    // defaultLanguageCode: 'ar',

    assetsDirectory: 'Assets/langs/',
    //apiKeyGoogle: '<Key>', // NOT YET TESTED
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
      title: 'محظوووظ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Tajawal',
        primarySwatch: Colors.blue,
        primaryColor: Color(0xff38056e),
      ),
      routes: <String, WidgetBuilder> {
        '/login': (BuildContext context) => login("+9705941025",true,false),
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
      if(userIsLoggedIn==null) {
        translator.setNewLanguage(
          context,
          newLanguage:  'ar' ,
          remember: true,
          restart: true
        );
        HelperFunctions.saveUserLoggedInSharedPreference(false);
      }
      setState(() {
        userIsLoggedIn  = value;
      });
    });
  }


  // Position currentPosition = Position();
  _getPosition() async {
    await getLatInState();
    // "latitude": "24.75007441712588",
    // "longitude": "46.775951958232405"
    Location location = new Location();

    _serviceEnabled = await location.serviceEnabled();
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

    if(_serviceEnabled)
    {

      _permissionGranted = await location.hasPermission();

      if(_permissionGranted == PermissionStatus.granted)
      {  print("EE");

      _location = await location.getLocation();
      if(lat==null) {
        print(_location.latitude.toString() + " " + _location.longitude.toString());
        HelperFunctions.saveUserlocationLatSharedPreference(_location.latitude);
        HelperFunctions.saveUserlocationlngSharedPreference(_location.longitude);
      }
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



    }
    if(lat==null) {
      // HelperFunctions.saveUserlocationLatSharedPreference(
      //     24.75007441712588);
      // HelperFunctions.saveUserlocationlngSharedPreference(
      //     46.775951958232405);
    }
    try {
      // await Geolocator.requestPermission().then((value) async {
      //   await Geolocator.getCurrentPosition().then((value) async{
      //     currentPosition = value;
      //     if(lat==null) {
      //       HelperFunctions.saveUserlocationLatSharedPreference(
      //           currentPosition.latitude);
      //       HelperFunctions.saveUserlocationlngSharedPreference(
      //           currentPosition.longitude);
      //     }
      //
      //     print(currentPosition.latitude.toString());
      //   });
      // });
      //
      // await getLatInState();
      //
      // await  m(lat,lng);
      // print("$lat  kdkdkdkdk $lng");

    } catch (error) {
      print(error.toString());
    }
  }

  m(lat,lng) async {
    print("kakaka");
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
  String _locationMessage = "";
  // void _getCurrentLocation() async {
  //
  //   final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   print(position);
  //
  //   setState(() {
  //     HelperFunctions.saveUserlocationLatSharedPreference(currentLocation.latitude);
  //     HelperFunctions.saveUserlocationlngSharedPreference(currentLocation.longitude);
  //     _locationMessage = "${position.latitude}, ${position.longitude}";
  //   });
  //
  // }
  getcheckLocationInState() async {
    await checkLocationServicesInDevice();
  }
  var _location;
  Future<void> checkLocationServicesInDevice() async {
    print("RR");
    //print("1");



  }

  getLoctoinState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn  = value;
      });
      print("$userIsLoggedIn kkkkkk");
    });
  }
  void showConnectivitySnackBar(ConnectivityResult result) {
    final hasInternet = result != ConnectivityResult.none;
    final message = hasInternet
        ? 'You have again ${result.toString()}'
        : 'You have no internet';
    final color = hasInternet ? Colors.green : Colors.red;

    Utils.showTopSnackBar(context, message, color);
  }
  FirebaseMessaging _firebaseMessaging =FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
var _token;
  StreamSubscription subscription;
  void initState(){
    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectivitySnackBar);
    onActionSelected("subscribe");
    // getLatInState();
    getLatInState();
    getLoctoinState();
    listenToNotification();
    userIsLoggedIn=false;
    // _getPosition();
    //_getCurrentLocation();
  //  _getPosition();
    //  checkLocationServicesInDevice();
    // getcheckLocationInState();
    //getLoggedInState();
    getLoggedInState();
    super.initState();


    start();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {

      if (message != null) {
        // Navigator.pushNamed(context, '/message',
        //     arguments: MessageArguments(message, true));
      }
    });


    getToken();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher.png');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings( android: android,  iOS: iOS);
    // flutterLocalNotificationsPlugin.initialize(initSetttings,
    //     onSelectNotification: onSelectNotification);
    if (Platform.isAndroid) {
      // print(_firebaseMessaging.getToken();)
      // Android-specific code
    } else if (Platform.isIOS) {
      // iOS-specific code
    }
     _firebaseMessaging.subscribeToTopic('SendAll');
   // gettoken();
    _firebaseMessaging.getToken();
    _firebaseMessaging.getToken().then((token) async {

      print("${token} tttttt token");
     // String token2 = _firebaseMessaging.getAPNSToken() as String;
      HelperFunctions.saveUsertokenFcmSharedPreference(token);
     // print("token token token${token2}");
     // HelperFunctions.saveUserTokenFieSharedPreference(token);
      //controller.editToken(token.toString());


      //context.read<AppState>().updatetoken(token);

      print(token); // Print the Token in Console
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Navigator.pushNamed(context, '/message',
      //     arguments: MessageArguments(message, true));
    });
  }
  Future<dynamic> myBackgroundMessageHandlerAndroid(RemoteMessage message) async {
    if (message.data['title'] == 'Call Ended') {
      final data = message.data;
      flutterLocalNotificationsPlugin..cancelAll();
      final titleMultilang = data['titleMultilang'];
      final bodyMultilang = data['bodyMultilang'];

    } else {
      if (message.data['title'] == 'You have new message(s)' ||
          message.data['title'] == 'New message in Group') {
        //-- need not to do anythig for these message type as it will be automatically popped up.
      } else if (message.data['title'] == 'Incoming Audio Call...' ||
          message.data['title'] == 'Incoming Video Call...') {
        // ignore: unnecessary_null_comparison
        if (message.data != null) {
          final data = message.data;

          final title = data['title'];
          final body = data['body'];
          final titleMultilang = data['titleMultilang'];
          final bodyMultilang = data['bodyMultilang'];

          // await _showNotificationWithDefaultSound(
          //     title, body, titleMultilang, bodyMultilang);
        }
      }
    }

    return Future<void>.value();
  }
  void listenToNotification() async {
    //FOR ANDROID  background notification is handled here whereas for iOS it is handled at the very top of main.dart ------
    if (Platform.isAndroid) {
   //   await _showNotificationWithDefaultSound("", "", "", "");

      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandlerAndroid);
    }
    //ANDROID & iOS  OnMessage callback
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // ignore: unnecessary_null_comparison
      if (message.data != null) {
        if (message.data['title'] != 'Call Ended' &&
            message.data['title'] != 'You have new message(s)' &&
            message.data['title'] != 'Incoming Video Call...' &&
            message.data['title'] != 'Incoming Audio Call...' &&
            message.data['title'] != 'Incoming Call ended' &&
            message.data['title'] != 'New message in Group') {
          //Olichat.toast(getTranslated(this.context, 'newnotifications'));
        } else {
          if (message.data['title'] == 'New message in Group') {
         //   var currentpeer =
          //  Provider.of<CurrentChatPeer>(this.context, listen: false);
            if (1 != 2) {
              flutterLocalNotificationsPlugin..cancelAll();

              showOverlayNotification((context) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: SafeArea(
                    child: ListTile(
                      title: Text(message.data['titleMultilang']),
                      subtitle: Text(message.data['bodyMultilang']),
                      trailing: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            OverlaySupportEntry.of(context).dismiss();
                          }),
                    ),
                  ),
                );
              }, duration: Duration(milliseconds: 2000));
            }
          } else if (message.data['title'] == 'Call Ended') {
            flutterLocalNotificationsPlugin..cancelAll();
          } else {
            if (message.data['title'] == 'Incoming Audio Call...' ||
                message.data['title'] == 'Incoming Video Call...') {
              // ignore: unnecessary_null_comparison
              if (message.data != null) {
                final data = message.data;
                print("yyyyyyyyyy11");
                final title = data['title'];
                final body = data['body'];
                final titleMultilang = data['titleMultilang'];
                final bodyMultilang = data['bodyMultilang'];

                // await _showNotificationWithDefaultSound(
                //     title, body, titleMultilang, bodyMultilang);
              }
            } else if (message.data['title'] == 'You have new message(s)') {
              final data = message.data;
            //  var currentpeer =
             // Provider.of<CurrentChatPeer>(this.context, listen: false);
             //  await _showNotificationWithDefaultSoundchat(
             //      data['title'],
             //      data['body'],
             //      message.data['titleMultilang'],
             //      message.data['bodyMultilang']);
              if (1 != 2) {
                FlutterRingtonePlayer.playNotification();
                showOverlayNotification((context) {
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: SafeArea(
                      child: ListTile(
                        title: Text(message.data['titleMultilang']),
                        subtitle: Text(message.data['bodyMultilang']),
                        trailing: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              OverlaySupportEntry.of(context).dismiss();
                            }),
                      ),
                    ),
                  );
                }, duration: Duration(milliseconds: 2000));
              }
            } else {
              showOverlayNotification((context) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: SafeArea(
                    child: ListTile(
                      // leading: Image.network(
                      //   message.data['image'],
                      //   width: 50,
                      //   height: 70,
                      //   fit: BoxFit.cover,
                      // ),
                      title: Text(message.data['titleMultilang']),
                      subtitle: Text(message.data['bodyMultilang']),
                      trailing: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            OverlaySupportEntry.of(context).dismiss();
                          }),
                    ),
                  ),
                );
              }, duration: Duration(milliseconds: 2000));
            }
          }
        }
      }
    });
    //ANDROID & iOS  onMessageOpenedApp callback
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      Map<String, dynamic> notificationData = message.data;
      AndroidNotification android = message.notification?.android;
      if (android != null) {
        if (notificationData['title'] == 'Call Ended') {
          flutterLocalNotificationsPlugin..cancelAll();
        } else if (notificationData['title'] != 'Call Ended' &&
            notificationData['title'] != 'You have new message(s)' &&
            notificationData['title'] != 'Incoming Video Call...' &&
            notificationData['title'] != 'Incoming Audio Call...' &&
            notificationData['title'] != 'Incoming Call ended' &&
            notificationData['title'] != 'New message in Group') {
          flutterLocalNotificationsPlugin..cancelAll();

          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => MyApp(

                  )));
        } else {
          flutterLocalNotificationsPlugin..cancelAll();
        }
      }
    });


    Future<dynamic> myBackgroundMessageHandlerIos(RemoteMessage message) async {
      await Firebase.initializeApp();
      // ignore: unnecessary_null_comparison
      if (message.data != null) {
        if (message.data['title'] == 'Call Ended') {
          final data = message.data;

          final titleMultilang = data['titleMultilang'];
          final bodyMultilang = data['bodyMultilang'];
          flutterLocalNotificationsPlugin..cancelAll();
          // await _showNotificationWithDefaultSound('Missed Call',
          //     'You have Missed a Call', titleMultilang, bodyMultilang);
        } else {
          if (message.data['title'] == 'You have new message(s)') {
          } else if (message.data['title'] == 'Incoming Audio Call...' ||
              message.data['title'] == 'Incoming Video Call...') {
            // ignore: unnecessary_null_comparison
            if (message.data != null) {
              final data = message.data;
              final title = data['title'];
              final body = data['body'];
              final titleMultilang = data['titleMultilang'];
              final bodyMultilang = data['bodyMultilang'];
              // await _showNotificationWithDefaultSound(
              //     title, body, titleMultilang, bodyMultilang);
            }
          }
        }
      }

      return Future<void>.value();
    }


    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        Map<String, dynamic> notificationData = message.data;
        if (notificationData['title'] != 'Call Ended' &&
            notificationData['title'] != 'You have new message(s)' &&
            notificationData['title'] != 'Incoming Video Call...' &&
            notificationData['title'] != 'Incoming Audio Call...' &&
            notificationData['title'] != 'Incoming Call ended' &&
            notificationData['title'] != 'New message in Group') {
          flutterLocalNotificationsPlugin..cancelAll();

          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => MyApp(

                  )));
        }
      }
    });
  }


  Future<void> sendPushMessage() async {
    if (_token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      // await http.post(
      //   Uri.parse('https://api.rnfirebase.io/messaging/send'),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      //   body: constructFCMPayload(_token),
      // );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }
  //var tokenApi;
  void gettoken()async{
    await HelperFunctions.getUserEmailSharedPreference().then((value){
      print("$value value value");
      if(value!=null ||value!=false){
        print("$value value value");
       _firebaseMessaging.subscribeToTopic('SendRegistered');
      }else{
        print("$value valuekkkk value");
       _firebaseMessaging.subscribeToTopic('SendUnRegistered');
      }
     // tokenApi  = value ;
    });

  }
getToken() async {
  String token = await FirebaseMessaging.instance.getAPNSToken();
  print("${token} ttttttt");
  HelperFunctions.saveUsertokenFcmSharedPreference(token);

}
  Future<void> onActionSelected(String value) async {
    switch (value) {
      case 'subscribe':
        {
          print(
              'FlutterFire Messaging Example: Subscribing to topic "fcm_test".');
          await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
          print(
              'FlutterFire Messaging Example: Subscribing to topic "fcm_test" successful.');
        }
        break;
      case 'unsubscribe':
        {
          print(
              'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test".');
          await FirebaseMessaging.instance.unsubscribeFromTopic('fcm_test');
          print(
              'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test" successful.');
        }
        break;
      case 'get_apns_token':
        {
          if (defaultTargetPlatform == TargetPlatform.iOS ||
              defaultTargetPlatform == TargetPlatform.macOS) {
            print('FlutterFire Messaging Example: Getting APNs token...');
            String token = await FirebaseMessaging.instance.getAPNSToken();
            print('FlutterFire Messaging Example: Got APNs token: $token');
          } else {
            print(
                'FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.');
          }
        }
        break;
      default:
        break;
    }
  }
  start()async{

    return Timer(const Duration(seconds: 3), (){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_){
            return userIsLoggedIn != null ?  userIsLoggedIn ? Home() :  welcome(false): welcome(false);;//;//
          })
      );
    }) ;
  }
  bool _enabled = true;
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor( Color(0xff38056e));

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