import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mahzoooz/Screen/Home.dart';
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
  bool resetToggle = false;
  // getIdInState() async {
  //   await HelperFunctions.getUserIdSharedPreference().then((value){
  //     setState(() {
  //       userId  = value;
  //       print(userId);
  //
  //     });
  //   });
  // }
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  @override
  void initState() {

    // getIdInState();
    markers=[];
    super.initState();

    checkLocationServicesInDevice();

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


        location.onLocationChanged.listen((LocationData currentLocation) {
          //  print(currentLocation.latitude.toString() + " yess" + currentLocation.longitude.toString());
          latLnglocation=LatLng(currentLocation.latitude,currentLocation.longitude);
          // List<Placemark> placemarks =  placemarkFromCoordinates(52.2165157, 6.9437819);
          setState(() {
            markers = [
              // Marker(
              //     markerId: MarkerId('first place'),
              //     infoWindow: InfoWindow(
              //         title: 'this place is so nice'
              //     ),
              //     position: LatLng(currentLocation.latitude,currentLocation.longitude)
              // ),
              // Marker(
              //     markerId: MarkerId('place 3'),
              //     infoWindow: InfoWindow(
              //         title: 'this place is so nice'
              //     ),
              //     position: LatLng(41.0240567,29.0840848)
              // ),
            ];
          });


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


  List<Marker> markers ;


  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller = Completer();

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
      setState(() {
        // tappedPoint2=tappedPoint;
        markers=[];
        //adddd=latLng;
        print("${addresses.first.featureName} hhhh  ${addresses.first.addressLine}");
        add1 = addresses.first.featureName;
        add2= addresses.first.addressLine;
        //latLng=tappedPoint;
        markers.add(Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
        ));
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
                  child:  GoogleMap(

                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    markers:markers.toSet(),
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
                      target: LatLng(22.774265, 46.738586),
                      zoom: 4.0,
                    ) ,
                  ),
                ),
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
        if(latLng==null){
          setState(() {
            latLng=latLnglocation;
          });
        }else{
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_){
                return  Home() ;//
              })
          );
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
        width: MediaQuery.of(context).size.width*0.6,
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
                "اعتماد",
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
