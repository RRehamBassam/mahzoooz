import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'dart:typed_data';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:mahzoooz/Screen/OpenMap.dart';
import 'package:mahzoooz/api/NetworkRequest.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mahzoooz/Screen/Map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mahzoooz/Screen/ProfileScreen/myReservations.dart';

class SingleItemReservation extends StatefulWidget {
  var data;

  SingleItemReservation(this.data);

  @override
  _SingleItemReservationState createState() => _SingleItemReservationState(data);
}

class _SingleItemReservationState extends State<SingleItemReservation> {
  var data;
  NetworkRequest networkRequest=new NetworkRequest();
  _SingleItemReservationState(this.data);
  Uint8List bytes; Uint8List bytesback;
  @override
  void initState() {
    // if(data['logo']!= null)
    // {bytes= convert.base64.decode(data['logo'].split(',').last);}
    //

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(8.0),
        color: const Color(0xffffffff),
      ),
      height: MediaQuery.of(context).size.height*0.18,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 72.0,width: 65.0,
                // margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(

                    image:NetworkImage("${data['logo']}"),// MemoryImage(bytes,),

                    fit: BoxFit.cover,
                  ),
                ),),
              //  ClipRRect(
              //  borderRadius: BorderRadius.circular(12.00),
              //    child:Image.asset("Assets/ModalPanel.png",fit: BoxFit.fitWidth,height: 65.0,width: 65.0,),
              // ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start ,
                  children: [
                     Text(data['providerNameAr']== null?"مشتى دخول سيارة واحدة":translator.currentLanguage == 'ar' ?data['providerNameAr']:data['providerNameEn'],style: TextStyle(color: Colors.black.withOpacity(0.6))),
                    SizedBox(height: 4,), Text(data['titleAr']== null?"خصم":translator.currentLanguage == 'ar' ?data['titleAr']:data['titleEn'],style: TextStyle(color: Colors.black),),
                  //  Spacer(),


                  ],
                ),
              ),
              Spacer(),
              Container(
              //  width:MediaQuery.of(context).size.width- 130,
                child:Column(
                  children: [
                    InkWell(
                      onTap: ()async{
                        if(!data['isCanceled'] && !data["isFinished"]){
                          showAlertDialog( context,data);}

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text(data["isFinished"]?translator.translate("إنتهاء مدة الحجز"):data['isCanceled']?translator.translate("تم إلغاء"):translator.translate("إلغاء"),style: TextStyle(fontSize: 12,color: Colors.red[900],fontWeight: FontWeight.w700),textAlign: TextAlign.left,),
                        ],
                      ),
                    ),
                   SizedBox(height: 32,),///201098994275
                   // Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text("حجز #${data['id']}",style: TextStyle(fontSize: 11),),//201098994275
                      ],
                    )
                  ],
                ),
              )

            ],
          ),
          Container(height: 1,width: MediaQuery.of(context).size.width*0.84,color: Colors.grey.withOpacity(0.2),),
          Container(
            height: MediaQuery.of(context).size.height*0.055,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 2,),
                    Icon(Icons.person_outline,size: 22,),
                  Text(" شخص ${data['numberOfPerson']} ",style: TextStyle(fontSize: 9),)
                  ],
                ),
    Container(height: MediaQuery.of(context).size.height*0.05,width: 1,color: Colors.grey.withOpacity(0.2),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 2,),
                    Icon(Icons.date_range_outlined,size: 22,),
                    Text(" ${data['dayDate'].toString().split('T')[0]} ",style: TextStyle(fontSize: 9),)
                  ],
                ),
                Container(height: MediaQuery.of(context).size.height*0.05,width: 1,color: Colors.grey.withOpacity(0.2),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 2,),
                    Icon(Icons.access_time_outlined,size: 22,),
                    Text("  ${data['bookingTime'].toString().split(':')[0]}:${data['bookingTime'].toString().split(':')[1].split(':')[0]} ",style: TextStyle(fontSize: 9),)
                  ],
                ),
                Container(height: MediaQuery.of(context).size.height*0.05,width: 1,color: Colors.grey.withOpacity(0.2),),
                InkWell(
                  onTap: (){
                    MapUtils.openMap(data['latitude'],data['longitude']);

                    // Navigator.push(context,
                     //    new MaterialPageRoute(builder: (context) => new maps(data['latitude'],data['longitude'])));

                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 2,),
                      Icon(Icons.location_on_outlined,size: 22,),
                      Text(" الاتجاهات ",style: TextStyle(fontSize: 9),)
                    ],
                  ),
                ),
                Container(height: MediaQuery.of(context).size.height*0.05,width: 1,color: Colors.grey.withOpacity(0.2),),
                InkWell(
                  onTap: (){
                    customLaunch('tel:${data['mobile']}');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 2,),
                      Icon(Icons.call,size: 22,),
                    Text(" اتصل الان ",style: TextStyle(fontSize: 9),)
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  var message;
  getLoggedInState() async {
    await networkRequest.CancelBooking(data['id']).then((value){
      setState(() {
        message  = value['message'];
      });
    });
  }
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }
  showAlertDialog(BuildContext context,data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("إلغاء الحجز"),
          content: Text("هل تريد بتاكيد الغا ء الحجز؟"),
          actions: [
            FlatButton(
              child: Text("إلغاء"),
              onPressed:  () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("تأكيد"),
              onPressed:  () async {
                if(!data['isCanceled']){
                  await getLoggedInState();
                  if(message== "Booking Canceled Successfully"){
                    Fluttertoast.showToast(
                        msg: "تم إلغاء الحجز",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Color(0xff38056e).withOpacity(0.9),
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (a, b, c) => myReservations(),
                        transitionDuration: Duration(seconds: 0),
                      ),
                    );
                  } else{
                    Fluttertoast.showToast(
                        msg: "لم يتم إلغاء الحجز حاول مرة اخرى",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Color(0xff38056e).withOpacity(0.9),
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }

                }
              },
            ),
          ],
        );
      },
    );

  }
}
