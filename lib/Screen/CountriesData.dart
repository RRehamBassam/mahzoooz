import 'package:flutter/material.dart';
import 'package:mahzoooz/Models/category.dart';
import 'package:mahzoooz/Widget/ViewRestaurantDiscountsCategories.dart';
import 'package:mahzoooz/Widget/ViewRestaurantDiscountsLoud.dart';
import 'package:mahzoooz/Widget/tabs.dart';
import 'package:mahzoooz/api/NetworkRequest.dart';
class CountriesData extends StatefulWidget {
  var title;

  CountriesData(this.title);

  @override
  _CountriesDataState createState() => _CountriesDataState(title);
}

class _CountriesDataState extends State<CountriesData> {
  var title;
  NetworkRequest networkRequest=new NetworkRequest();
  _CountriesDataState(this.title);
 var categoriesData;
@override
  void initState() {
  final dataCategory = Category(
    categoryId: 0,
    name: title,
  );
  final dataCategory1 = Category(
    categoryId: 1,
    name: title,
  );
  final dataCategory2 = Category(
    categoryId: 2,
    name: title,
  );  categoriesData = [
    dataCategory,
    dataCategory1,
    dataCategory2,
  ];

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
     resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        body:Column(
        //shrinkWrap: true,
        children: [
        Container(
        height: MediaQuery.of(context).size.height*0.14,
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 48,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                     fontWeight: FontWeight.w500,
                      fontSize: 22,
                      color: const Color(0xff333333),
                      height: 1.8181818181818181,
                    ),
                    textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
            ],
          ),
          Positioned(
            left: 40,
            top: 48,
            child: Row(
              children: [
                Image.asset("Assets/Notification.png",color:Color(0xfe38056e)),
                SizedBox(width: 8,),
                Image.asset("Assets/gift (1).png",color:Color(0xfe38056e)),


              ],
            ),
          )
        ],
      ),
    ),
          Expanded(
            child: Stack(
              children: [
                // Positioned(
                //   child:   MyTabs(),
                // ),
                Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,

                        boxShadow: [BoxShadow(
                            color: Colors.black45,
                            blurRadius: 1,
                            offset: Offset(2, 1)
                        )],
                        borderRadius: BorderRadius.circular(2.0),),
                      child:ListView(
                       // controller: scrolController,
                        // controller: controller,
                        children: [
                          MediaQuery.of(context).size.height< 743.4285714285714?  SizedBox(height: 45,):SizedBox(height: 45,),
                          FutureBuilder<dynamic>(
                              future: networkRequest.OffersGetPaged(true),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  print(snapshot.data.length);
                                  return
                                    Expanded(
                                      child:  Container(
                                        height: MediaQuery.of(context).size.height,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:snapshot.data.length,
                                            physics: BouncingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return ViewRestaurantDiscountsCategories(snapshot.data[index]);
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
                                    ViewRestaurantDiscountsLoud(),
                                    ViewRestaurantDiscountsLoud()
                                    // Loading(),
                                    // Center(
                                    //   child: PixLoader(
                                    //       loaderType: LoaderType.Spinner, faceColor: Color(0xfff99b1d)),
                                    // )
                                    //CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xfff99b1d) ),)
                                  ],
                                );}),
                        ],
                      ),
                    )),
                Container(
                    color:Colors.white,
                    child: MyTabs(categoriesData))
              ],
            ),
          )

        ]),
    );
  }
}
