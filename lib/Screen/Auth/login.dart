

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:mahzoooz/Screen/Auth/ActivateCode.dart';
import 'package:mahzoooz/Screen/Auth/createAccount.dart';
import 'package:mahzoooz/Screen/Auth/welcome.dart';
import 'package:mahzoooz/Screen/Auth/welcomeChangePass.dart';
import 'package:mahzoooz/Screen/Home.dart';
import 'package:mahzoooz/Widget/loading.dart';
import 'package:mahzoooz/api/NetworkRequest.dart';
import 'package:mahzoooz/services/helperFunctions.dart';

import '../../main.dart';
class login extends StatefulWidget {
  String phoneNo;
  bool isReservation;
  bool setPass;
  var code;

  login(this.phoneNo,this.isReservation,this.setPass,{this.code});

  @override
  _loginState createState() => _loginState(phoneNo,isReservation,setPass,code: code);
}

class _loginState extends State<login> {
  String phoneNumber;
  bool isReservation;
  bool setPass;
  var code;
  _loginState(this.phoneNumber,this.isReservation,this.setPass,{this.code});
  bool  _obscureText;
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLouding=false;
String Password;
  String otp, authStatus = "";
  @override
  void initState() {
    _obscureText = false;
  }
  getLoggedInState() async {
    await HelperFunctions.getUserMobileSharedPreference().then((value){

      phoneNumber= value;
    });
    ;
  }
  Future<void> verifyPhoneNumber(BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 15),
      verificationCompleted: (AuthCredential authCredential) {
        setState(() {
          authStatus = "Your account is successfully verified";
        });
      },
      // verificationFailed: (AuthException authException) {
      //   setState(() {
      //     authStatus = "Authentication failed";
      //   });
      // },
      codeSent: (String verId, [int forceCodeResent]) {
        verificationId = verId;
        setState(() {
          authStatus = "OTP has been successfully send";
        });
      //  Navigator.push(context, new MaterialPageRoute(builder: (context)=>  ActivateCode(otp,verificationId)));
       // otpDialogBox(context).then((value) {});
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
        setState(() {
          authStatus = "TIMEOUT";
        });
      },
    );
  }

  otpDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter your OTP'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color:  Color(0xff38056e), width: 0.0),
                  ),
                  focusColor: Color(0xff38056e),

                  border: new OutlineInputBorder(

                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30),
                    ),

                  ),
                ),
                onChanged: (value) {
                  otp = value;
                },
              ),
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                 // Navigator.push(context, new MaterialPageRoute(builder: (context)=>  Home()));
                  signIn(otp);
                },
                child: Text(
                  'Submit',
                ),
              ),
            ],
          );
        });
  }

  Future<void> signIn(String otp) async {
    // await FirebaseAuth.instance
    //     .signInWithCredential(PhoneAuthProvider.getCredential(
    //   verificationId: verificationId,
    //   smsCode: otp,
    // ));
  }

  NetworkRequest networkRequest=new NetworkRequest();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height*.3,
                  child:Center(child:  Image.asset('Assets/logoSmail.png'),)
              ),
              Container(
                  height: MediaQuery.of(context).size.height*.25,
                  width:MediaQuery.of(context).size.width ,
                  margin: EdgeInsets.only(right: 16,left: 16),
                  child:Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text(
                        "اهلاً بيك في محظوووظ",
                        // textAlign: TextAlign.right,gt3
                        style: TextStyle(fontWeight: FontWeight.w700,
                          fontSize: 23,
                          color:Colors.black54.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(height: 16,),
                      new Text(
                        "محظوووظ أول منصة ترفيهية \nتجمع لك جميع خصومات المتاجر\n في مكان واحد",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color:Color(0xff707070),
                        ),
                      )
                    ],
                  )),

              Container(
                height: MediaQuery.of(context).size.height*.25,
                child:Column(
                  children: [ Container(
                    width: MediaQuery.of(context).size.width*0.815,
                    height: MediaQuery.of(context).size.height*0.065,
                    child: TextFormField(//onChanged: (val)=>setState((){searchWord=val;}),
                      cursorColor: Color(0xff38056e),
                      keyboardType:TextInputType.text,
                      autofocus: false,
                      obscureText: !_obscureText,
                      textAlign: TextAlign.right,
                      //  onChanged: (val)=>setState(()=>Name=val),
                     // obscureText: true,
                      onChanged: (val){
                        setState(() {
                          Password=val;
                          HelperFunctions.saveUserPassWordSharedPreference(val);
                        });
                      },

                      decoration: InputDecoration(
                          suffixIcon:  new InkWell(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Container(
                              margin:EdgeInsets.symmetric(horizontal: 5) ,
                                child: Icon(_obscureText? Icons.visibility : Icons.visibility_off))),
                          contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(width: 1,color: Colors.grey[300]),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(width: 1,color:Color(0xff38056e))
                          ),
                          filled: true,
                          fillColor: Color(0xFFF8F8F8).withOpacity(0.7),
                          // prefixIcon:tajerAccount?Image.asset("Assets/icon-store.png",color:Color(0xfff99b1d),):Image.asset("Assets/icon-account.png") ,

                          hintText:"كلمة المرور",
                          // icon:tajerAccount?Image.asset("Assets/icon-store.png",color:Color(0xfff99b1d),):Image.asset("Assets/icon-account.png") ,
                          hintStyle: TextStyle(color: Colors.black,fontFamily: "Tajawal"),
                          labelStyle: null
                      ),

                    ),
                  ),
                    isLouding?SizedBox(height: 22,): SizedBox(height: 16,),
                    isLouding?Loading():  InkWell(

                      onTap: ()async {
                        print("1");
                        if(Password==null){
                          print("2");
                            Fluttertoast.showToast(
                                msg: "يجب عليك إدخال كلمة المرور",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Color(0xff38056e).withOpacity(0.9),
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                        }else{
                          print("3");
                          setState(() {
                            isLouding=true;
                          });
                          if(isReservation){
                            await getLoggedInState();
                          }
                          if(!setPass) {

                                  await getUserHasAccount(
                                      phoneNumber, Password);
                                  if (message == "OK") {
                                    if (isReservation) {
                                      Navigator.pop(context);
                                    } else {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(builder: (_) {
                                        return Home();
                                      }), (route) => false);
                                      //    Navigator.push(context, new MaterialPageRoute(builder: (context)=>  Home()));

                                    }

                                    //phoneNumber == null ? null : verifyPhoneNumber(context);
                                    // Navigator.push(context, new MaterialPageRoute(builder: (context)=>  Home()));
                                  } else {
                                    print("4");
                                    setState(() {
                                      isLouding = false;
                                    });
                                    Fluttertoast.showToast(
                                        msg: message,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor:
                                            Color(0xff38056e).withOpacity(0.9),
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                }else{
                            await getUserSetPass(
                                phoneNumber, Password);
                            if (message == "Password change successfuly") {
                              if (isReservation) {
                                Navigator.pop(context);
                              } else {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(builder: (_) {
                                      return Home();
                                    }), (route) => false);
                                //    Navigator.push(context, new MaterialPageRoute(builder: (context)=>  Home()));

                              }

                              //phoneNumber == null ? null : verifyPhoneNumber(context);
                              // Navigator.push(context, new MaterialPageRoute(builder: (context)=>  Home()));
                            } else {
                              print("4");
                              setState(() {
                                isLouding = false;
                              });
                              Fluttertoast.showToast(
                                  msg: message,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:
                                  Color(0xff38056e).withOpacity(0.9),
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }

                          }
                              }


                      },
                      child: new Container(
                        width: MediaQuery.of(context).size.width*0.815,
                        height: MediaQuery.of(context).size.height*0.065,
                        decoration: BoxDecoration(
                          color: Color(0xff38056e),borderRadius: BorderRadius.circular(25.00),
                        ),
                        child: Center(
                          child: new Text(
                            "دخول",
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
                  ],
                ),),



              InkWell(
                onTap: ()=>Navigator.push(context, new MaterialPageRoute(builder: (context)=>  welcomeChangePass(false))),
                child: new Text(
                  "لقد نسيت رقم السر",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color:Color(0xff38056e),
                  ),
                ),
              ),
              InkWell(
                onTap:(){
                  translator.setNewLanguage(
                    context,
                    newLanguage: translator.currentLanguage == 'ar' ? 'en' : 'ar',
                    remember: true,

                  );
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_){
                        return MyApp();
                      }),(route)=> false
                  );
                },
                child: Container(
                  height:MediaQuery.of(context).size.height*.2 ,
                  alignment: Alignment.bottomCenter,
                  child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('Assets/Group 39810.png'),
                          new Text(
                            translator.translate('Change to English'),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: "DIN Next LT Arabic",fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color:Color(0xff38056e),
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  getUserHasAccount(String phone,String pass) async {

    await   networkRequest.Login(phone,pass).then((value){
      setState(() {
        message  = value['message'];

      });
    });
  }
  getUserSetPass(String phone,String pass) async {

    await   networkRequest.resetPass(phone,pass,code).then((value){
      setState(() {
        message  = value['message'];

      });
    });
  }
  String message;
}
