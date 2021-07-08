import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:mahzoooz/Widget/ViewRestaurantDiscounts.dart';
import 'package:mahzoooz/Widget/loading.dart';
import 'package:mahzoooz/api/NetworkRequest.dart';
import 'package:mahzoooz/services/helperFunctions.dart';
import 'package:mahzoooz/services/appCategoris.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';
class SearchScreen extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<SearchScreen> {
  var searchText;
  var data;
  StreamController _postsController;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  NetworkRequest networkRequest=new NetworkRequest();
  var _controller = TextEditingController();
  @override
  void initState() {
    _postsController = new StreamController();
    searchText="";
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body:  ChangeNotifierProvider<AppCategoris>(
        create: (_) => AppCategoris(),
        child: Consumer<AppCategoris>(
          builder: (context, appState, _) {

            return Column(
        children: [
          SizedBox(height: 25,),
          Container(
            decoration: BoxDecoration(
              color:Color(0xfe38056e),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap:(){
                      Navigator.pop(context);
            },
                    child: Container(
                        margin: EdgeInsets.only(right: 14,top: 10,bottom: 10),
                        child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 14,bottom: 14,left: 8),
                    width: MediaQuery.of(context).size.width*0.855,
                    height: MediaQuery.of(context).size.height*0.045,
                    child: TextFormField(
                      onChanged: (val) {
                        appState.updateSearch(val);
                        setState(() {
                          searchText = val;
                        });
                      },
                      controller: _controller,
                      cursorColor: Color(0xff38056e),
                      keyboardType:TextInputType.text,
                      autofocus: false,
                      textAlign: TextAlign.right,//(val)=>setState(()=>Name=val)

                      obscureText: false,
                      decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: (){
                              setState(() {
                                _controller.clear();
                              });

                            },
                              child: Icon(Icons.clear, size: 18,)),
                          prefixIcon: InkWell(
                              onTap: (){
                                appState.updateSearch(searchText);
                              },
                              child: Icon(Icons.search,size: 18,)),
                          contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(width: 1,color: Colors.grey[300]),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(width: 1,color:Color(0xff38056e))
                          ),
                          filled: true,
                          fillColor:Colors.white,// Color(0xFFF8F8F8).withOpacity(0.7),
                          // prefixIcon:tajerAccount?Image.asset("Assets/icon-store.png",color:Color(0xfff99b1d),):Image.asset("Assets/icon-account.png") ,

                          hintText:translator.translate("Search"),

                          // icon:tajerAccount?Image.asset("Assets/icon-store.png",color:Color(0xfff99b1d),):Image.asset("Assets/icon-account.png") ,
                          hintStyle:TextStyle(
                            fontSize: 13,
                            color:Color(0xffc0c0c0),
                          ),
                          labelStyle: null
                      ),

                    ),
                  ),

                  // Row(
                  //   children: [
                  //     Container(
                  //         margin: EdgeInsets.only(top: 20),
                  //         height: 32.00,
                  //         width: 32.00,
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,borderRadius: BorderRadius.circular(25.00),
                  //         ),child: Image.asset("Assets/Notification.png",color:Color(0xfe38056e),scale: 1.2,)),
                  //     SizedBox(width: 8,),
                  //     Container(
                  //         margin: EdgeInsets.only(top: 20),
                  //         height: 32.00,
                  //         width: 32.00,
                  //         decoration: BoxDecoration(
                  //           color:Colors.white,borderRadius: BorderRadius.circular(25.00),
                  //         ),child: Image.asset("Assets/gift (1).png",color:Color(0xfe38056e),scale: 1.2,)),
                  //
                  //
                  //   ],
                  // )
                ],
              ),
            ),
          ),
          appState.Search=="1" ?Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width*0.8,
            //  height: MediaQuery.of(context).size.height*0.65,
              child: Center(
                child:Container(
                  margin: EdgeInsets.only(top: 16),
                  height: MediaQuery.of(context).size.height*0.6,
                  child: Center(
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.center ,
                      mainAxisAlignment:MainAxisAlignment.center ,
                      children: [
                        // SizedBox(height: 22,),
                        Container(
                          width: 260.0,
                          height: 260.0,
                          padding:EdgeInsets.all(45),
                          decoration: new BoxDecoration(
                            color:Color(0xffF3FDE5), // Color(0xffF0FAF9),C5E697
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            width: 120.0,
                            height: 120.0,

                            padding:EdgeInsets.all(50),
                            decoration: new BoxDecoration(
                              color: Color(0xffC5E696),// Color(0xffCEEAE7),
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: new BoxDecoration(
                                color:Color(0xff91B958),//Color(0xff029789),
                                shape: BoxShape.circle,
                              ),
                              child:  Icon(Icons.search,size: 46,color: Colors.white,),
                            ),
                          ),
                        ),
                        SizedBox(height: 62,),

                        new Text(
                          translator.translate("ياترى بتبحث عن ايه؟!"), //data['providerNameAr'] ==null? "مطاعم البيك السعودية":translator.currentLanguage == 'ar' ? data['providerNameAr']:data['providerNameEn'],
                          textAlign: TextAlign.center,
                          style: TextStyle(

                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            color:Color(0xff91B958),
                          ),
                        ),
                        SizedBox(height: 13,),
                        new Text(
                          translator.translate("اكتب جزء من اسم المكان"), //data['providerNameAr'] ==null? "مطاعم البيك السعودية":translator.currentLanguage == 'ar' ? data['providerNameAr']:data['providerNameEn'],
                          textAlign: TextAlign.center,
                          style: TextStyle(

                            fontWeight: FontWeight.w800,
                            fontSize: 11,
                            color:Color(0xffC5E696),
                          ),
                        ),
                        SizedBox(height: 88,),
                        // InkWell(
                        //   onTap: (){
                        //     Navigator.push(context, new MaterialPageRoute(builder: (context)=>new maps()));
                        //   },
                        //   child:    new Text(
                        //     "تغيير الموقع الحالى", //data['providerNameAr'] ==null? "مطاعم البيك السعودية":translator.currentLanguage == 'ar' ? data['providerNameAr']:data['providerNameEn'],
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(
                        //
                        //       fontWeight: FontWeight.w600,
                        //       fontSize: 14,
                        //       color:Colors.black,
                        //     ),
                        //   ),
                        // )

                      ],
                    ),
                  ),
                ),//  Column(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Icon(Icons.search,size: 82,),
                //     SizedBox(height: 22,),
                //     Text(
                //       "هتبحث على ايه؟!", //data['providerNameAr'] ==null? "مطاعم البيك السعودية":translator.currentLanguage == 'ar' ? data['providerNameAr']:data['providerNameEn'],
                //       textAlign: TextAlign.center,
                //       style: TextStyle(
                //
                //         fontWeight: FontWeight.w700,
                //         fontSize: 16,
                //         color:Colors.black,
                //       ),
                //     )
                //   ],
                // ),
              ),
            ),
          ):FutureBuilder<dynamic>(
              future: networkRequest.OffersGetPagedS(false,appState.Search),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data.length);
                  return
                    snapshot.data.length==0?Expanded(child:Container(

                      child: Center(
                        child: Column(
                          crossAxisAlignment:CrossAxisAlignment.center ,
                          mainAxisAlignment:MainAxisAlignment.center ,
                          children: [

                            Container(
                              width: 260.0,
                              height: 260.0,
                              padding:EdgeInsets.all(45),
                              decoration: new BoxDecoration(
                                color:  Color(0xffF0FAF9),
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                width: 120.0,
                                height: 120.0,

                                padding:EdgeInsets.all(50),
                                decoration: new BoxDecoration(
                                  color: Color(0xffCEEAE7),
                                  shape: BoxShape.circle,
                                ),
                                child: Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: new BoxDecoration(
                                    color:Color(0xff029789),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.receipt, color: Colors.white,),
                                ),
                              ),
                            ),
                            SizedBox(height: 25,),
                            new Text(
                              "لايوجد نتائج للبحث", //data['providerNameAr'] ==null? "مطاعم البيك السعودية":translator.currentLanguage == 'ar' ? data['providerNameAr']:data['providerNameEn'],
                              textAlign: TextAlign.center,
                              style: TextStyle(

                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color:Color(0xff029789),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )):Container(
                  //    height: MediaQuery.of(context).size.height,
                      child: Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:snapshot.data.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ViewRestaurantDiscounts(snapshot.data[index]);
                            }),
                      ),
                    ); }
                else if (snapshot.hasError) {
                  return Center(child: Text("تأكد من إتصال بالإنرنت"));
                }
                // By default, show a loading spinner.
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30,),
                    // ViewRestaurantDiscountsLoud(),
                    // ViewRestaurantDiscountsLoud()
                     Loading(),
                    // Center(
                    //   child: PixLoader(
                    //       loaderType: LoaderType.Spinner, faceColor: Color(0xfff99b1d)),
                    // )
                    //CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xfff99b1d) ),)
                  ],
                );})

        ],
      )
      ;},
    ),
        ) );
  }
}
