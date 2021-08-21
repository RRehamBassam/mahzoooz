import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:mahzoooz/Screen/mapLoc.dart';
import 'package:provider/provider.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:mahzoooz/services/app_state.dart';

import '../main.dart';
class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white,
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
           translator.translate('Settings'),
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
      body:ChangeNotifierProvider<AppState>(
    create: (_) => AppState(),
    child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 30.0),
    child: Consumer<AppState>(
    builder: (context, appState, _) {
    return Center(
          child: Column(
            children: [
              SizedBox(height: 16,),
            // Adobe XD layer: 'Bg' (shape)

          // Adobe XD layer: 'Bg' (shape)
          InkWell(
            onTap: (){
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),

                    padding: EdgeInsets.only(
                      top: 0,
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: BottomSheetExample(context),
                  ),
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width*0.85,
              height: MediaQuery.of(context).size.height*0.08,
              margin: EdgeInsets.symmetric(vertical:8),
              padding:EdgeInsets.only(top: 16,left: 16,right: 16,bottom: 12) ,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28.0),
                color: const Color(0xfff8f8f8),
              ),
              child: Center(
                child: Row(
                 // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   Column(
                     children: [
// Adobe XD layer: 'text' (text)
                SizedBox(
                width: 60.0,
                  child: Text(
                    translator.translate('language'),
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color(0x801a1824),
                      height: 1.5,
                    ),
                    textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(height: 8,),// Adobe XD layer: 'text' (text)
                SizedBox(
                  width: 66.0,
                  child: Text(
                    appState.selectedCategory==1 || translator.currentLanguage == 'ar' ?'اللغة العربية':"English",
                    style: TextStyle(

                      fontSize: 12,
                      color: const Color(0xff1a1824),
                      fontWeight: FontWeight.w500,
                      height: 1.4166666666666667,
                    ),
                    textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.right,
                  ),
                ),
                     ],
                   ),
                    Spacer(),
                  // Adobe XD layer: 'text' (text)
                  SizedBox(
                  width: 40.0,
                  child: Text(
                    translator.translate('change'),
                    style: TextStyle(

                      fontSize: 12,
                      color: const Color(0xff38056e),
                      letterSpacing: -0.12,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                  ],
                ),
              ),
            ),
          ),
              Container(
                width: MediaQuery.of(context).size.width*0.85,
                height: MediaQuery.of(context).size.height*0.08,
                margin: EdgeInsets.symmetric(vertical:8),
                padding:EdgeInsets.only(top: 16,left: 16,right: 16,bottom: 12) ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28.0),
                  color: const Color(0xfff8f8f8),
                ),
                child: Center(
                  child: Row(
                    children: [
                      Column(
                        children: [
// Adobe XD layer: 'text' (text)
                          SizedBox(
                            width: 70.0,
                            child: Text(
                              translator.translate('password'),
                              style: TextStyle(

                                fontSize: 12,
                                color: const Color(0x801a1824),
                                height: 1.5,
                              ),
                              textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          SizedBox(height: 8,),// Adobe XD layer: 'text' (text)
                          SizedBox(
                            width: 66.0,
                            child: Text(
                              '••••••••',
                              style: TextStyle(

                                fontSize: 12,
                                color: const Color(0xff1a1824),
                                fontWeight: FontWeight.w500,
                                height: 1.4166666666666667,
                              ),
                              textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      // Adobe XD layer: 'text' (text)
                      SizedBox(
                        width: 40.0,
                        child: Text(
                            translator.translate('change'),
                          style: TextStyle(
                        //    fontFamily: 'DIN Next LT Arabic',
                            fontSize: 12,
                            color: const Color(0xff38056e),
                            letterSpacing: -0.12,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),

                    ],
                  ),
                ),
              ),InkWell(
                onTap: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (context)=>new maps()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width*0.85,
                  height: MediaQuery.of(context).size.height*0.08,
                  margin: EdgeInsets.symmetric(vertical:8),
                  padding:EdgeInsets.only(top: 16,left: 16,right: 16,bottom: 12) ,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28.0),
                    color: const Color(0xfff8f8f8),
                  ),
                  child: Center(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
// Adobe XD layer: 'text' (text)
                            SizedBox(
                              width: 60.0,
                              child: Text(
                                translator.translate("موقع"),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: const Color(0x801a1824),
                                  height: 1.5,
                                ),
                                textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                textAlign:translator.currentLanguage == 'ar' ? TextAlign.right:TextAlign.left,
                              ),
                            ),
                            SizedBox(height: 8,),// Adobe XD layer: 'text' (text)
                            SizedBox(
                              width:translator.currentLanguage == 'ar' ?66 :110.0,
                              child: Text(
                                appState.selectedCategory==1 || translator.currentLanguage == 'ar' ?translator.translate("غيير موقعك"):translator.translate("غيير موقعك"),
                                style: TextStyle(

                                  fontSize: 12,
                                  color: const Color(0xff1a1824),
                                  fontWeight: FontWeight.w500,
                                  height: 1.4166666666666667,
                                ),
                                textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                textAlign:translator.currentLanguage == 'ar' ? TextAlign.right:TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        // Adobe XD layer: 'text' (text)
                        SizedBox(
                          width: 40.0,
                          child: Text(
                            translator.translate('change'),
                            style: TextStyle(

                              fontSize: 12,
                              color: const Color(0xff38056e),
                              letterSpacing: -0.12,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          // Adobe XD layer: 'Bg' (shape)
              Container(
                width: MediaQuery.of(context).size.width*0.85,
                height: MediaQuery.of(context).size.height*0.08,
                margin: EdgeInsets.symmetric(vertical:8),
                padding:EdgeInsets.only(top: 16,left: 16,right: 16,bottom: 9) ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28.0),
                  color: const Color(0xfff8f8f8),
                ),
                child: Center(
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
// Adobe XD layer: 'text' (text)
                          SizedBox(
                            width: 110.0,
                            child: Text(
                                translator.translate('Receive notifications'),
                              style: TextStyle(

                                fontSize: 12,
                                color: Color(0xff1a1824),
                                height: 1.5,
                              ),
                              textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        //  SizedBox(height: 8,),// Adobe XD layer: 'text' (text)
                          // SizedBox(
                          //   width: 66.0,
                          //   child: Text(
                          //     '••••••••',
                          //     style: TextStyle(
                          //
                          //       fontSize: 12,
                          //       color: const Color(0xff1a1824),
                          //       fontWeight: FontWeight.w500,
                          //       height: 1.4166666666666667,
                          //     ),
                          //     textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                          //     textAlign: TextAlign.right,
                          //   ),
                          // ),
                        ],
                      ),
                      Spacer(),
                      // Adobe XD layer: 'text' (text)
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CustomSwitch(
                              activeColor: Color(0xff38056e),

                              value: status,
                              onChanged: (value) {
                              //  print("VALUE : $value");
                                setState(() {
                                  status = value;
                                });
                              },
                            ),
                            SizedBox(height: 4.0,),
                            // Text('Value : $status', style: TextStyle(
                            //     color: Colors.black,
                            //     fontSize: 20.0
                            // ),)
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),


            ],
          ),
        )
    ;},
    ),
    ),
    ));
  }
  BottomSheetExample(context){
    return
      ChangeNotifierProvider<AppState>(
          create: (_) => AppState(),
          child: Consumer<AppState>(
          builder: (context, appState, _) {
          print(appState.selectedCategory);
          if(appState.selectedCategory==1){
          //  networkRequest.changestatusorder(id,"4");
          //  Navigator.pop(context);
          }

          return  Container(
              color: Colors.black45.withOpacity(0.56),

              child: Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color:Colors.white,
                  boxShadow: [BoxShadow(
                      color: Color.fromRGBO(34, 134, 234, .3),
                      blurRadius: 20,
                      offset: Offset(0, 10)
                  )],


                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35.0),
                    topRight: Radius.circular(35.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 16,),
                    InkWell(
                      onTap: (){
                        appState.updateCategory(1);

                      },
                      child: Container(
                        width:MediaQuery.of(context).size.width*0.8,
                        height:MediaQuery.of(context).size.height*0.052 ,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: appState.selectedCategory==1? Color(0xff80AB40):const Color(0xfff8f8f8),
                        ),
                        child: // Adobe XD layer: 'Phone Number' (text)
                        Center(
                          child: Text(
                            'اللغة العربية',
                            style: TextStyle(
                              fontFamily: 'DIN Next LT Arabic',
                              fontSize: 14,
                              color: appState.selectedCategory==1?Colors.white: const Color(0xff909090),
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    InkWell(
                      onTap: (){
                        appState.updateCategory(2);

                      },
                      child: Container(
                        width:MediaQuery.of(context).size.width*0.8,
                        height:MediaQuery.of(context).size.height*0.052 ,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color:appState.selectedCategory==2? Color(0xff80AB40):const Color(0xfff8f8f8),
                        ),
                        child: // Adobe XD layer: 'Phone Number' (text)
                        Center(
                          child: Text(
                            'English',
                            style: TextStyle(

                              fontSize: 14,
                              color:appState.selectedCategory==2?Colors.white: const Color(0xff909090),
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    GestureDetector(
                      onTap:()=> {
                        print(appState.selectedCategory),
                      translator.setNewLanguage(
                      context,
                      newLanguage:appState.selectedCategory==1? 'ar':'en',
                      remember: true,
                      ),
                      Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_){
                      return MyApp();
                      }),(route)=> false
                      ),
                       // Navigator.pop(context)
                      },
                      child: new Container(
                        margin:EdgeInsets.only(right: 30, left: 30),
                        width:20,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Color(0xff38056e),borderRadius: BorderRadius.circular(25.00),
                        ),
                        child: Center(
                          child: new Text(
                            translator.translate( "حفظ"),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color:Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // ListWheelScrollView(
                    //   itemExtent: 100,
                    //
                    //   // diameterRatio: 1.6,
                    //   // offAxisFraction: -0.4,
                    //   // squeeze: 0.8,
                    // //  clipToSize: true
                    //
                    // )

                  ],
                ),
              ),
            );},
          ),
      );
  }
}
