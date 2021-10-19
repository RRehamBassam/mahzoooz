import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
class NoConnect extends StatefulWidget {


  @override
  _NoConnectState createState() => _NoConnectState();
}

class _NoConnectState extends State<NoConnect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.18),
        height: MediaQuery.of(context).size.height*0.56,
        child: Center(
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.center ,
            mainAxisAlignment:MainAxisAlignment.spaceBetween ,
            children: [

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
                    child: Image.asset("Assets/sad.png") ,
                  ),
                ),
              ),
              SizedBox(height: 45,),
              new Text(
                translator.translate("تأكد من اتصال بالانترنت"), //data['providerNameAr'] ==null? "مطاعم البيك السعودية":translator.currentLanguage == 'ar' ? data['providerNameAr']:data['providerNameEn'],
                textAlign: TextAlign.center,
                style: TextStyle(

                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color:Color(0xff91B958),
                ),
              ),
              // new Text(
              //   "لايوجد عروض متوفرة", //data['providerNameAr'] ==null? "مطاعم البيك السعودية":translator.currentLanguage == 'ar' ? data['providerNameAr']:data['providerNameEn'],
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //
              //     fontWeight: FontWeight.w700,
              //     fontSize: 16,
              //     color:Color(0xff029789),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
