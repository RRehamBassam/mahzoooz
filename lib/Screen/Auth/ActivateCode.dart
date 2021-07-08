import 'package:flutter/material.dart';
import 'package:mahzoooz/Screen/Auth/login.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:mahzoooz/Screen/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mahzoooz/Screen/Auth/createAccount.dart';
class ActivateCode extends StatefulWidget {
  String smsOTP;
   String phoneNumber;
 var code;
  String verificationId;
  bool setPass;
  ActivateCode(this.smsOTP, this.verificationId,this.phoneNumber,this.code,this.setPass);
  @override
  _ActivateCodeState createState() => _ActivateCodeState(smsOTP,verificationId,phoneNumber,code,setPass);
}

class _ActivateCodeState extends State<ActivateCode> {
  String smsOTP;
  String verificationId;
  String phoneNumber;
   var code;
  bool setPass;
  _ActivateCodeState(this.smsOTP, this.verificationId,this.phoneNumber,this.code,this.setPass);

  // Future<void> signIn(String smsOTP) async {
  //   await FirebaseAuth.instance
  //       .signInWithCredential(PhoneAuthProvider.getCredential(
  //     verificationId: verificationId,
  //     smsCode: smsOTP,
  //   ));
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Color(0xFFFEFEFE),
        title: new Text(
          'كود التأكيد',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color:Color(0xff747474),
          ),
        ),
      ),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 25,),
            Container(
              height:  MediaQuery.of(context).size.height *0.25,
              child: Column(
                children: [
                  new Text(
                    setPass?"من فضلك ادخل الكود المرسل على جوالكم لاستعادة كلمة المرور":"أدخل الكورد الذي ارسلناه لك",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "DIN Next LT Arabic",
                      fontSize: 14,
                      color:Color(0xff454545),
                    ),
                  ),
                  SizedBox(height: 8,),
                  new Text(
                    "تم ارسال رمز التحقيق الي رقم\n$phoneNumber",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "DIN Next LT Arabic",
                      fontSize: 17,
                      color:Color(0xff909090),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height:  MediaQuery.of(context).size.height *0.30,
              child:Column(
                children: [
                  PinEntryTextField(
                    fields: 6,
                    showFieldAsBox: true, onSubmit: (String pin){
                    setState(() {
                      smsOTP=pin;
                      // ActiationCode=pin;
                    });
                    // showDialog(context: context, builder: (context){
                    //           return AlertDialog(
                    //             title: Text("Pin"),
                    //             content: Text('Pin entered is $pin'),
                    //           );}
                    //           );
                  },),
                  SizedBox(height: 8,),
                  new Text(
                    "اعد الارسال ( ٣٠ ثانية )",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "DIN Next LT Arabic",
                      fontSize: 14,
                      color:Color(0xff38056e),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              )),

        Container(
          height:  MediaQuery.of(context).size.height *0.12,),
            InkWell(
              onTap:() {
              //  signIn( smsOTP);
                if(smsOTP!=null)
                  if(!setPass) {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              CreateAccount(phoneNumber, code)));
                }else{
                       Navigator.push(context, new MaterialPageRoute(builder: (context)=>  login(phoneNumber,false,true,code: code,)));

                  }
              },
              child: new Container(
                  height: 48.00,
                  width: 311.00,
                  decoration: BoxDecoration(
                    color: Color(0xff38056e),borderRadius: BorderRadius.circular(25.00),
                  ),
                  child:Center(
                    child: new Text(
                     setPass?"استعادة كلمة المرور" :"دخول",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color:Color(0xffffffff),
                      ),
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
