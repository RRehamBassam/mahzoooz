import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:mahzoooz/Widget/loading.dart';
import 'package:mahzoooz/api/NetworkRequest.dart';
class aboutApp extends StatefulWidget {
  const aboutApp({Key key}) : super(key: key);

  @override
  _aboutAppState createState() => _aboutAppState();
}

class _aboutAppState extends State<aboutApp> {
  var DataSaprot;
  var valuekey;
  @override
  void initState() {
    //  getImageInState();

    getDataSaprotState();
    //checkLocationServicesInDevice();
    // TODO: implement initState
    super.initState();
  }
  NetworkRequest networkRequest=new NetworkRequest();
  getDataSaprotState() async {

    // NetworkRequest networkRequest=new NetworkRequest();
    await networkRequest.SettingsGetAll().then((value){
      setState(() {
        DataSaprot=value;
        //    bytes = convert.base64.decode(value);
      });


    });
    print("${valuekey}  keykeykey");
  }
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
        child: SingleChildScrollView(
          child: Column(
            children: [
            // Container(
            //     width:MediaQuery.of(context).size.width
            //     ,child: Text(translator.translate('عن محظووظ'),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),)),
            //   SizedBox(height: 16,),
              DataSaprot==null?Center(child: Loading()): Text('''${DataSaprot["about"]}''',style: TextStyle(fontSize: 18),)

            ],
          ),
        ),
      ),
    );
  }
  //translator.translate('''محظوووظ هو تطبيقك الفريد والوحيد اللي تقدر من خلاله تلعب وتكسب وتشوف كل العروض والخصومات بأكبر المتاجر والمطاعم وأماكن الترفيه ومراكز التجميل وايضا المدارس العالمية ولأن وقتك غالي تقدرتحجز طاولتك بأرقي المطاعم وتقضي وقت ممتع مع كل حبابيك واصحابك .''')
}
