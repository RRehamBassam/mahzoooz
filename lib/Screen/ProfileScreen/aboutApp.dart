import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
class aboutApp extends StatefulWidget {
  const aboutApp({Key key}) : super(key: key);

  @override
  _aboutAppState createState() => _aboutAppState();
}

class _aboutAppState extends State<aboutApp> {
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
            translator.translate('About App'),
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
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
          Container(
              width:MediaQuery.of(context).size.width
              ,child: Text('عن محظووظ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),)),
            SizedBox(height: 16,),
            Text('''محظوووظ هو تطبيقك الفريد والوحيد اللي تقدر من خلاله تلعب وتكسب وتشوف كل العروض والخصومات بأكبر المتاجر والمطاعم وأماكن الترفيه ومراكز التجميل وايضا المدارس العالمية ولأن وقتك غالي تقدرتحجز طاولتك بأرقي المطاعم وتقضي وقت ممتع مع كل حبابيك واصحابك .''',style: TextStyle(fontSize: 18),)

          ],
        ),
      ),
    );
  }
}
