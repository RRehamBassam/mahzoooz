import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mahzoooz/Models/Luck.dart';
import 'package:mahzoooz/Screen/RestaurantData.dart';
import 'package:mahzoooz/Widget/board_view.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'dart:math' as math;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mahzoooz/Widget/loading.dart';
import 'package:mahzoooz/api/NetworkRequest.dart';
import 'package:mahzoooz/services/helperFunctions.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:mahzoooz/services/providerUser.dart';

class homeWidget extends StatefulWidget {
  @override
  _homeWidgetState createState() => _homeWidgetState();
}

class _homeWidgetState extends State<homeWidget> with SingleTickerProviderStateMixin {
  Future<void> share(text) async {
    await FlutterShare.share(
        title: 'Example share',
        text:' مـــبرووك كسبت $text' +'  حمل الآن تطبيق محظوووظ من الرابط',
      //  linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title'
    );
  }
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
  Future<String> getSWData() async {

    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    print(resBody['data']['data'][1]['titeAr']);
    print("ppppppppppppppp");
     for(int i=0;i<resBody['data']['data'].Length;i++){
      Luck newluck= await new Luck(resBody['data']['data'][i]['titeAr'],Color(0xff80AB40));

      setState(() {
        _items.add(newluck);
       // _items=data;
        // data = resBody['data'];
      });
    }
    // setState(() {
    //
    //  // data = resBody['data'];
    // });
    print(data);

    return "Sucess";
  }
  @override
  void initState() {
    gettoken();
    //getSWData();
    open=true;
    // TODO: implement initState
    super.initState();
    var _duration = Duration(milliseconds: 5000);
    _ctrl = AnimationController(vsync: this, duration: _duration);
    _ani = CurvedAnimation(parent: _ctrl, curve: Curves.fastLinearToSlowEaseIn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:FutureBuilder<dynamic>(
        future: networkRequest.getLuck(),
    builder: (context, snapshot) {
    if (snapshot.hasData) {
      if(_items.length==0)
    {
      for(int i=0;i<snapshot.data['data'].length;i++){
        Luck newluck=  new Luck(snapshot.data['data'][i]['titeAr'],i%2==0?Color(0xff38056e):Color(0xff80AB40));
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
                  height: MediaQuery.of(context).size.height*0.23,
                  child:win?Column(
                  children: [
                  new Text(
                  "مـــبرووك كسبت",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 19,
                  fontWeight:FontWeight.w700 ,
                  color:Colors.black54,
                  ),
                  ),
                  SizedBox(height: 2,),
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
                                 ),child: Icon(Icons.bookmark_border_rounded,color:Colors.white,size: 20,)),
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
                  "السحب جاهز دلوقتي",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 19,
                  color:Colors.black54,
                  ),
                  ),
                  SizedBox(height: 2,),
                  new Text(
                  "أضغط و استتمع",
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
                        top:MediaQuery.of(context).size.height< 743.4285714285714?250:330,
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
        child: Container(
          alignment: Alignment.center,
          height: 68,
          width: 68,
          child: Center(
            child: Text(
              "SPIN\nNOW",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,color: Color(0xff38056E)),
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
    String _asset = _items[_index].asset;// _items[_calIndex(_value * _angle + _current)].asset
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Center(
          child: Text(_asset, textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize:_asset.length>10?22: 33,
              color:Color(0xff38056e),
            ),),
        ),
      ),
    );
  }
  void showDialog(discount) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 300,
            
            child: SizedBox.expand(child:Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  //  FlutterLogo(),
              SizedBox(
                width: 68.0,
                child: Text(
                  '!تهانينا',
                  style: TextStyle(
                    fontFamily: 'Nunito Sans',
                    fontSize: 22,
                    color: const Color(0xff38056e),
                    fontWeight: FontWeight.w700,
                    height: 1.8181818181818181,
                  ),
                  textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.right,
                ),
              ),
                  ],
                ),
                Positioned(
                  top: 18,
                  left: 20,
                  child:      Center(
                    child: new Container(
                      height: 27.00,
                      width: 76.00,
                      decoration: BoxDecoration(
                        color:Color(0xff38056e) ,borderRadius: BorderRadius.circular(10.00),
                      ),
                      child: Center(
                        child: new  Text(" %${discount.toString()} خصم ",
                          //"٢٥٪ خصم",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Tajawal",fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color:Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
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
