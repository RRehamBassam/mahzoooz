import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mahzoooz/Screen/ProfileScreen/aboutApp.dart';
import 'package:mahzoooz/Screen/mapLoc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restart/flutter_restart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:mahzoooz/Screen/Auth/welcome.dart';
import 'package:mahzoooz/Widget/AppBarTop.dart';
import 'package:mahzoooz/Screen/Settings.dart';
import 'package:mahzoooz/Screen/ProfileScreen/myReservations.dart';
import 'package:mahzoooz/services/helperFunctions.dart';
import 'package:page_transition/page_transition.dart';
import 'package:mahzoooz/Screen/ProfileScreen/Favourites.dart';
import 'package:mahzoooz/Screen/ProfileScreen/myCouponDiscount.dart';
import 'package:mahzoooz/api/NetworkRequest.dart';
import 'package:mahzoooz/Widget/loading.dart';
import 'package:mahzoooz/Screen/Auth/editProfile.dart';
import 'package:provider/provider.dart';
import 'package:mahzoooz/services/providerUser.dart';
import 'dart:convert' as convert;

import '../../main.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  NetworkRequest networkRequest=new NetworkRequest();
  Uint8List bytes;
  ScrollController _controller = new ScrollController();
  Future<String> getData() async {
    await Future<void>.delayed(Duration(seconds: 3));
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
  var data;
  var edAdd;
  Future<String> getSWData(cityInt) async {
    var res = await http
        .get(Uri.encodeFull('http://ahmed453160-001-site1.etempurl.com/Countries/GetAll'), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    print(resBody);
    setState(() {
      data = resBody['data'];
    });
    for(int i;i<data.length;i++){
      if(data[i]['id']==cityInt)
        setState(() {
          edAdd=data[i]['nameAr'];
        });

    };
    print(data);

    return "Sucess";
  }



  getImageInState() async {
    await HelperFunctions.getUserImageSharedPreference().then((value){
      setState(() {

    //    bytes = convert.base64.decode(value);
      });
    });
  }
bool initData;
  @override
  void initState() {
    getImageInState();
    initData=true;
    getDatatoken();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:FutureBuilder<dynamic>(
        future: networkRequest.getProfile(),
    builder: (context, snapshot) {
    if (snapshot.hasData) {
      if(initData){
      context.read<providerUser>().updateName(snapshot.data['name']);
      context.read<providerUser>().updatMobile(snapshot.data['phone'].toString());
      context.read<providerUser>().updateGender(snapshot.data['gender'].toString());
      context.read<providerUser>().updateEmail(snapshot.data['email']);
      initData=false;

      getSWData(snapshot.data['countryId']);
      }


              return  Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white,  Color(0xffffffff).withOpacity(0.9)],
              tileMode: TileMode.clamp,
              begin: Alignment.topCenter,
              stops: [0.0, 1.0],
              end: Alignment.bottomCenter),
        ),
        child: Column(

         // shrinkWrap: true,
          children: [
            Column(
              children: [
                SizedBox(height: 16,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("Assets/Image-2.png")
                  ],
                )



              ],
            ),
            SizedBox(height: 8,),
            Container(
              height: MediaQuery.of(context).size.height< 743.4285714285714? MediaQuery.of(context).size.height*0.74: MediaQuery.of(context).size.height*0.742,

              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(), // new
                controller: _controller,
                shrinkWrap: true,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: MediaQuery.of(context).size.height*0.17,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                     // color: const Color(0xf2f5f5f5),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.95,
                              height: MediaQuery.of(context).size.height*0.128,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: const Color(0xf238056e),
                              ),

                            ),
                            Image.asset('Assets/Intersection.png'),
                            Container(
                              width: MediaQuery.of(context).size.width*0.9,
                              height: MediaQuery.of(context).size.height*0.128,
                              padding: EdgeInsets.all(16),
                              child: Row(
                                children: [

                                  snapshot.data['imageName']==""|| snapshot.data['imageName']==null?Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 68,
                                        height: 68,
                                        // margin: EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                          image: AssetImage("Assets/profileImage.png")),
                                          borderRadius: BorderRadius.circular(14.0),),)

                                    ],
                                  ):Container(
                                    width: 68,
                                    height: 68,
                                    // margin: EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(

                                      borderRadius: BorderRadius.circular(14.0),
                                      image: DecorationImage(
                                        image: NetworkImage(snapshot.data['imageName']),//MemoryImage(bytes),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    //  child: Image.memory(bytes),
                                  ),
                                //  Image.asset('Assets/man.png'),
                                  SizedBox(width: 12,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${snapshot.data['name']}", // "بيبو رمزي لويز",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color:Color(0xffffffff),
                                        ),
                                      ),
                                      SizedBox(height: 8,),
                                      Text(
                                        "${snapshot.data['phone']}",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color:Color(0xffffffff),
                                        ),
                                      )

                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        // Container(
                        //   padding: EdgeInsets.all(16),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Column(
                        //         children: [
                        //           Text(
                        //             'رصيد',
                        //             style: TextStyle(
                        //               fontSize: 13,
                        //               color: const Color(0xffc8c7cc),
                        //             ),
                        //             textAlign: TextAlign.right,
                        //           ),
                        //           SizedBox(height: 8,),
                        //           // Adobe XD layer: '0.2 km' (text)
                        //           Text(
                        //             '100 ر.س',
                        //             style: TextStyle(
                        //               fontSize: 15,
                        //               color: const Color(0xff242e42),
                        //               fontWeight: FontWeight.w700,
                        //             ),
                        //             textAlign: TextAlign.right,
                        //           )
                        //         ],
                        //       ),
                        //       Column(
                        //         children: [
                        //           Text(
                        //             'نقطة',
                        //             style: TextStyle(
                        //
                        //               fontSize: 13,
                        //               color: const Color(0xffc8c7cc),
                        //             ),
                        //             textAlign: TextAlign.right,
                        //           ),
                        //           // Adobe XD layer: '0.2 km' (text)
                        //           SizedBox(height: 8,),
                        //           Text(
                        //             "100",
                        //             style: TextStyle(
                        //
                        //               fontSize: 15,
                        //               color: const Color(0xff242e42),
                        //               fontWeight: FontWeight.w700,
                        //             ),
                        //             textAlign: TextAlign.right,
                        //           )
                        //         ],
                        //       ),
                        //       Column(
                        //         children: [
                        //
                        //           Text(
                        //             'طلب',
                        //             style: TextStyle(
                        //               fontFamily: 'DIN Next LT Arabic',
                        //               fontSize: 13,
                        //               color: const Color(0xffc8c7cc),
                        //             ),
                        //             textAlign: TextAlign.right,
                        //           ),
                        //           // Adobe XD layer: '0.2 km' (text)
                        //           SizedBox(height: 8,),
                        //           Text(
                        //             '0.0',
                        //             style: TextStyle(
                        //               fontFamily: 'DIN Next LT Arabic',
                        //               fontSize: 15,
                        //               color: const Color(0xff242e42),
                        //               fontWeight: FontWeight.w700,
                        //             ),
                        //             textAlign: TextAlign.right,
                        //           )
                        //         ],
                        //       )
                        //
                        //     ],
                        //   ),
                        // ),


                      ],
                    ),
                  ),
                 // SizedBox(height: 0,),
                  Box("الصفحة الشخصية",Image.asset('Assets/ProfilePage.png',color:  Color(0xff38056e),),snapshot.data),
                  SizedBox(height: 4,),
                  Box("حجوزاتي",Image.asset('Assets/Ticket.png',color:  Color(0xff38056e),),snapshot.data),
                  SizedBox(height: 4,),
                  Box("كوبونات خصم للمدراس",Image.asset('Assets/Ticket.png',color:  Color(0xff38056e),),snapshot.data),
                  SizedBox(height: 4,),
                  Box("المفضلة",Image.asset('Assets/Bookmark2.png',color:  Color(0xff38056e),),snapshot.data),
                  //  SizedBox(height: 4,),
                  // Box("العروض المرسلة",Image.asset('Assets/TicketStar.png',color:  Color(0xff38056e),),),
                  // SizedBox(height: 4,),
                  // Box("الجوائز",Image.asset('Assets/Document.png',color:  Color(0xff38056e),),),
                  SizedBox(height: 4,),
                  Box("الاعدادت",Image.asset('Assets/Setting.png',color:  Color(0xff38056e),),snapshot.data),
                  SizedBox(height: 4,),
                  Box("غيير موقعك",Icon(Icons.location_on,color:Color(0xff38056e) ,),snapshot.data),//Image.asset('Assets/Setting.png',color:  Color(0xff38056e),)
                  SizedBox(height: 4,),
                 Box("اتصل بنا عبر صفحتنا",Icon(Icons.call,color:  Color(0xff38056e),),snapshot.data),
                  SizedBox(height: 4,),
                  Box("عن التطبيق",Image.asset('Assets/Document.png',color:  Color(0xff38056e),),snapshot.data),
                  SizedBox(height: 4,),
                  Box("خروج",Image.asset('Assets/Login.png',color:  Color(0xff38056e),),snapshot.data),
                //  SizedBox(height: 4,),
                ],
              ),
            ),


          ],
        ),
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
      );}),

    );
  }
  var token;
  void gettoken()async{
    await HelperFunctions.getUserEmailSharedPreference().then((value){
      token  = value ;
    });
  }
  Widget Box(String text,Widget widget,data){
    return          GestureDetector(
      onTap:()=> {
        if(text=="الاعدادت"){
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new Settings())),
          }else if(text=="حجوزاتي"){
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new myReservations())),
        }
        else if(text=="خروج"){
          print('mm'),
    HelperFunctions.saveUserEmailSharedPreference(null),
          HelperFunctions.saveUserLoggedInSharedPreference(null),
    Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (_){
    return MyApp();
    }),(route)=> false
    ),
            translator.setNewLanguage(
              context,
            //  newLanguage:appState.selectedCategory==1? 'ar':'en',
              remember: true,

            ),


    }else if(text=="المفضلة"){
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new Favourites())),
          }else if(text=="كوبونات خصم للمدراس"){
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new myCouponDiscount())),
          }else if(text=="الصفحة الشخصية"){
            Navigator.push(context, new MaterialPageRoute(builder: (context)=>  editProfile(data['name'],data['email'],data['phone'],data['countryId'].toString(),data['gender']==1?"ذكر":"أنثى",data['birthDate'].toString().split("T")[0],data['phone'],edAdd,data))),
          }else if(text=="اتصل بنا عبر صفحتنا"){
        launch('http://mahzoooz.com/'),
          }else if(text =="عن التطبيق"){
            Navigator.push(context, new MaterialPageRoute(builder: (context)=>  aboutApp())),
          }else if(text =="غيير موقعك"){
        Navigator.push(context, new MaterialPageRoute(builder: (context)=>new maps()))

  },


      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffffffff),borderRadius: BorderRadius.circular(11.00),
        ),
        margin:EdgeInsets.all(2) ,
        child: Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(11.00),
          child: new Container(
            height: 59.00,

            width: MediaQuery.of(context).size.width*0.82,
            padding:EdgeInsets.symmetric(vertical: 8,horizontal: 12) ,
            decoration: BoxDecoration(
              color: Color(0xffffffff),borderRadius: BorderRadius.circular(11.00),
            ),
            child: Row(
              children: [

                widget,
                SizedBox(width: 16,),
                new Text(
                  translator.translate(text),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color:Color(0xff040303).withOpacity(0.9),
                  ),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios,color: Color(0xffD9D9D9),size: 18,)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
