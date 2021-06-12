
import 'package:flutter/material.dart';
import 'package:mahzoooz/Screen/mapLoc.dart';

class noDataLocation extends StatefulWidget {
  const noDataLocation({Key key}) : super(key: key);

  @override
  _noDataLocationState createState() => _noDataLocationState();
}

class _noDataLocationState extends State<noDataLocation> {
  @override
  Widget build(BuildContext context) {
    return Container(


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
            SizedBox(height: 68,),

            new Text(
              "لايوجد عروض متوفرة في موقعك الحالى", //data['providerNameAr'] ==null? "مطاعم البيك السعودية":translator.currentLanguage == 'ar' ? data['providerNameAr']:data['providerNameEn'],
              textAlign: TextAlign.center,
              style: TextStyle(

                fontWeight: FontWeight.w700,
                fontSize: 14,
                color:Color(0xff91B958),
              ),
            ),
            new Text(
              "شويات وراجعين بخصومتنا", //data['providerNameAr'] ==null? "مطاعم البيك السعودية":translator.currentLanguage == 'ar' ? data['providerNameAr']:data['providerNameEn'],
              textAlign: TextAlign.center,
              style: TextStyle(

                fontWeight: FontWeight.w700,
                fontSize: 13,
                color:Color(0xff91B958),
              ),
            ),
            SizedBox(height: 88,),
            InkWell(
              onTap: (){
                Navigator.push(context, new MaterialPageRoute(builder: (context)=>new maps()));
              },
              child:    new Text(
                "تغيير الموقع الحالى", //data['providerNameAr'] ==null? "مطاعم البيك السعودية":translator.currentLanguage == 'ar' ? data['providerNameAr']:data['providerNameEn'],
                textAlign: TextAlign.center,
                style: TextStyle(

                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color:Colors.black,
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
