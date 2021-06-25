import 'package:flutter/material.dart';
import 'package:mahzoooz/api/NetworkRequest.dart';

import 'ViewRestaurantDiscounts.dart';
import 'ViewRestaurantDiscountsLoud.dart';
class PartScrolDiscount extends StatefulWidget {
var colId;
var latLnglocation;

PartScrolDiscount(this.colId,this.latLnglocation);

  @override
  _PartScrolDiscountState createState() => _PartScrolDiscountState(colId,latLnglocation);
}

class _PartScrolDiscountState extends State<PartScrolDiscount> {
  var colId;
  var latLnglocation;
  _PartScrolDiscountState(this.colId,this.latLnglocation);
  NetworkRequest networkRequest=new NetworkRequest();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      // if(category.categoryId==0)
      // appState.updateColId("IsBestOffer");
      // else if(category.categoryId==1)
      // appState.updateColId("IsBestOffer");
      // else if(category.categoryId==2)
      // appState.updateColId("CreatedDate");
      // else if(category.categoryId==3)
      // appState.updateColId("AverageRate");
        future: networkRequest.OffersGetPaged(false,"",latLnglocation.latitude,latLnglocation.longitude,colId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.length);
            return
              Container(
                margin: EdgeInsets.only(top: 16),
                //  height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount:snapshot.data.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ViewRestaurantDiscounts(snapshot.data[index]);
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
          );});
  }


}
