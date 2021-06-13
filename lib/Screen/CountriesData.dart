import 'package:flutter/material.dart';
import 'package:mahzoooz/Models/category.dart';
import 'package:mahzoooz/Widget/ViewRestaurantDiscounts.dart';
import 'package:mahzoooz/Widget/ViewRestaurantDiscountsLoud.dart';
import 'package:mahzoooz/Widget/tabs.dart';
import 'package:mahzoooz/api/NetworkRequest.dart';
import 'package:mahzoooz/Widget/loading.dart';
import 'package:mahzoooz/services/appCategoris.dart';
import 'package:provider/provider.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'dart:typed_data';
import 'dart:convert' as convert;
class CountriesData extends StatefulWidget {
  var title;
  var id;
  var data;

  CountriesData(this.title,this.id,this.data);

  @override
  _CountriesDataState createState() => _CountriesDataState(title,id,data);
}

class _CountriesDataState extends State<CountriesData> {
  var title;var id;var data;
  NetworkRequest networkRequest=new NetworkRequest();
  _CountriesDataState(this.title,this.id,this.data);
  var categoriesData;
  var subcategoriesData;
  var subcategoriesDatabody;
  Uint8List bytesback;
  bool isEmpty;
  int count=1;
  @override
  void initState() {
    isEmpty=false;
    count=1;
    bytesback= convert.base64.decode(data['imageName'].split(',').last);
    final dataCategory = Category(
      categoryId: 0,
      name: "مطاعم غربية",
    );
    final dataCategory1 = Category(
      categoryId: 1,
      name: "مطاعم شرقية",
    );
    if(title=="مطاعم"){
      categoriesData = [
        dataCategory,dataCategory1
      ];

    }else{
      categoriesData = [

      ];
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
     //   resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios,color:Color(0xff38056e))),
          toolbarHeight: 65,
          elevation: 1,
          backgroundColor: Colors.white,
          title:new Text(
            title, //data['providerNameAr'] ==null? "مطاعم البيك السعودية":translator.currentLanguage == 'ar' ? data['providerNameAr']:data['providerNameEn'],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color:Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body:    RefreshIndicator(
            onRefresh: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (a, b, c) => CountriesData(title,id,data),
                  transitionDuration: Duration(seconds: 0),
                ),
              );
              return Future.value(false);
            },
            child: ChangeNotifierProvider<AppCategoris>(
            create: (_) => AppCategoris(),
            child: Consumer<AppCategoris>(
              builder: (context, appState, _) {

                return       FutureBuilder<dynamic>(
                    future:networkRequest.subCategoriesGetPaged(id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if(appState.show){
                          subcategoriesData=snapshot.data['categories'];
                          appState.updateshowData();
                          subcategoriesDatabody=snapshot.data;
                        }
                        //  print( snapshot.data['categories'].length);
                        return Container(
                          //  height: MediaQuery.of(context).size.height,
                          child: Column(
                            //shrinkWrap: true,
                              children: [
                                subcategoriesData.length!=0? Container(
                                  height: 42.0,
                                  width: MediaQuery.of(context).size.width ,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18.0),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.4),
                                    ),
                                  ),
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  child:Row(
                                    children: [
                                      SizedBox(width: 8,),
                                      InkWell(
                                        onTap: () {
                                          print("$isSelected");
                                          // print("$index");
                                          setState(() {
                                            isSelected=-1;
                                          });
                                          appState.updateCountEmpty(-1);
                                          appState.updateid(-1);
                                          appState.updateCount(-1);


                                        },
                                        child: Container(

                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: appState.count==-1 ?  Color(0xff38056e) : Colors.transparent,
                                            borderRadius: BorderRadius.circular(22.0),
                                          ),
                                          child: Center(
                                            child: Text(
                                              translator.translate( translator.currentLanguage == 'ar' ?"الكل":"All"),

                                              style: appState.count==-1
                                                  ? TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold)
                                                  : TextStyle(color: Colors.black45,fontSize: 14,fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount:subcategoriesData.length,
                                          physics: BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            double scale = 1.0;
                                            return InkWell(
                                              onTap: () {
                                                print("$isSelected");
                                                print("$index");
                                                setState(() {
                                                  isSelected=index;
                                                  isEmpty=false;
                                                });
                                                appState.updateCountEmpty(-1);
                                                appState.updateid(subcategoriesData[index]['id']);
                                                appState.updateCount(index);


                                              },
                                              child: Container(

                                                padding: EdgeInsets.all(12),
                                                decoration: BoxDecoration(
                                                  color: appState.count==index ?  Color(0xff38056e) : Colors.transparent,
                                                  borderRadius: BorderRadius.circular(22.0),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    translator.translate( translator.currentLanguage == 'ar' ?subcategoriesData[index]['nameAr']:subcategoriesData[index]['nameEn']),

                                                    style: appState.count==index
                                                        ? TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold)
                                                        : TextStyle(color: Colors.black45,fontSize: 12,fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            );})
                                    ],
                                  ) , //dayBox(selectDay==index, timing));}),
                                ):Container(),
                                snapshot.data['data'].length==0?Expanded(
                                  child: Container(

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
                                                child: Image.asset("Assets/sad.png") ,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 45,),
                                          new Text(
                                            "شويات وراجعين بخصومتنا", //data['providerNameAr'] ==null? "مطاعم البيك السعودية":translator.currentLanguage == 'ar' ? data['providerNameAr']:data['providerNameEn'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(

                                              fontWeight: FontWeight.w800,
                                              fontSize: 16,
                                              color:Color(0xff91B958),
                                            ),
                                          ),
                                          // new Text(
                                          //   "لايوجد عروض متوفرة", //data['providerNameAr'] ==null? "مطاعم البيك السعودية":translator.currentLanguage == 'ar' ? data['providerNameAr']:data['providerNameEn'],
                                          //   textAlign: TextAlign.center,
                                          //   style: TextStyle(
                                          //
                                          //     fontWeight: FontWeight.w700,
                                          //     fontSize: 16,
                                          //     color:Color(0xff029789),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ): appState.count!=-1? Container(
                                  margin: EdgeInsets.symmetric(vertical: 16),
                                  // height: MediaQuery.of(context).size.height*0.8195,
                                  child: Stack(
                                    children: [
                                      // Positioned(
                                      //   child:   MyTabs(),
                                      // ),
                                      // Text("gg"),
                                      Container(
                                        // decoration: BoxDecoration(
                                        //   color: Colors.white,
                                        //
                                        //   boxShadow: [BoxShadow(
                                        //       color: Colors.black45,
                                        //       blurRadius: 1,
                                        //       offset: Offset(2, 1)
                                        //   )],
                                        //   borderRadius: BorderRadius.circular(2.0),),
                                        child:Container(
                                          height: MediaQuery.of(context).size.height*0.772,
                                          // height: MediaQuery.of(context).size.height*0.89,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:appState.CountEmpty==-1?1:subcategoriesDatabody['data'].length,
                                              physics: BouncingScrollPhysics(),
                                              itemBuilder: (context, index) {


                                                  for(int i=0;i<snapshot.data.length;i++){
                                                    print("ppppppp");
                                                    if(subcategoriesDatabody['data'][i]['categoryId']==appState.id){
                                                      appState.updateCountEmpty(1);
                                                      print("jjjjjj");
                                                   


                                                      print(count);
                                                    }
                                                  }

                                                // categoriesData.add(new Category(
                                                //   categoryId: index,
                                                //   name: snapshot.data[index]['nameAr'],
                                                // ));
                                                // appState.updateCategory(index,snapshot.data[index]['nameAr']);
                                                print(appState.categoriesData);
                                                // AppCategoris.updateCategory(index,snapshot.data[index]['nameAr']);
                                                return appState.CountEmpty==-1? Expanded(
                                                  child: Container(
                                                 height: MediaQuery.of(context).size.height*0.6,
                                                    child: Column(
                                                      crossAxisAlignment:CrossAxisAlignment.center ,
                                                      mainAxisAlignment:MainAxisAlignment.center ,
                                                      children: [
                                                      // Container(
                                                      // height: 50.0,),
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
                                                              child: Image.asset("Assets/sad.png") ,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 45,),
                                                        new Text(
                                                          "شويات وراجعين بخصومتنا", //data['providerNameAr'] ==null? "مطاعم البيك السعودية":translator.currentLanguage == 'ar' ? data['providerNameAr']:data['providerNameEn'],
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(

                                                            fontWeight: FontWeight.w800,
                                                            fontSize: 16,
                                                            color:Color(0xff91B958),
                                                          ),
                                                        ),
                                                        // new Text(
                                                        //   "لايوجد عروض متوفرة", //data['providerNameAr'] ==null? "مطاعم البيك السعودية":translator.currentLanguage == 'ar' ? data['providerNameAr']:data['providerNameEn'],
                                                        //   textAlign: TextAlign.center,
                                                        //   style: TextStyle(
                                                        //
                                                        //     fontWeight: FontWeight.w700,
                                                        //     fontSize: 16,
                                                        //     color:Color(0xff029789),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ): snapshot.data['data'][index]['categoryId']==appState.id?ViewRestaurantDiscounts(snapshot.data['data'][index]):Container(height: 0,)   ;    }),
                                        ),
                                      ),

                                      // title=="مطاعم"? Container(
                                      //     color:Colors.white,
                                      //     child: MyTabs(categoriesData)):Container()
                                    ],
                                  ),
                                ): Container(
                                  margin: EdgeInsets.symmetric(vertical: 16),
                                  // height: MediaQuery.of(context).size.height*0.8195,
                                  child: Stack(
                                    children: [
                                      // Positioned(
                                      //   child:   MyTabs(),
                                      // ),
                                      // Text("gg"),
                                      Container(
                                        // decoration: BoxDecoration(
                                        //   color: Colors.white,
                                        //
                                        //   boxShadow: [BoxShadow(
                                        //       color: Colors.black45,
                                        //       blurRadius: 1,
                                        //       offset: Offset(2, 1)
                                        //   )],
                                        //   borderRadius: BorderRadius.circular(2.0),),
                                        child:ListView(
                                          shrinkWrap: true,
                                          // controller: scrolController,
                                          // controller: controller,
                                          children: [
                                            //   MediaQuery.of(context).size.height< 743.4285714285714?  SizedBox(height: 5,):SizedBox(height: ,),
                                            Container(
                                               height: MediaQuery.of(context).size.height*0.772,
                                              child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount:subcategoriesDatabody['data'].length,
                                                  physics: BouncingScrollPhysics(),
                                                  itemBuilder: (context, index) {
                                                    // categoriesData.add(new Category(
                                                    //   categoryId: index,
                                                    //   name: snapshot.data[index]['nameAr'],
                                                    // ));
                                                    // appState.updateCategory(index,snapshot.data[index]['nameAr']);
                                                    print(appState.categoriesData);
                                                    // AppCategoris.updateCategory(index,snapshot.data[index]['nameAr']);
                                                    return ViewRestaurantDiscounts(snapshot.data['data'][index]);
                                                  }),
                                            )
                                          ],
                                        ),
                                      ),

                                      // title=="مطاعم"? Container(
                                      //     color:Colors.white,
                                      //     child: MyTabs(categoriesData)):Container()
                                    ],
                                  ),
                                ),


                              ]),
                        );
                      }
                      else if (snapshot.hasError) {
                        return Center(child: Text("تأكد من إتصال بالإنرنت"));
                      }
                      // By default, show a loading spinner.
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 30,),

                          Loading(),
                          // Center(
                          //   child: PixLoader(
                          //       loaderType: LoaderType.Spinner, faceColor: Color(0xfff99b1d)),
                          // )
                          //CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xfff99b1d) ),)
                        ],
                      );});},
            ),
          ),
        ));
  }
  int isSelected ;
//  Widget item(index,data){
// return InkWell(
//   onTap: () {
//     print("$isSelected");
//     print("$index");
//     setState(() {
//       isSelected==index;
//     });
//
//
//       appState.updateCategory(category.categoryId);
//
//   },
//   child: Container(
//
//     padding: EdgeInsets.all(12),
//     decoration: BoxDecoration(
//       color: isSelected==index ?  Color(0xff38056e) : Colors.transparent,
//       borderRadius: BorderRadius.circular(22.0),
//     ),
//     child: Center(
//       child: Text(
//         translator.translate( translator.currentLanguage == 'ar' ?data[index]['nameAr']:data[index]['nameEn']),
//
//         style: isSelected==index
//             ? TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold)
//             : TextStyle(color: Colors.black45,fontSize: 12,fontWeight: FontWeight.bold),
//       ),
//     ),
//   ),
// );
//  }
}
