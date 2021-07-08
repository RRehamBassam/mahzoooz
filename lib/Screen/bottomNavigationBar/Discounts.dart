import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mahzoooz/Models/category.dart';
import 'package:mahzoooz/Widget/ScolBottomDiscounts.dart';
import 'package:mahzoooz/Widget/ViewRestaurantDiscounts.dart';
import 'package:mahzoooz/Widget/ViewRestaurantDiscountsLoud.dart';
import 'package:mahzoooz/Widget/loading.dart';
import 'package:mahzoooz/Widget/tabs.dart';
import 'package:mahzoooz/Widget/AppBarTop.dart';
import 'package:mahzoooz/Widget/Search.dart';
import 'package:mahzoooz/Widget/ItemCarouselSlider.dart';
import 'package:mahzoooz/Widget/Categories.dart';
import 'package:mahzoooz/Widget/CategoriesLoud.dart';
import 'package:mahzoooz/Widget/ItemCarouselSliderLoud.dart';
import 'package:mahzoooz/api/NetworkRequest.dart';
class Discounts extends StatefulWidget {
  LatLng latLnglocation;

  Discounts(this.latLnglocation);

  @override
  _DiscountsState createState() => _DiscountsState(latLnglocation);
}

class _DiscountsState extends State<Discounts> {
  LatLng latLnglocation;

  _DiscountsState(this.latLnglocation);

  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  NetworkRequest networkRequest=new NetworkRequest();
  @override
  void initState() {
    super.initState();

    controller.addListener(() {

      double value = controller.offset/119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor( Color(0xff38056e));

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
       // resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        body:Column(
          //shrinkWrap: true,
          children: [
           // AppBarTop(),
            Search(),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 8,
                    child: Container(
                      width: 400,
                      height: 600,
                    child:   AnimatedOpacity(
                        duration: const Duration(milliseconds: 800),
                        opacity: closeTopContainer?0:1,
                        child: AnimatedContainer(
                            duration: const Duration(milliseconds: 800),
                            alignment: Alignment.topCenter,
                            height: closeTopContainer?0:MediaQuery.of(context).size.height*0.48,
                            child: ListView(
                              shrinkWrap: true,
                              children: <Widget>[
                                //  SizedBox(height: 15.0),
                              FutureBuilder<dynamic>(
                                future: networkRequest.OffersGetPaged(true,"",latLnglocation.latitude,latLnglocation.longitude,"CreatedDate"),
                                builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                 return  CarouselSlider(
                                  options: CarouselOptions(
                                    enableInfiniteScroll: true,
                                    autoPlayAnimationDuration: Duration(milliseconds: 1000),
                                    viewportFraction: 0.8,
                                    height: 140.0, autoPlayCurve: Curves.fastOutSlowIn,
                                    autoPlay: true,
                                    aspectRatio:  10 / 9,
                                    enlargeCenterPage: true,
                                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                                  ),

                                  items: [
                                  ...snapshot.data.map((name) {
                                    return   ItemCarouselSlider(name);
                                  },
                                    // ItemCarouselSlider([]),
                                    // ItemCarouselSlider(),
                                    // ItemCarouselSlider(),
                                    // ItemCarouselSlider(),
                                    // ItemCarouselSlider(),
                                  )]) ;}
                                          else if (snapshot.hasError) {
                                          return Center(child: Text("تأكد من إتصال بالإنرنت"));
                                          }
                                          // By default, show a loading spinner.
                                          return Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                         // SizedBox(height: 30,),
                                            CarouselSlider(
                                                options: CarouselOptions(
                                                  enableInfiniteScroll: true,
                                                  autoPlayAnimationDuration: Duration(milliseconds: 1000),
                                                  viewportFraction: 0.8,
                                                  height: 140.0, autoPlayCurve: Curves.fastOutSlowIn,
                                                  autoPlay: true,
                                                  aspectRatio:  10 / 9,
                                                  enlargeCenterPage: true,
                                                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                                                ),

                                                items: [
                                                  ItemCarouselSliderLoud(),
                                                  ItemCarouselSliderLoud(),
                                                  ItemCarouselSliderLoud(),
                                                ]),

                                          //Loading(),
                                          // Center(
                                          //   child: PixLoader(
                                          //       loaderType: LoaderType.Spinner, faceColor: Color(0xfff99b1d)),
                                          // )
                                          //CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xfff99b1d) ),)
                                          ],
                                          );}),
                                Container(
                                  height: 132,
                                  margin: EdgeInsets.only(right: 10),
                                  child: ListView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                                        FutureBuilder<dynamic>(
                                                        future: networkRequest.CategoriesGetPaged(latLnglocation.latitude,latLnglocation.longitude),
                                                        builder: (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                        return  Container(
                                                          margin: EdgeInsets.only(right: MediaQuery.of(context).size.height< 740.4285714285714?5:12),
                                                          width:    MediaQuery.of(context).size.width,
                                                          child: ListView.builder(
                                                          shrinkWrap: true,
                                                              scrollDirection: Axis.horizontal,
                                                          itemCount:snapshot.data.length,
                                                          physics: BouncingScrollPhysics(),
                                                          itemBuilder: (context, index) {
                                                          double scale = 1.0;
                                                          return Categories(snapshot.data[index],false);}),
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
                                                            CategoriesLoud(snapshot.data,true),
                                                            CategoriesLoud(snapshot.data,true),
                                                            CategoriesLoud(snapshot.data,true),
                                                          //  CategoriesLoud(snapshot.data,true),
                                                          //  Loading(),
                                                            // Center(
                                                            //   child: PixLoader(
                                                            //       loaderType: LoaderType.Spinner, faceColor: Color(0xfff99b1d)),
                                                            // )
                                                            //CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xfff99b1d) ),)
                                                          ],
                                                        );}),
                                      // Stack(
                                      //   children: [
                                      //     Container(
                                      //       width: 95,
                                      //       height: 200,
                                      //       margin: EdgeInsets.all(5.0),
                                      //       decoration: BoxDecoration(
                                      //         borderRadius: BorderRadius.circular(10.0),
                                      //         image: DecorationImage(
                                      //           image: AssetImage('Assets/Rectangle2.png'),
                                      //           fit: BoxFit.cover,
                                      //         ),
                                      //       ),),
                                      //     Positioned(
                                      //       top: 0,
                                      //       left: 0,
                                      //       bottom: 0,
                                      //       right: 0,
                                      //       child: Container(
                                      //         width: 95,
                                      //         height: 200,
                                      //         margin: EdgeInsets.all(5.0),
                                      //         decoration: BoxDecoration(
                                      //           color: Colors.black.withOpacity(0.3),
                                      //           borderRadius: BorderRadius.circular(10.0),
                                      //
                                      //         ),),
                                      //     ),
                                      //     Positioned(
                                      //       bottom: 25,
                                      //       right: 8,
                                      //       child:  Text(
                                      //         "مأكولات\n ومشربات",
                                      //         textAlign: TextAlign.center,
                                      //         style: TextStyle(
                                      //           fontWeight: FontWeight.bold,
                                      //           fontSize: 15,
                                      //           color:Color(0xffffffff),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),






                                    ],
                                  ),
                                )
                              ],


                            ))),
                    ),
                  ),
                  ScolBottomDiscounts(latLnglocation),

                ],
              ),
            ),


         //   SizedBox(height: 100,)
          ],
        )
      ),
    );
  }
}
