import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:mahzoooz/Screen/Auth/ActivateCode.dart';
import 'package:mahzoooz/Screen/Auth/createAccount.dart';
import 'package:mahzoooz/Screen/Auth/login.dart';
import 'package:mahzoooz/Widget/loading.dart';
import 'package:mahzoooz/api/NetworkRequest.dart';
import 'package:mahzoooz/Screen/Home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mahzoooz/services/helperFunctions.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';
class welcome extends StatefulWidget {
  bool isReservation;

  welcome(this.isReservation);

  @override
  _welcomeState createState() => _welcomeState(isReservation);
}

class _welcomeState extends State<welcome> {
  bool isReservation;

  _welcomeState(this.isReservation);
bool codeScreen;
  String phoneNumber;
  String phoneIsoCode;
  String changePass;
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;

bool isLouding=false;
bool isverifyPhoneNumbe=false;
  String otp, authStatus = "";
  bool setPass=false;
  Future<void> verifyPhoneNumber(BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(

      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 15),
      verificationCompleted: (AuthCredential authCredential) {
        setState(() {
          authStatus = "Your account is successfully verified";
        });
        // Navigator.push(context, new MaterialPageRoute(
        //     builder: (context) => CreateAccount(phoneNumber, code)));
      },
      // verificationFailed: (AuthException authException) {
      //   setState(() {
      //     authStatus = "Authentication failed";
      //   });
      // },
      codeSent: (String verId, [int forceCodeResent])async {

        verificationId = verId;
        setState(() {
          authStatus = "OTP has been successfully send";
        });
        print("$forceCodeResent forceCodeResent");
      await  Navigator.push(context, new MaterialPageRoute(builder: (context)=>  ActivateCode(otp,verificationId,phoneNumber,code,false)));
        setState(() {
          isLouding=false;
        });

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
  TextEditingController _passController = new TextEditingController();

  void onPhoneNumberChange(String number, String internationalizedPhoneNumber, String isoCode) {
    print(internationalizedPhoneNumber);
    print(number);
    print(isoCode);
    setState(() {
      phoneNumber = internationalizedPhoneNumber;
      phoneIsoCode = isoCode;
    });
  }
  @override
  void initState() {
    codeScreen =false;
    super.initState();
  }


  NetworkRequest networkRequest=new NetworkRequest();
  @override
  Widget build(BuildContext context) {
    return codeScreen==true? Scaffold(
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
                    // Directionality(
                    //   textDirection:translator.currentLanguage == 'ar' ? TextDirection.ltr:TextDirection.ltr,
                    //
                    //   child: PinFieldAutoFill(
                    //
                    //     decoration: UnderlineDecoration(
                    //       textStyle: TextStyle(fontSize: 20, color: Colors.black),
                    //       colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
                    //     ),
                    //     currentCode: smsOTP,
                    //     onCodeSubmitted: (code) {},
                    //     onCodeChanged: (code) {
                    //
                    //         FocusScope.of(context).requestFocus(FocusNode());
                    //
                    //     },
                    //   ),
                    // ),
                    Directionality(
                      textDirection:translator.currentLanguage == 'ar' ? TextDirection.ltr:TextDirection.ltr,
                      child: PinEntryTextField(
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
                    ),
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
                    FirebaseAuth.instance.currentUser().then((user){

                      //  Navigator.of(context).pop();
                        signIn2(smsOTP);

                    });
                    //signIn(smsOTP);print(authStatus);

                    // Navigator.push(
                    //     context,
                    //     new MaterialPageRoute(
                    //         builder: (context) =>
                    //             CreateAccount(phoneNumber, code)));
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
    ):Scaffold(
      body:GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
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
                       translator.translate("Welcome to Mahzoooz"),
                         // textAlign: TextAlign.right,
                          style: TextStyle(fontWeight: FontWeight.w700,
                            fontSize: 23,
                            color:Colors.black54.withOpacity(0.7),
                          ),
                        ),
                        SizedBox(height: 16,),
                        new Text( translator.translate("Mahzoooz for"),
                         // translator.translate("محظوووظ أول منصة ترفيهية \nتجمع لك جميع خصومات المتاجر\n في مكان واحد"),
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
                    children: [
                    //   Container(
                    //   width: MediaQuery.of(context).size.width*0.815,
                    //   height: MediaQuery.of(context).size.height*0.065,
                    //   child: TextFormField(//onChanged: (val)=>setState((){searchWord=val;}),
                    //     cursorColor: Color(0xff38056e),
                    //     keyboardType:TextInputType.text,
                    //     autofocus: false,
                    //     textAlign: TextAlign.right,
                    //     //  onChanged: (val)=>setState(()=>Name=val),
                    //     obscureText: false,
                    //
                    //     decoration: InputDecoration(
                    //         contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.all(Radius.circular(30)),
                    //           borderSide: BorderSide(width: 1,color: Colors.grey[300]),
                    //         ),
                    //         border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.all(Radius.circular(30)),
                    //             borderSide: BorderSide(width: 1,color:Color(0xff38056e))
                    //         ),
                    //         filled: true,
                    //         fillColor: Color(0xFFF8F8F8).withOpacity(0.7),
                    //         // prefixIcon:tajerAccount?Image.asset("Assets/icon-store.png",color:Color(0xfff99b1d),):Image.asset("Assets/icon-account.png") ,
                    //
                    //         hintText:"+966 66 666 6666",
                    //         // icon:tajerAccount?Image.asset("Assets/icon-store.png",color:Color(0xfff99b1d),):Image.asset("Assets/icon-account.png") ,
                    //         hintStyle: TextStyle(color: Colors.black),
                    //         labelStyle: null
                    //     ),
                    //
                    //   ),
                    // ),

                      Container(
                        padding: EdgeInsets.symmetric( vertical: 4,horizontal: 16),
                          width: MediaQuery.of(context).size.width*0.815,
                          height: MediaQuery.of(context).size.height*0.065,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.00, color: Colors.grey[300],), borderRadius: BorderRadius.circular(30.00),
                        ),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: InternationalPhoneInput(

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(width: 1,color:Color(0xff38056e))
                              ),
                            // hintStyle: TextStyle(color: Colors.white),
                              decoration:InputDecoration.collapsed(

                                  hintText: '(56) 123-1234',hintStyle: TextStyle(fontFamily: "Tajawal")
                              ),
                              initialSelection: '+966',
                              onPhoneNumberChange: onPhoneNumberChange,
                              // initialPhoneNumber: phoneNumber,
                              // initialSelection:phoneIsoCode,
                              dropdownIcon: Icon(Icons.arrow_drop_down,color: Colors.grey[300],),
                              labelStyle: TextStyle(color: Colors.grey[300],fontFamily: "Tajawal"),
                              enabledCountries: ['+20','+970','+966'],
                              //showCountryFlags: false,
                              showCountryCodes: true),
                        ),
                      ),
                      isLouding?SizedBox(height: 22,): SizedBox(height: 16,),
                      isLouding?Loading(): InkWell( //networkRequest.Login(),
                        onTap: ()async{
                          //networkRequest.CategoriesGetPaged();
                        //  networkRequest.OffersGetPaged();
                          if(phoneNumber==null||phoneNumber.length<9){
                            Fluttertoast.showToast(
                                msg: "يجب عليك إدخال رقم الجوال",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Color(0xff38056e).withOpacity(0.9),
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            setState(() {
                              isLouding=false;
                            });
                          }else{
                            setState(() {
                              isLouding=true;
                            });
                            try
                            {await  getUserHasAccount();
                            }catch(e){
                              setState(() {
                                isLouding=false;
                              });
                            }
                            if(!userHasAccount){
                              print(message);
                              if(phoneNumber.length<9){
                                print("22");
                                Fluttertoast.showToast(
                                    msg: " يجب عليك إدخال رقم الجوال صحيح",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Color(0xff38056e).withOpacity(0.9),
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );

                              }else
                              {

                                if(!isverifyPhoneNumbe)
                                {
                                  setState(() {
                                    isverifyPhoneNumbe=false;
                                  });
                             await  phoneNumber == null ? null : verfiyPhone();
                                 // await  Navigator.push(context, new MaterialPageRoute(builder: (context)=>  ActivateCode(otp,verificationId,phoneNumber,code)));
                                  setState(() {
                                    isLouding=false;
                                  });
                                }else{

                                }

                              }
                              // Navigator.push(context, new MaterialPageRoute(builder: (context)=>  CreateAccount(phoneNumber,code)));
                            }
                            else
                         {
                           if(isReservation){
                             // url ='sms:+972594102511?body=2222';
                             // await launch(url);
                             await HelperFunctions.saveUserMobileSharedPreference(phoneNumber);
                             await   Navigator.popAndPushNamed(context, '/login');
                            // await   Navigator.push(context, new MaterialPageRoute(builder: (context)=>  login(phoneNumber,isReservation)));

                           }else{
                             // url ='sms:+972594102511?body=2222';
                             // await launch(url);
                             await HelperFunctions.saveUserMobileSharedPreference(phoneNumber);
                             await   Navigator.push(context, new MaterialPageRoute(builder: (context)=>  login(phoneNumber,isReservation,false)));

                           }
                         }



                            setState(() {
                              isLouding=false;
                            });
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
                              translator.translate('Login'),
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
                onTap: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (context)=>  Home()));
                },//Navigator.push(context, new MaterialPageRoute(builder: (context)=>  Home())),
                  child: new Text(
                    translator.translate('Browse the application without registering'),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color:Color(0xff38056e),
                    ),
                  ),
                ),
          Container(height:MediaQuery.of(context).size.height*.05 ,),
                InkWell(
                  onTap: (){
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
                    height:MediaQuery.of(context).size.height*.1 ,
                    alignment: Alignment.bottomCenter,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          new Text(
                            translator.translate('Change to English'),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: "DIN Next LT Arabic",fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color:Color(0xff38056e),
                            ),
                          ),
                          Image.asset('Assets/Group 39810.png'),
                        ],
                      )
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  var url;
  getUserHasAccount() async {
   // networkRequest.OffersGetPaged();
    await  networkRequest.UserHasAccount(phoneNumber).then((value){
      setState(() {
        userHasAccount  = value['data']['hasAccount'];
        code=value['data']['code'];
        message=value['message'];
        print(value['message']);
      });
    });
  }

  Future<void> verfiyPhone() async{
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId){
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent= (String verId, [int forceCodeResent]) {
      this.verificationId = verId;
      setState(() {
        codeScreen=true;
      //  authStatus = "OTP has been successfully send";
      });
      // smsCodeDialoge(context).then((value){
      //   print("Code Sent");
      // });
    };
    final PhoneVerificationCompleted verifiedSuccess= (AuthCredential auth){};
    final PhoneVerificationFailed verifyFailed= (AuthException e){
      print('${e.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 5),
      verificationCompleted : verifiedSuccess,
      verificationFailed: verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,

    );

  }
  Future<void> verifyPhoneNumber2(BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 15),
      verificationCompleted: (AuthCredential authCredential) {
        FirebaseAuth.instance.signInWithCredential(authCredential).then((AuthResult result){
print(result);
print("result");
          // Navigator.pushReplacement(context, MaterialPageRoute(
          //     builder: (context) =>  CreateAccount(phoneNumber, code)));
        }).catchError((e) {
          Fluttertoast.showToast(
              msg: "Authentication failed ",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Color(0xff38056e).withOpacity(0.9),
              textColor: Colors.white,
              fontSize: 16.0
          );
          return "error";
        });

//        Navigator.pushReplacement(context, MaterialPageRoute(
//            builder: (context) => Home_Screen()//ChatRoom()
//        ));
        setState(() {
          authStatus = "Your account is successfully verified";
        });
        print(authStatus);
      },
      verificationFailed: (AuthException authException) {
        setState(() {
          authStatus = "Authentication failed";
        });
        Fluttertoast.showToast(
            msg: "Authentication failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xff38056e).withOpacity(0.9),
            textColor: Colors.white,
            fontSize: 16.0
        );
      },
      codeSent: (String verId, [int forceCodeResent]) {
        verificationId = verId;
        print(verId);
        print("verId");
        setState(() {
          codeScreen=true;
          authStatus = "OTP has been successfully send";
        });
        print(authStatus);
      //  otpDialogBox(context).then((value) {});
      },
      codeAutoRetrievalTimeout: (String verId) {
        print(verId);
        verificationId = verId;
        setState(() {
          authStatus = "TIMEOUT";
        });
        Fluttertoast.showToast(
            msg: "TIMEOUT send new messege",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xff38056e).withOpacity(0.9),
            textColor: Colors.white,
            fontSize: 16.0
        );
        print(authStatus);
      },


    );
  }
  Future<void> signIn(String otp) async {
    print(otp);
    print("otp");
    try
    {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: otp,
      ));
    }catch(v){
      Fluttertoast.showToast(
          msg: "ادخل كود صحيح",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff38056e).withOpacity(0.9),
          textColor: Colors.white,
          fontSize: 16.0
      );

    }
  }
  Future<void> signIn2(String smsCode) async{
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,);

    await FirebaseAuth.instance.signInWithCredential(
        credential).then((user) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => CreateAccount(phoneNumber, code),),
      );
    }).catchError((e){
      Fluttertoast.showToast(
          msg: "ادخل كود صحيح",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff38056e).withOpacity(0.9),
          textColor: Colors.white,
          fontSize: 16.0
      );
      print(e);
    });
  }

  bool userHasAccount;
  var code;
  var message;
}
