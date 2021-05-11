import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'dart:typed_data';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mahzoooz/Screen/Map.dart';
class SingleItemReservation extends StatefulWidget {
  var data;

  SingleItemReservation(this.data);

  @override
  _SingleItemReservationState createState() => _SingleItemReservationState(data);
}

class _SingleItemReservationState extends State<SingleItemReservation> {
  var data;

  _SingleItemReservationState(this.data);
  Uint8List bytes; Uint8List bytesback;
  @override
  void initState() {
    if(data['logo']!= null)
    {bytes= convert.base64.decode(data['logo'].split(',').last);}


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

                    image:data['logo']== null? Image.asset("Assets/ModalPanel.png",fit: BoxFit.fitWidth,height: 65.0,width: 65.0,): MemoryImage(bytes,),

                    fit: BoxFit.cover,
                  ),
                ),),
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(12.00),
              //   child:data['logo']== null? Image.asset("Assets/ModalPanel.png",fit: BoxFit.fitWidth,height: 65.0,width: 65.0,): MemoryImage(bytes),
              // ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start ,
                  children: [
                     Text(data['providerNameAr']== null?"مشتى دخول سيارة واحدة":translator.currentLanguage == 'ar' ?data['providerNameAr']:data['providerNameEn']),
                    Text(data['locationAr']== null?"الرياض":translator.currentLanguage == 'ar' ?data['locationAr']:data['locationEn']),
                  //  Spacer(),
                    Container(
                  width:MediaQuery.of(context).size.width- 130,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(""),
                          //Spacer(),
                          Text("حجز #${data['id']}",style: TextStyle(fontSize: 11),),
                        ],
                      ),
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
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => new maps(data['latitude'],data['longitude'])));
                  //
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
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }
}
