import 'package:page_transition/page_transition.dart';
import 'dart:typed_data';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:mahzoooz/Screen/RestaurantData.dart';
class ItemCarouselSlider extends StatefulWidget {
  var data;

  ItemCarouselSlider(this.data);

  @override
  _ItemCarouselSliderState createState() => _ItemCarouselSliderState(data);
}

class _ItemCarouselSliderState extends State<ItemCarouselSlider> {
  var data;

  _ItemCarouselSliderState(this.data);

  @override
  Widget build(BuildContext context) {
    // print(data);
    // Uint8List bytes= convert.base64.decode(data['offerImages'][0]['imageName'].split(',').last);
    return   Stack(
      children: [
        data==null?Container():  data['offerImages'][0]['imageName']==null?Container():  Container(
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image:NetworkImage(data['offerImages'][0]['imageName']),// MemoryImage(bytes),
              fit: BoxFit.cover,
            ),
          ),
        // child: Image.memory(bytes,fit: BoxFit.fitWidth),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            margin: EdgeInsets.all(5.0),
            padding: EdgeInsets.all(5.0) ,
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10.0),
            ),


            height: 69,
            child: Row(
              children: [

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width:MediaQuery.of(context).size.width*0.52,
                      child: new Text(
                        data==null?"":  data['providerNameAr']==null? "":translator.currentLanguage == 'ar' ? data['providerNameAr']:data['providerNameEn'],
                        textAlign:translator.currentLanguage == 'ar' ? TextAlign.right:TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis ,
                        //  fontFamily: 'Nimbus',
                          fontSize: 13,
                          color:Color(0xffffffff),
                        ),
                      ),
                    ),
                    Container(
                      width:MediaQuery.of(context).size.width*0.51,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: new Text(
                          data==null?"":  translator.currentLanguage == 'ar' ? data['titeAr']:data['titleEn'],//"خصم ١٠٠ ريال سعودي",
                          textAlign:translator.currentLanguage == 'ar' ? TextAlign.right:TextAlign.left,
                          style: TextStyle(

                            fontWeight: FontWeight.w700,
                            fontSize:translator.currentLanguage == 'ar' ?data['titeAr'].length>22?14:15:data['titleEn'].length>25?14: 15,
                            color:Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                InkWell(
                  onTap: (){
                    Navigator.push(context,PageTransition(
                      type: PageTransitionType.leftToRight,
                      duration: Duration(milliseconds: 550) ,
                      reverseDuration: Duration(milliseconds: 700),
                      child: RestaurantData(data),
                    ),);
                  },
                  child: Container(
                    width: 60,
                    height:30,
                    decoration: BoxDecoration(
                      color: Color(0xff38056e),borderRadius: BorderRadius.circular(18.00),
                    ),
                    child: Center(
                      child: new Text(
                        translator.translate("show"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 8,
                          color:Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
