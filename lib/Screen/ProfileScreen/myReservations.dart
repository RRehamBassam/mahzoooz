import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:mahzoooz/Widget/SingleItemReservation.dart';
import 'package:mahzoooz/Widget/loading.dart';
import 'package:mahzoooz/api/NetworkRequest.dart';
class myReservations extends StatefulWidget {
  @override
  _myReservationsState createState() => _myReservationsState();
}

class _myReservationsState extends State<myReservations> {
  NetworkRequest networkRequest=new NetworkRequest();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
        body:Container(
         // height:MediaQuery.of(context).size.height*0.82,
          margin: EdgeInsets.all(12),
          child: Column(
            children: [
                  FutureBuilder<dynamic>(
                  future: networkRequest.MyBooking(),
                  builder: (context, snapshot) {
                  if (snapshot.hasData) {
                  print(snapshot.data.length);
                  return Expanded(
                    child: ListView.builder(
                    shrinkWrap: true,
                    itemCount:snapshot.data.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return    SingleItemReservation(snapshot.data[index]); }),
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
      title:Text( translator.translate("حجوزاتى"),style: TextStyle(color:Color(0xff38056e),fontSize: 20),) ,
      centerTitle: true,
    );
  }
}
