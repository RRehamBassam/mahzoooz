import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mahzoooz/Widget/ViewRestaurantDiscounts.dart';
import 'package:mahzoooz/Widget/tabs.dart';
import 'package:mahzoooz/Widget/AppBarTop.dart';
import 'package:mahzoooz/Widget/Search.dart';
import 'package:mahzoooz/Widget/ItemCarouselSlider.dart';
class Discounts extends StatefulWidget {
  @override
  _DiscountsState createState() => _DiscountsState();
}

class _DiscountsState extends State<Discounts> {
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        body:Column(
          //shrinkWrap: true,
          children: [
            AppBarTop(),
            Search(),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 400,
                    height: 600,
                  child:   AnimatedOpacity(
                      duration: const Duration(milliseconds: 800),
                      opacity: closeTopContainer?0:1,
                      child: AnimatedContainer(
                          duration: const Duration(milliseconds: 800),
                          alignment: Alignment.topCenter,
                          height: closeTopContainer?0:MediaQuery.of(context).size.height*0.48,
                          child: ListView(children: [
                            ListView(
                              shrinkWrap: true,
                              children: <Widget>[
                                //  SizedBox(height: 15.0),
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
                                    ItemCarouselSlider(),
                                    ItemCarouselSlider(),
                                    ItemCarouselSlider(),
                                    ItemCarouselSlider(),
                                    ItemCarouselSlider(),
                                  ],),
                                Container(
                                  height: 140,
                                  child: ListView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            width: 95,
                                            height: 200,
                                            margin: EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              image: DecorationImage(
                                                image: AssetImage('Assets/Rectangle2.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),),
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              width: 95,
                                              height: 200,
                                              margin: EdgeInsets.all(5.0),
                                              decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(0.3),
                                                borderRadius: BorderRadius.circular(10.0),

                                              ),),
                                          ),
                                  Positioned(
                                    bottom: 30,
                                    right: 10,
                                    child:  Text(
                                      "محلات وخدمات",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        color:Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            width: 95,
                                            height: 200,
                                            margin: EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              image: DecorationImage(
                                                image: AssetImage('Assets/Rectangle2.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),),
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              width: 95,
                                              height: 200,
                                              margin: EdgeInsets.all(5.0),
                                              decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(0.3),
                                                borderRadius: BorderRadius.circular(10.0),

                                              ),),
                                          ),
                                          Positioned(
                                            bottom: 30,
                                            right: 10,
                                            child:  Text(
                                              "محلات وخدمات",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                                color:Color(0xffffffff),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            width: 95,
                                            height: 200,
                                            margin: EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              image: DecorationImage(
                                                image: AssetImage('Assets/Rectangle2.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),),
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              width: 95,
                                              height: 200,
                                              margin: EdgeInsets.all(5.0),
                                              decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(0.3),
                                                borderRadius: BorderRadius.circular(10.0),

                                              ),),
                                          ),
                                          Positioned(
                                            bottom: 30,
                                            right: 10,
                                            child:  Text(
                                              "محلات وخدمات",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                                color:Color(0xffffffff),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            width: 95,
                                            height: 200,
                                            margin: EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              image: DecorationImage(
                                                image: AssetImage('Assets/Rectangle2.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),),
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              width: 95,
                                              height: 200,
                                              margin: EdgeInsets.all(5.0),
                                              decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(0.5),
                                                borderRadius: BorderRadius.circular(10.0),

                                              ),),
                                          ),
                                          Positioned(
                                            bottom: 30,
                                            right: 10,
                                            child:  Text(
                                              "محلات وخدمات",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                                color:Color(0xffffffff),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            width: 95,
                                            height: 200,
                                            margin: EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              image: DecorationImage(
                                                image: AssetImage('Assets/Rectangle2.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),),
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              width: 95,
                                              height: 200,
                                              margin: EdgeInsets.all(5.0),
                                              decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(0.3),
                                                borderRadius: BorderRadius.circular(10.0),

                                              ),),
                                          ),
                                          Positioned(
                                            bottom: 30,
                                            right: 10,
                                            child:  Text(
                                              "محلات وخدمات",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                                color:Color(0xffffffff),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            width: 95,
                                            height: 200,
                                            margin: EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              image: DecorationImage(
                                                image: AssetImage('Assets/Rectangle2.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),),
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              width: 95,
                                              height: 200,
                                              margin: EdgeInsets.all(5.0),
                                              decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(0.3),
                                                borderRadius: BorderRadius.circular(10.0),

                                              ),),
                                          ),
                                          Positioned(
                                            bottom: 30,
                                            right: 10,
                                            child:  Text(
                                              "محلات وخدمات",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                                color:Color(0xffffffff),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            width: 95,
                                            height: 200,
                                            margin: EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              image: DecorationImage(
                                                image: AssetImage('Assets/Rectangle2.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),),
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              width: 95,
                                              height: 200,
                                              margin: EdgeInsets.all(5.0),
                                              decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(0.3),
                                                borderRadius: BorderRadius.circular(10.0),

                                              ),),
                                          ),
                                          Positioned(
                                            bottom: 30,
                                            right: 10,
                                            child:  Text(
                                              "محلات وخدمات",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                                color:Color(0xffffffff),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            width: 95,
                                            height: 200,
                                            margin: EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              image: DecorationImage(
                                                image: AssetImage('Assets/Rectangle2.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),),
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              width: 95,
                                              height: 200,
                                              margin: EdgeInsets.all(5.0),
                                              decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(0.3),
                                                borderRadius: BorderRadius.circular(10.0),

                                              ),),
                                          ),
                                          Positioned(
                                            bottom: 30,
                                            right: 10,
                                            child:  Text(
                                              "محلات وخدمات",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                                color:Color(0xffffffff),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                )
                              ],


                            ),
                          ],))),
                  ),
                  Expanded(
                    child: DraggableScrollableSheet(
                        maxChildSize:MediaQuery.of(context).size.height< 743.4285714285714? 0.95: 0.999,
                        minChildSize:MediaQuery.of(context).size.height< 743.4285714285714? 0.3:0.4,
                        initialChildSize: MediaQuery.of(context).size.height< 743.4285714285714?0.35:0.44 ,
                        builder: (BuildContext context, ScrollController scrolController){
                          return Stack(
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
                                      controller: scrolController,
                                      // controller: controller,
                                      children: [
                                        MediaQuery.of(context).size.height< 743.4285714285714?  SizedBox(height: 52,):SizedBox(height: 72,),

                                        ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: 20,
                                            physics: BouncingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              double scale = 1.0;
                                              return ViewRestaurantDiscounts();
                                            })
                                      ],
                                    ),
                                  )),
                              Container(
                                color:Colors.white,
                                  child: MyTabs())
                            ],
                          );}
                    ),
                  ),
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
