import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:mahzoooz/Models/Luck.dart';
import 'package:mahzoooz/Widget/board_view.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'dart:math' as math;
class homeWidget extends StatefulWidget {
  @override
  _homeWidgetState createState() => _homeWidgetState();
}

class _homeWidgetState extends State<homeWidget> with SingleTickerProviderStateMixin {
  Future<void> share(text) async {
    await FlutterShare.share(
        title: 'Example share',
        text:' مـــبرووك كسبت $text' +' من مطعم البيك  حمل الآن تطبيق محظوووظ من الرابط',
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
    Luck("10\$", Color(0xff38056e)),
    Luck("ZERO", Color(0xff80AB40)),
    Luck("2\$", Color(0xff38056e)),
    Luck("50\$", Color(0xff80AB40)),
    Luck("1\$", Color(0xff38056e)),
    Luck("5\$", Color(0xff80AB40)),
    Luck("20\$",Color(0xff38056e)),
    Luck("ZERO",Color(0xff80AB40)),
    Luck("15\$", Color(0xff38056e)),
    Luck("100\$", Color(0xff80AB40)),
    Luck("1\$",Color(0xff38056e)),
    Luck("5\$", Color(0xff80AB40)),
  ];

  @override
  void initState() {   open=true;
    // TODO: implement initState
    super.initState();
    var _duration = Duration(milliseconds: 5000);
    _ctrl = AnimationController(vsync: this, duration: _duration);
    _ani = CurvedAnimation(parent: _ctrl, curve: Curves.fastLinearToSlowEaseIn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
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
                         Container(
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
                         Container(
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
                               ),child: Icon(Icons.visibility_outlined,color:Colors.white,size: 20))))
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
      ),
    );
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
    var _index = _calIndex(_value * _angle + _current);
    String _asset = _items[_index].asset;// _items[_calIndex(_value * _angle + _current)].asset
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Center(
          child: Text(_asset, textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 33,
              color:Color(0xff38056e),
            ),),
        ),
      ),
    );
  }
}
