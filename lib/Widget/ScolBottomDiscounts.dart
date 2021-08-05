import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:mahzoooz/Models/category.dart';
import 'package:mahzoooz/Widget/PratScrolDiscount.dart';
import 'package:mahzoooz/Widget/ViewRestaurantDiscounts.dart';
import 'package:mahzoooz/Widget/catgeory_widget.dart';
import 'package:mahzoooz/Widget/tabs.dart';
import 'package:mahzoooz/api/NetworkRequest.dart';
import 'package:mahzoooz/Widget/Categories.dart';
import 'package:mahzoooz/services/app_state.dart';
import 'package:provider/provider.dart';
import 'ViewRestaurantDiscountsLoud.dart';
import 'loading.dart';
class ScolBottomDiscounts extends StatefulWidget {
  var latLnglocation;

  ScolBottomDiscounts(this.latLnglocation);

  @override
  _ScolBottomDiscountsState createState() => _ScolBottomDiscountsState(latLnglocation);
}

class _ScolBottomDiscountsState extends State<ScolBottomDiscounts> {
  var latLnglocation;

  _ScolBottomDiscountsState(this.latLnglocation);

  NetworkRequest networkRequest=new NetworkRequest();
  int isSelected;
  var ListData;
  bool loud;
  @override
  void initState() {
    loud=false;
    isSelected=0;
    ListData=[];
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(

        child: ChangeNotifierProvider<AppState>(
            create: (_) => AppState(),
          child: Consumer<AppState>(
    builder: (context, appState, _) => DraggableScrollableSheet(
        maxChildSize:MediaQuery.of(context).size.height< 743.4285714285714? 0.999: 0.999,
        minChildSize:MediaQuery.of(context).size.height< 663.4285714285714?0.42: MediaQuery.of(context).size.height< 743.4285714285714? 0.48:0.57,
        initialChildSize:MediaQuery.of(context).size.height< 663.4285714285714?0.42: MediaQuery.of(context).size.height< 743.4285714285714?0.48:0.57 ,
        builder: (BuildContext context, ScrollController scrolController){
          if(appState.count==0)
            appState.updateColId("IsBestOffer");
          else if(appState.count==1)
            appState.updateColId("1");
          else if(appState.count==2)
            appState.updateColId("CreatedDate");
          else if(appState.count==3)
            appState.updateColId("AverageRate");
          return Stack(
            children: [
              // Positioned(
              //   child:   MyTabs(),
              // ),
              Container(

                decoration: BoxDecoration(
                  color: Colors.white,

                  // boxShadow: [BoxShadow(
                  //     color: Colors.black45,
                  //     blurRadius: 1,
                  //     offset: Offset(2, 1)
                  // )],
                  borderRadius: BorderRadius.circular(2.0),),
                child:ListView(
                  shrinkWrap: true,
                  controller: scrolController,
                  // controller: controller,
                  children: [
                    MediaQuery.of(context).size.height< 743.4285714285714?  SizedBox(height: 72,):SizedBox(height: 72,),
                    Container(color: Colors.white,
                      child: Column(
                        children: [
                        //  Container(child:Text("${appState.count}")),
                          loud?Container(
                      height:MediaQuery.of(context).size.height*0.5,
                              child: Loading()):  FutureBuilder<dynamic>(


                            // appState.updateColId("AverageRate");
                              future: networkRequest.OffersGetPaged(false,"",latLnglocation.latitude,latLnglocation.longitude,appState.colId),//:networkRequest.OffersGetPaged(false,"",latLnglocation.latitude,latLnglocation.longitude,"CreatedDate"),
                              builder: (context, snapshot) {
                                ListData=[];

                                //await Future<void>.delayed(Duration(seconds: 5));
                                if (snapshot.hasData ||ListData==[]) {
                                  ListData=snapshot.data;
                                //  print('kk');
                                  print(isSelected);
                                  return
                                    Container(
                                      margin: EdgeInsets.only(top: 16),
                                      //  height: MediaQuery.of(context).size.height,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:snapshot.data.length,
                                          physics: BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return  Column(
                                              children: [
                                              //  Container(child:Text("${appState.colId}")),
                                                ViewRestaurantDiscounts(snapshot.data[index])
                                              ],
                                            );//;
                                          }),
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
                                    ViewRestaurantDiscountsLoud(),
                                    ViewRestaurantDiscountsLoud()
                                    // Loading(),
                                    // Center(
                                    //   child: PixLoader(
                                    //       loaderType: LoaderType.Spinner, faceColor: Color(0xfff99b1d)),
                                    // )
                                    //CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xfff99b1d) ),)
                                  ],
                                );})
                        ],
                      ),
                    )

                    //,

                  ],
                ),
              ),
              Container(
                  color:Colors.white,
                  child:Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),

                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          height: 42.0,
                        //  width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height< 740.4285714285714?5:12),
                         // width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ),
                          child: ListView.builder(
                          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount:categories.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
          double scale = 1.0;
          return InkWell(
          onTap: () async {


          setState(() {
          isSelected=index;
          ListData=[];
          });

          appState.updateCount(index);
            print(appState.count);
          await getData();
          },
          child: Container(

          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
          color: appState.count==index ?  Color(0xff38056e) : Colors.transparent,
          borderRadius: BorderRadius.circular(22.0),
          ),
          child: Center(
          child: Text(translator.translate(categories[index].name),
          //translator.translate( translator.currentLanguage == 'ar' ?subcategoriesData[index]['nameAr']:subcategoriesData[index]['nameEn']),

          style: appState.count==index
          ? TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold)
              : TextStyle(color: Colors.black45,fontSize: 14,fontWeight: FontWeight.bold),
          ),
          ),
          ),
          );}),
                        ),
                      ),

                  )// MyTabs(categories)


              )
            ],
          );}
    ) ),),

    );
  }
  Future<String> getData() async {
    setState(() {
      loud=true;
    });


    await Future<void>.delayed(Duration(seconds: 1));
    setState(() {
      loud=false;
    });
  }
}
