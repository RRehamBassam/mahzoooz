
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mahzoooz/Models/Luck.dart';
import 'package:mahzoooz/Screen/RestaurantData.dart';
import 'package:mahzoooz/Screen/mapLoc.dart';
import 'package:mahzoooz/Widget/board_view.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'dart:math' as math;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mahzoooz/Widget/loading.dart';
import 'package:mahzoooz/api/NetworkRequest.dart';
import 'package:mahzoooz/main.dart';
import 'package:mahzoooz/services/helperFunctions.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:mahzoooz/services/providerUser.dart';


class homeWidget extends StatefulWidget {
  LatLng latLnglocation;

  homeWidget(this.latLnglocation);

  @override
  _homeWidgetState createState() => _homeWidgetState(latLnglocation);
}

class _homeWidgetState extends State<homeWidget> with SingleTickerProviderStateMixin {
  LatLng latLnglocation;

  _homeWidgetState(this.latLnglocation);

  Future<void> share(text) async {
    await FlutterShare.share(
        title: 'Example share',
        text:' مـــبرووك كسبت $text' +'  حمل الآن تطبيق محظوووظ من الرابط',
      //  linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title'
    );
  }
  var AddressLocal;
  var AddressChang;
  getAddressLocalState() async {
    await HelperFunctions.getUserAddressLocalSharedPreference().then((value){
      setState(() {
        AddressLocal  = value;
      });
    });}
  getAddressChangeState() async {
    await HelperFunctions.getUserAddressChangeSharedPreference().then((value){
      setState(() {
        AddressChang  = value;
      });
    });}
  bool open=true;
  bool win=false;
  double _angle = 0;
  double _current = 0;
  AnimationController _ctrl;
  Animation _ani;
  List<Luck> _items = [
    // Luck("10\$", Color(0xff38056e)),
    // Luck("ZERO", Color(0xff80AB40)),
    // Luck("2\$", Color(0xff38056e)),
    // Luck("50\$", Color(0xff80AB40)),
    // Luck("1\$", Color(0xff38056e)),
    // Luck("5\$", Color(0xff80AB40)),
    // Luck("20\$",Color(0xff38056e)),
    // Luck("ZERO",Color(0xff80AB40)),
    // Luck("15\$", Color(0xff38056e)),
    // Luck("100\$", Color(0xff80AB40)),
    // Luck("1\$",Color(0xff38056e)),
    // Luck("5\$", Color(0xff80AB40)),
  ];
  var token;
  void gettoken()async{
    await HelperFunctions.getUserEmailSharedPreference().then((value){
      token  = value ;
    });
  }
  NetworkRequest networkRequest=new NetworkRequest();
  final String url = "http://ahmed453160-001-site1.etempurl.com/Offers/GetRandomOffers";
  List data =[];
  // Future<String> getSWData() async {
  //
  //   var res = await http
  //       .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
  //   var resBody = json.decode(res.body);
  //   print(resBody['data']['data'][1]['titeAr']);
  //   print("ppppppppppppppp");
  //    for(int i=0;i<resBody['data']['data'].Length;i++){
  //     Luck newluck= await new Luck(resBody['data']['data'][i]['titeAr'],Color(0xff80AB40));
  //
  //     setState(() {
  //       _items.add(newluck);
  //      // _items=data;
  //       // data = resBody['data'];
  //     });
  //   }
  //   // setState(() {
  //   //
  //   //  // data = resBody['data'];
  //   // });
  //   print(data);
  //
  //   return "Sucess";
  // }
  bool select;
  double lat;
  double lng;
  @override
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
  void initState() {
    gettoken();
    getLatInState();
    select=false;
    getAddressLocalState();
    getAddressChangeState();
    //getSWData();
    open=true;
    // TODO: implement initState
    super.initState();
    var _duration = Duration(milliseconds: 5000);
    _ctrl = AnimationController(vsync: this, duration: _duration);
    _ani = CurvedAnimation(parent: _ctrl, curve: Curves.fastLinearToSlowEaseIn);
  }
  var addressesList;
 var addresses;
  @override
  Widget build(BuildContext context) {
    final coordinates= new Coordinates(latLnglocation.latitude,latLnglocation.longitude);
    // addressesList= Geocoder.local.findAddressesFromCoordinates(coordinates);
    // addresses='${addressesList.first.featureName} ${addressesList.first.addressLine}';
    return SafeArea(
      child:FutureBuilder<dynamic>(
        future: networkRequest.getLuck(latLnglocation),
    builder: (context, snapshot) {
    if (snapshot.hasData) {
      if(_items.length==0)
    {
      for(int i=0;i<snapshot.data['data'].length;i++){
        Luck newluck=  new Luck(snapshot.data['data'][i]['titeAr'],i%2==0?Color(0xff38056e):Color(0xff80AB40),snapshot.data['data'][i]['titleEn']);
        _items.add(newluck);

      }
    }
    return  Column(
        children: [

          //
          // open?  InkWell(onTap: ()=>setState(()=>open=!open),
          //     child: Image.asset("Assets/Group 39799.png",scale: 1.5,)):Image.asset("Assets/Group 39784.png",scale: 1.5,),
          Container(
            height:MediaQuery.of(context).size.height*0.85,
            child: AnimatedBuilder(
                animation: _ani,
                builder: (context, child) {
                  final _value = _ani.value;
                value=_ani.value;



                  final _angle = _value * this._angle;
                  return Stack(
                    alignment: Alignment.center,
                    children: <Widget>[

                  Column(
                  children: [
                  Container(
                      height: MediaQuery.of(context).size.height*0.2,
                  child: Stack(
                  children: [
                  Column(
                  children: [
                  SizedBox(height: 30,),
                  Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Image.asset("Assets/Image-2.png")
                  ],
                  ),
                    SizedBox(height: 5,),
                   Column(

                     children: [
                       Container(
                         height: 33,
                         padding: EdgeInsets.all(8),
                         width:MediaQuery.of(context).size.width*0.85,
                         decoration: BoxDecoration(
                           borderRadius: const BorderRadius.all(
                             const Radius.circular(8),
                           ),
                           boxShadow: [
                             BoxShadow(
                               color: Colors.black12,
                               offset: const Offset(
                                 2.0,
                                 2.0,
                               ),
                               blurRadius: 5.0,
                               spreadRadius: 1.0,
                             ), //BoxShadow
                             BoxShadow(
                               color: Colors.white,
                               offset: const Offset(0.0, 0.0),
                               blurRadius: 0.0,
                               spreadRadius: 0.0,
                             ), //BoxShadow
                           ],
                         ),
                         child:         InkWell(
                           onTap:(){
                             Navigator.push(context, new MaterialPageRoute(builder: (context)=>new maps()));
                             },
                           child: Row(children: [
                             Icon(Icons.location_on,color: Color(0xff38056e),size: 18,),
                             Container(
                                 margin: EdgeInsets.only(top: 3),
                                 child: Text(translator.translate("current location"),style: TextStyle(color: Color(0xff38056e),fontWeight:FontWeight.w500,fontSize:MediaQuery.of(context).size.height< 743.4285714285714?9: 12 ),)),
                             SizedBox(width: 2,),
                             Container(
                                 width:MediaQuery.of(context).size.height< 743.4285714285714?MediaQuery.of(context).size.width*0.46:MediaQuery.of(context).size.width*0.5,
                                 margin: EdgeInsets.only(top: 3),
                                 child: Text(" $AddressChang", overflow: TextOverflow.ellipsis,style: TextStyle(color:Color(0xff80AB40,),fontSize: 10),)),
                             Spacer(),
                             AddressChang!=null?   InkWell(
                                 onTap: (){
                                   setState(() {
                                     select=!select;
                                   });
                                 },
                                 child: Icon(Icons.arrow_drop_down,color: Colors.grey,)):Container()

                           ],),
                         ),
                       ),
                       SizedBox(height: 5,),
                       AddressChang!=null? select?  InkWell(
                         onTap:(){
                           HelperFunctions.saveUserlocationLatSharedPreference(null);
                           HelperFunctions.saveUserlocationlngSharedPreference(null);
                           Navigator.of(context).pushAndRemoveUntil(
                               MaterialPageRoute(builder: (_){
                                 return MyApp();
                               }),(route)=> false
                           );
                  },
                         child: Container(
                           height: 33,
                           padding: EdgeInsets.all(8),
                           width:MediaQuery.of(context).size.width*0.73,
                           decoration: BoxDecoration(
                             borderRadius: const BorderRadius.all(
                               const Radius.circular(8),
                             ),
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.black12,
                                 offset: const Offset(
                                   1.0,
                                   1.0,
                                 ),
                                 blurRadius: 2.0,
                                 spreadRadius: 0.5,
                               ), //BoxShadow
                               BoxShadow(
                                 color: Colors.white,
                                 offset: const Offset(0.0, 0.0),
                                 blurRadius: 0.0,
                                 spreadRadius: 0.0,
                               ), //BoxShadow
                             ],
                           ),
                           child:         Row(children: [

                             // Container(
                             //     margin: EdgeInsets.only(top: 3),
                             //     child: Text("موقعك الحالي",style: TextStyle(color: Color(0xff38056e),fontWeight:FontWeight.w500 ),)),
                             // SizedBox(width: 2,),
                             Container(
                                 margin: EdgeInsets.only(top: 3),
                                 child: Text("تغيير الموقع الى الموقعك الان", overflow: TextOverflow.ellipsis,style: TextStyle(color:Color(0xff80AB40),fontSize: 10),)),
                             Spacer(),


                           ],),
                         ),
                       ):Container():Container()
                     ],
                   )
                  ],
                  ),
                  // Positioned(
                  // left: 40,
                  // top: 42,
                  // child: Row(
                  //   children: [
                  //     Container(
                  //        // margin: EdgeInsets.only(top: 20),
                  //         height: 32.00,
                  //         width: 32.00,
                  //         decoration: BoxDecoration(
                  //           color: Color(0xfe38056e),borderRadius: BorderRadius.circular(25.00),
                  //         ),child: Image.asset("Assets/Notification.png",color:Colors.white,scale: 1.2,)),
                  //     SizedBox(width: 8,),
                  //     Container(
                  //         //margin: EdgeInsets.only(top: 20),
                  //         height: 32.00,
                  //         width: 32.00,
                  //         decoration: BoxDecoration(
                  //           color: Color(0xfe38056e),borderRadius: BorderRadius.circular(25.00),
                  //         ),child: Image.asset("Assets/gift (1).png",color:Colors.white,scale: 1.2,)),
                  //
                  //
                  //   ],
                  // ),
                  // )
                  ],
                  ),
                  ),

                  Container(
                  height:MediaQuery.of(context).size.height< 743.4285714285714?  MediaQuery.of(context).size.height*0.18: MediaQuery.of(context).size.height*0.23,
                  child:win?Column(
                  children: [
                  new Text(
                  translator.translate( "Congratulations you won"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize:MediaQuery.of(context).size.height< 783.4285714285714?16 : 19,
                  fontWeight:FontWeight.w700 ,
                  color:Colors.black54,
                  ),
                  ),
                    MediaQuery.of(context).size.height< 783.4285714285714?Container(): SizedBox(height: 2,),
                  _buildResult(_value),
                //  SizedBox(height: 2,),
                   Center(
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         InkWell(
                           onTap:() async {
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
                               await addFavourites(snapshot.data['data'][_calIndex(_value * _angle + _current)]['id']);
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
                           child: Container(
                             margin: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                             height: 32.00,
                             width: 32.00,
                             decoration: BoxDecoration(
                               color: Color(0xff38056e),borderRadius: BorderRadius.circular(25.00),
                             ),child: Material(
                               elevation: 4,borderRadius: BorderRadius.circular(25.00),
                      child: Container(
                                 //  margin: EdgeInsets.all( 10),
                                  height: 32.00,
                                width: 32.00,
                                 decoration: BoxDecoration(
                                     color: Color(0xff38056e),borderRadius: BorderRadius.circular(25.00),
                                 ),child: Icon(Icons.favorite_border,color:Colors.white,size: 20,)),
                  ),
                           ),
                         ),
                         InkWell(
                          onTap:()=>share( _items[_calIndex(_value * _angle + _current)].asset),
                           child: Container(
                             margin: EdgeInsets.all( 10),
                             height: 32.00,
                             width: 32.00,
                             decoration: BoxDecoration(
                               color: Color(0xff38056e),borderRadius: BorderRadius.circular(25.00),
                             ),child: Material(
                             elevation:4,
                               borderRadius: BorderRadius.circular(25.00),
                             child: Transform(
                               alignment: Alignment.center,
                               transform:   Matrix4.rotationY(math.pi),
                               child: Container(
                                //   margin: EdgeInsets.all( 10),
                                   height: 32.00,
                                   width: 32.00,
                                   decoration: BoxDecoration(
                                     color: Color(0xff38056e),borderRadius: BorderRadius.circular(25.00),
                                   ),child: Icon(Icons.reply_outlined,color:Colors.white,size: 20)),
                             ))),
                         ),
                         InkWell(
                           onTap:(){
                             // Navigator.push(context,PageTransition(
                             //   type: PageTransitionType.bottomToTop,
                             //   duration: Duration(milliseconds: 550) ,
                             //   reverseDuration: Duration(milliseconds: 700),
                             //   child:ReservationService(data['bookingSettings'],data['offer']['id']),
                             // ),);
                           //  showDialog(snapshot.data['data'][0]['discount']);
                            // print(_index +snapshot.data['data'][Provider.of<providerUser>(context, listen: true).RandomNum]['id']);

                             print("rrrrrrrr");
                             Navigator.push(context,PageTransition(
                               type: PageTransitionType.leftToRight,
                               duration: Duration(milliseconds: 550) ,
                               reverseDuration: Duration(milliseconds: 700),
                               child: RestaurantData(snapshot.data['data'][_calIndex(_value * _angle + _current)]),
                             ),);
                  },
                           child: Container(
                             margin: EdgeInsets.all( 10),
                             height: 32.00,
                             width: 32.00,
                             decoration: BoxDecoration(
                               color: Color(0xff38056e),borderRadius: BorderRadius.circular(25.00),
                             ),child: Material(
                               borderRadius: BorderRadius.circular(25.00),
                             elevation: 4,
                             child: Container(
                               //  margin: EdgeInsets.all( 10),
                                 height: 32.00,
                                 width: 32.00,
                                 decoration: BoxDecoration(
                                   color: Color(0xff38056e),borderRadius: BorderRadius.circular(25.00),
                                 ),child: Icon(Icons.visibility_outlined,color:Colors.white,size: 20)))),
                         )
                       ],
                     ),
                   )
                  // new Text(
                  //   "دلوقتي تقدر تلعب انت و أصحابك",
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //
                  //     fontSize: 14,
                  //     color:Color(0xffb4b9b9),
                  //   ),
                  // )
                  ],
                  ):open? Column(
                  children: [
                  new Text(
                  translator.translate("Enjoy your time now" ),//  "السحب جاهز دلوقتي",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize:MediaQuery.of(context).size.width<350?16: 19,
                  color:Colors.black54,
                  ),
                  ),
                  SizedBox(height: 4,),
                  new Text(
                  translator.translate( "Click start playing"),  //"أضغط و استتمع",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize:MediaQuery.of(context).size.width<350?25:33,
                  color:Color(0xff38056e),
                  ),
                  ),
                  SizedBox(height: 4,),
                  new Text(
                  translator.translate("check your luck from hundreds of offers and discounts") ,//"دلوقتي تقدر تلعب انت و أصحابك",
                  textAlign: TextAlign.center,
                  style: TextStyle(

                  fontSize:MediaQuery.of(context).size.width<350?12:14,
                  color:Colors.black54,
                  ),
                  )
                  ],
                  ):
                  Column(
                  children: [
                  new Text(
                  "باقي علي فتح بوابه الحظ",
                  textAlign: TextAlign.center,
                  style: TextStyle(

                  fontSize: 19,
                  color:Color(0xffb4b9b9),
                  ),
                  ),
                  SizedBox(height: 2,),
                  new Text(
                  "00:20:30",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 33,
                  color:Color(0xff38056e),
                  ),
                  ),
                  SizedBox(height: 2,),
                  new Text(
                  "دلوقتي تقدر تلعب انت و أصحابك",
                  textAlign: TextAlign.center,
                  style: TextStyle(

                  fontSize: 14,
                  color:Color(0xffb4b9b9),
                  ),
                  )
                  ],
                  ),
                  ),]),

                      Positioned(
                        top:MediaQuery.of(context).size.height< 743.4285714285714?265:330,//250
                         // right:MediaQuery.of(context).size.height<800?0:2,
                          child: Container(
                  alignment:Alignment.center,
                            width:MediaQuery.of(context).size.width * 0.75,
                            height:MediaQuery.of(context).size.width * 0.75,
                            child: Stack(
                              children: [
                                BoardView(items: _items, current: _current, angle: _angle),
                            Positioned(
                              top:MediaQuery.of(context).size.width * 0.294,
                                left:MediaQuery.of(context).size.width * 0.294,
                                child: _buildGo())
                              ],
                            ),
                          )

                      ),
               //    Positioned(
               // // top:MediaQuery.of(context).size.height< 743.4285714285714?350:430,
               //   // child: _buildGo()
               //    ),
                      //
                    ],
                  );
                }),
          )


        ],

    );}
    else if (snapshot.hasError) {
    return Center(child: Text("تأكد من إتصال بالإنرنت"));
    }
    // By default, show a loading spinner.
    return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    SizedBox(height: 30,),
    // CategoriesLoud(snapshot.data,true),
    // CategoriesLoud(snapshot.data,true),
    // CategoriesLoud(snapshot.data,true),
    //  CategoriesLoud(snapshot.data,true),
    Loading(),
    // Center(
    //   child: PixLoader(
    //       loaderType: LoaderType.Spinner, faceColor: Color(0xfff99b1d)),
    // )
    //CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xfff99b1d) ),)
    ],
    );}));
  }
  var value;
  _buildGo() {

    return Material(
      color: Colors.white,
      shape: CircleBorder(),
      child: InkWell(
        customBorder: CircleBorder(),
        child: Center(
          child: Container(
            alignment: Alignment.center,
            height: 68,
            width: 68,
            child: Center(
              child: Text(
                "إبدأ \nاللعب",

               // textDirection: TextDirection,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold,color: Color(0xff38056E),),
              ),
            ),
          ),
        ),
        onTap: _animation,
      ),
    );
  }
  _animation() async{
    print("ll");
    if (!_ctrl.isAnimating) {
      var _random = Random().nextDouble();
      _angle = 20 + Random().nextInt(5) + _random;
      await _ctrl.forward(from: 0.0).then((_) {
        _current = (_current + _random);
        _current = _current - _current ~/ 1;
     _ctrl.reset();
      });
    }
    setState(() {
      win=true;
    });
  }

  int _calIndex(value) {
    var _base = (2 * pi / _items.length / 2) / (2 * pi);
    return (((_base + value) % 1) * _items.length).floor();
  }

  _buildResult(_value) {
    var  _index = _calIndex(_value * _angle + _current);
   context.read<providerUser>().updateRandomNum(_value);
    String _asset = translator.currentLanguage == 'ar' ? _items[_index].asset:_items[_index].assetEn;// _items[_calIndex(_value * _angle + _current)].asset
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Center(
          child: Text(_asset, textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize:_asset.length>10?MediaQuery.of(context).size.height< 783.4285714285714?18:22: MediaQuery.of(context).size.height< 783.4285714285714?28:33,
              color:Color(0xff38056e),
            ),),
        ),
      ),
    );
  }
  
  var message;
  addFavourites(id) async {
    await  networkRequest.AddFavourites(id).then((value){
      setState(() {
        message  = value;
      });
    });
  }
}
