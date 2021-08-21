import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mahzoooz/Screen/Home.dart';
import 'package:mahzoooz/Widget/loading.dart';
import 'package:mahzoooz/main.dart';
import 'package:mahzoooz/services/helperFunctions.dart';
//import 'SignIn.dart';
class maps extends StatefulWidget {
  // Req req;

  maps();

  @override
  _mapsState createState() => _mapsState();
}

class _mapsState extends State<maps> {
  Completer<GoogleMapController> _controller2 = Completer();
  LatLng adddd;
  _mapsState();
  LatLng tappedPoint2;
  //ServerAddresses serverAddresses=new ServerAddresses();
  Location location = new Location();
  var addresses;
  LatLng latLng;
  LatLng latLnglocation;
  String userId;
  String add1;
  String add2;
  LatLng pp;
  bool resetToggle = false;
  var lng;
  var lat;
  getLatInState() async {
    await HelperFunctions.getUserLatInSharedPreference().then((value){
      if(value!=null) {
        setState(() {
          lat = value;
        });
      }else{
        setState(() {
          lat=24.75007441712588;
        });

      }
    });
    await HelperFunctions.getUserLngSharedPreference().then((value){
     if(value!=null) {
        setState(() {
          lng = value;
          latLnglocation = LatLng(lat == null ? 1 : lat, lng == null ? 1 : lng);
        });
      }else{
       lng=46.775951958232405;
     }
    });
    print("${latLnglocation.latitude} ljlj");
    final coordinates= new Coordinates(latLnglocation.latitude,latLnglocation.longitude);
    addresses=await Geocoder.local.findAddressesFromCoordinates(coordinates);
    HelperFunctions.saveUserAddressChangeSharedPreference(" ${addresses.first.addressLine}");
    setState(() {

    });
   // getDataRandom();
    // await checkLocationServicesInDevice();
  }
  // getIdInState() async {
  //   await HelperFunctions.getUserIdSharedPreference().then((value){
  //     setState(() {
  //       userId  = value;
  //       print(userId);
  //
  //     });
  //   });
  // }
  bool init;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  @override
  void initState() {
    markers = [];
    init=true;
    lat=24.75007441712588;
    lng=46.775951958232405;
    getLatInState();
    // getIdInState();
    addresses=null;
    super.initState();
    getLoggedaddressInState();
  //  checkLocationServicesInDevice();

  }
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
         // latLnglocation= LatLng(currentLocation.latitude,currentLocation.longitude);
          print("$latLnglocation kkk");
          // List<Placemark> placemarks =  placemarkFromCoordinates(52.2165157, 6.9437819);

       // //
         // print("kkkkkkk${addresses.first.addressLine}");
         // HelperFunctions.saveUserAddressLocalSharedPreference(' ${addresses.first.addressLine}');
          await markers.add(Marker(
            markerId: MarkerId(latLnglocation.toString()),
            position: latLnglocation,
          ));
          // final coordinates2= new Coordinates(latLnglocation.latitude,latLnglocation.longitude);
          // addresses=await Geocoder.local.findAddressesFromCoordinates(coordinates2);
          // addresses=addresses.first.addressLine;
          if(init) {
            markers = [
              // Marker(
              //     markerId: MarkerId('my Location'),
              //     infoWindow: InfoWindow(
              //         title: 'this place is so nice'
              //     ),
              //     position: LatLng(
              //         currentLocation.latitude, currentLocation.longitude)
              // ),
              // Marker(
              //     markerId: MarkerId('place 3'),
              //     infoWindow: InfoWindow(
              //         title: 'this place is so nice'
              //     ),
              //     position: LatLng(41.0240567,29.0840848)
              // ),
            ];
            init=false;
            setState(() {

            });
          }

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
  String _address = ""; // create this variable
  getLoggedaddressInState() async {
    await HelperFunctions.getUserAddressChangeSharedPreference().then((value){
      setState(() {
        addresses  = value;
      });
    });
  }

  List<Marker> markers ;


  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor( Color(0xff38056e));
    Completer<GoogleMapController> _controller = Completer();
    FlutterStatusbarcolor.setStatusBarColor( Color(0xffffffff));
    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );

    final CameraPosition _kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(37.43296265331129, -122.08832357078792),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);
    Future<void> _goToTheLake() async {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    }
    _handel(LatLng tappedPoint,)async {
      print(tappedPoint);
      final coordinates= new Coordinates(tappedPoint.latitude,tappedPoint.longitude);
      addresses=await Geocoder.local.findAddressesFromCoordinates(coordinates);
      HelperFunctions.saveUserAddressChangeSharedPreference(" ${addresses.first.addressLine}");//${addresses.first.featureName}
      addresses=addresses.first.addressLine;
      setState(() {
        // tappedPoint2=tappedPoint;
      markers=[];
        //adddd=latLng;
        // print("${addresses.first.featureName} hhhh  ${addresses.first.addressLine}");
        // add1 = addresses.first.featureName;
        // add2= addresses.first.addressLine;
        //latLng=tappedPoint;
      HelperFunctions.saveUserlocationLatSharedPreference(tappedPoint.latitude);
      HelperFunctions.saveUserlocationlngSharedPreference(tappedPoint.longitude);
        // markers.add(Marker(
        //   markerId: MarkerId(tappedPoint.toString()),
        //   position: tappedPoint,
        // ));
      });
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          bearing: 192.8334901395799,
          target: LatLng(tappedPoint.latitude, tappedPoint.longitude),
          tilt: 59.440717697143555,
          zoom: 10.151926040649414)));
      // _goToTheLake();
    }
    return Scaffold(

        body:Material(
            child:Stack(
              children: <Widget>[

                // Map(),
                Container(
                  margin: EdgeInsets.only(top:13),
                  child: GoogleMap(

                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                  //  markers:markers.toSet(),
                onCameraMoveStarted:() {

                },
                    onCameraIdle: () async {
                      final coordinates= new Coordinates(pp.latitude,pp.longitude);
                      addresses=await Geocoder.local.findAddressesFromCoordinates(coordinates);
                      HelperFunctions.saveUserAddressChangeSharedPreference(" ${addresses.first.addressLine}");
                      HelperFunctions.saveUserlocationLatSharedPreference(
                          pp.latitude);
                      HelperFunctions.saveUserlocationlngSharedPreference(
                          pp.longitude);
                      print('$addresses');
                      print('pppppppp');
                      setState(() {
                        lat=pp.latitude;
                        lng=pp.longitude;

                      });

                    },
                    onCameraMove: (position) async {
                      print(position.target
                          .latitude); //لطباعة خط الطول اللي في مركز الخريطةوطبعا بيتغير كل ما حركنا الخريطة
                      print(position
                          .target.longitude);
                      HelperFunctions.saveUserlocationLatSharedPreference(position.target
                          .latitude);
                      HelperFunctions.saveUserlocationlngSharedPreference(position
                          .target.longitude);
setState(() {
  pp=position
      .target;
});
                      // final coordinates= new Coordinates(position.target.latitude,position.target.longitude);
                      // addresses=await Geocoder.local.findAddressesFromCoordinates(coordinates);
                      // HelperFunctions.saveUserAddressChangeSharedPreference(" ${addresses.first.addressLine}");
                      // print('$addresses');
                      // print('pppppppp');
                      // setState(() {
                      //
                      // });

                      //لطباعة خط العرض كل ماحركنا الخريطة
                    },
                    onMapCreated: (GoogleMapController controlle)async {
                      _controller.complete(controlle);
                      //                   final GoogleMapController controller = await _controller.future;
                      // controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                      //     bearing: 192.8334901395799,
                      //     target: LatLng(22.774265, 46.738586),
                      //     tilt: 59.440717697143555,
                      //     zoom: 16.151926040649414)));

                    },
                    onTap: _handel,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(lat,lng),//LatLng(latLnglocation.latitude, latLnglocation.longitude),
                      zoom: 8.0,
                    ) ,
                  ),
                ),
                Center(
                  child: InkWell(
                    onTap: () async {
                      final coordinates= new Coordinates(lat,lng);
                      addresses=await Geocoder.local.findAddressesFromCoordinates(coordinates);
                      HelperFunctions.saveUserAddressChangeSharedPreference(" ${addresses.first.addressLine}");
                      addresses=addresses.first.addressLine;
                      setState(() {

                      });
                    },
                      child: Icon(Icons.location_on,size: 38,color: Color(0xff80AB40),)),
                ),

      Positioned(

                    top:25,
                    child:
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [BoxShadow(
                            color: Color.fromRGBO(34, 134, 234, .3),
                            blurRadius: 10,
                            offset: Offset(0, 5)
                        )],

                      ),
                      height: 55,
                      margin: EdgeInsets.only(top: Platform.isIOS?22:0),
                      padding: EdgeInsets.all(12),
                      width: MediaQuery.of(context).size.width,
                      child:Row(
                        children: [
                          InkWell(
                            onTap:(){
                     Navigator.pop(context);
                    },
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.1,
                            child:Platform.isIOS?Icon(Icons.arrow_back_ios,size: 18,):Icon(Icons.arrow_forward_ios,size: 18,),
                      ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.8,
                            child: Row(

                              children: [
                      Center(child: Container(
                          width: MediaQuery.of(context).size.width*0.78,
                          child: Center(child: Text(addresses is String?addresses==null?"":"$addresses":addresses==null?"":"${addresses.first.addressLine}")))


                            )
                        ],
                      ),
                          ),
                   ]) )),
                Positioned(
                    right: 30,
                    left: 30,
                    bottom: 40,
                    child:
                    Button()),
              ],
            )
        ));
  }

  GoogleMapController mapController;
  void onMapCreated(controller) {
    mapController
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
            LatLng(25.94958744267017, 42.40264501422644).latitude, LatLng(25.94958744267017, 42.40264501422644).longitude),
        zoom: 17.0,
        bearing: 90.0,
        tilt: 45.0)))
        .then((val) {
      setState(() {
        resetToggle = true;
      });
    });

    // mapController.animateCamera(CameraUpdate.newCameraPosition(
    //     CameraPosition(target: LatLng(40.7128, -74.0060), zoom: 4.0))).then((val) {
    //   setState(() {
    //     mapController = controller;
    //    resetToggle = false;
    //   });
    // });
    setState(() {
      // mapController = controller;
    });}

  Widget Button(){

    return   InkWell(
      onTap:(){

        HelperFunctions.saveUserlocationLatSharedPreference(lat);
        HelperFunctions.saveUserlocationlngSharedPreference(lng);
        if(latLng==null){
          print("3");
          setState(() {
            latLng=latLnglocation;
          });
        }else{
          print("4");
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_){
                return MyApp();
              }),(route)=> false
          );
          // Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(builder: (_){
          //       return  MyApp() ;//
          //     })
          // );
          // Fluttertoast.showToast(
          //     msg: " يرجى الانتظار لحين تفعيل حسابك",
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.BOTTOM,
          //     timeInSecForIosWeb: 1,
          //     backgroundColor: Color(0xfff99b1d).withOpacity(0.9),
          //     textColor: Colors.white,
          //     fontSize: 16.0
          // );
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (_){
          //       return  SignIn();
          //     }),(route)=> false
          // );
          // serverAddresses.addAddress(userId,"${latLng.longitude}","${latLng.latitude}");
          // Navigator.push(context, new MaterialPageRoute(builder: (context)=>new Payment(req,"$add1 / $add2")));
        }
        //Navigator.popAndPushNamed(context, '/activateCode');
      } ,
      child: new Container(
        height: MediaQuery.of(context).size.width*0.13,
        width: MediaQuery.of(context).size.width*0.55,
        margin: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(
              color: Color.fromRGBO(34, 134, 234, .3),
              blurRadius: 20,
              offset: Offset(0, 10)
          )],
          color: Color(0xff80AB40),borderRadius: BorderRadius.circular(50.00),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
          translator.translate( "تأكيد العنوان"),
                style: TextStyle(
                  fontFamily: "Tajawal",fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color:Color(0xffffffff),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller2.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
            LatLng(25.94958744267017, 42.40264501422644).latitude, LatLng(25.94958744267017, 42.40264501422644).longitude),
        zoom: 17.0,
        bearing: 90.0,
        tilt: 45.0)));
  }

}
