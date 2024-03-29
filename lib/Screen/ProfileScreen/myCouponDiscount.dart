import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:mahzoooz/Screen/bottomNavigationBar/noConnect.dart';
import 'package:mahzoooz/Widget/SingleItemReservationSchool.dart';
import 'package:mahzoooz/Widget/loading.dart';
import 'package:mahzoooz/api/NetworkRequest.dart';
class myCouponDiscount extends StatefulWidget {
  const myCouponDiscount({Key key}) : super(key: key);

  @override
  _myCouponDiscountState createState() => _myCouponDiscountState();
}

class _myCouponDiscountState extends State<myCouponDiscount> {
  NetworkRequest networkRequest=new NetworkRequest();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        body:Container(
          // height: 100,
          margin: EdgeInsets.all(12),
          child: Column(
            children: [
              FutureBuilder<dynamic>(
                  future: networkRequest.GetMyCoupons(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data.length);
                      return snapshot.data.length==0?Container(
                        height: MediaQuery.of(context).size.height*0.69,
                        margin: EdgeInsets.only(top: 16),
                        child: Center(
                          child: Column(
                            crossAxisAlignment:CrossAxisAlignment.center ,
                            mainAxisAlignment:MainAxisAlignment.center ,
                            children: [
SizedBox(height: 22,),
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
                                    child:  Image.asset("Assets/sad.png") ,
                                  ),
                                ),
                              ),
                              MediaQuery.of(context).size.height<600 ?SizedBox(height: 2,):  SizedBox(height: 68,),

                              new Text(
                                translator.translate("لايوجد بيانات"), //data['providerNameAr'] ==null? "مطاعم البيك السعودية":translator.currentLanguage == 'ar' ? data['providerNameAr']:data['providerNameEn'],
                                textAlign: TextAlign.center,
                                style: TextStyle(

                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                  color:Color(0xff91B958),
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
                      ):Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:snapshot.data.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return    SingleItemReservationSchool(snapshot.data[index]); }),
                      ); }
                    else if (snapshot.hasError) {
                      Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => NoConnect(

                              )));
                      return Center(child: Text("تأكد من إتصال بالإنرنت"));
                    }
                    // By default, show a loading spinner.
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 30,),
                        Loading(),
                        // ViewRestaurantDiscountsLoud(),
                        // ViewRestaurantDiscountsLoud()
                        // Loading(),
                        // Center(
                        //   child: PixLoader(
                        //       loaderType: LoaderType.Spinner, faceColor: Color(0xfff99b1d)),
                        // )
                        //CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xfff99b1d) ),)
                      ],
                    );}),
              // SingleItemReservation(),
              // SingleItemReservation(),
            ],
          ),
        )
    );
  }
  appBar(){
    return AppBar(
      leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios,color:Color(0xff38056e))),
      toolbarHeight: 65,
      elevation: 1,
      backgroundColor: Colors.white,
      title:Text( translator.translate("Discount coupon for schools"),style: TextStyle(color:Color(0xff38056e),fontSize: 18),) ,
      centerTitle: true,
    );
  }
}
