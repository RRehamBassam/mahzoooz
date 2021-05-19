import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:mahzoooz/Widget/loading.dart';
import 'package:mahzoooz/Widget/ViewRestaurantDiscounts.dart';
import 'package:mahzoooz/api/NetworkRequest.dart';
class Favourites extends StatefulWidget {
  const Favourites({Key key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  NetworkRequest networkRequest=new NetworkRequest();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading:  InkWell(
          onTap:(){
            Navigator.pop(context);
          },
          child: Container(
            // margin: EdgeInsets.all(8),
              child: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        ),
        backgroundColor: Colors.white,
        title: SizedBox(
          width: 87.0,
          child: Text(
            translator.translate('Favourites'),
            style: TextStyle(
              // fontFamily: 'DIN Next LT Arabic',
              fontSize: 16,
              color:  Colors.black,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 18,),
          FutureBuilder<dynamic>(
              future: networkRequest.OffersFavourites(false),
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
                );}),

        ],
      ),
    );
  }
}
