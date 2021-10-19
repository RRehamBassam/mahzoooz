import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:mahzoooz/api/NetworkRequest.dart';
import 'package:mahzoooz/Screen/Home.dart';
import 'package:mahzoooz/Widget/test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mahzoooz/Screen/Auth/ActivateCode.dart';
import 'package:mahzoooz/services/helperFunctions.dart';
import 'package:the_validator/the_validator.dart';
class CreateAccount extends StatefulWidget {
  String phone;
 var code;

  CreateAccount(this.phone, this.code);

  @override
  _CreateAccountState createState() => _CreateAccountState(phone,code);
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController _controllerCitiy = new TextEditingController();
  TextEditingController _controllerD = new TextEditingController();
  TextEditingController _controllerName = new TextEditingController();
  TextEditingController _controllerEmail = new TextEditingController();
  TextEditingController _controllerPass = new TextEditingController();
  TextEditingController _controllerCpass = new TextEditingController();
  TextEditingController _controllerG = new TextEditingController();
  String emailRegExp =
      "[a-z0-9!#\$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#\$%&'*+\/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9][a-zA-Z0-9-]{0,253}\.)*[a-zA-Z0-9][a-zA-Z0-9-]{0,253}\.[a-zA-Z0-9]{2,}\$";
  String passwordRegExp = "[a-z0-9_@-A-Z]{6,16}\$";
  String nameRegExp = "^[a-zA-Z]{2,16}[\\s\\\][a-zA-Z]{2,16}\$";
  String phoneRegExp = "^(009665|9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})\$";

  String phoneNumber;
  var generatedCode;
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
 int countryId=0;
  var base64Image;
  String otp, authStatus = "";
  bool  _obscureText;
  bool  _obscureText2;
bool ee=false;
bool eeName=false;
  bool eeD=false;
  bool eeCitiy=false;
  bool eeEmail=false;
  bool eeCpass=false;
  bool eepass=false;
  bool eeG=false;

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
        //Navigator.push(context, new MaterialPageRoute(builder: (context)=>  ActivateCode(otp,verificationId)));
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
  _CreateAccountState(this.phoneNumber, this.generatedCode);
  final String url = "http://ahmed453160-001-site1.etempurl.com/Countries/GetAll";

  List data =[]; //edited line
  List dataG =["ذكر","أنثى"];

  Future<String> getSWData() async {
    var res = await http
        .get(Uri.parse(Uri.encodeFull(url)), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    print(resBody);
    setState(() {
      data = resBody['data'];
    });
    print(data);

    return "Sucess";
  }
  String city;
  String name;String password;String confirmPassword;String email;
  int gender;var birthDate;
  NetworkRequest networkRequest=new NetworkRequest();
  @override
  void initState() {
    _obscureText = true;
    _obscureText2 = true;
    super.initState();
    this.getSWData();
  }

  var _blankFocusNode = new FocusNode();
  var focusNode = new FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
     // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading:  InkWell(
          onTap:(){
            Navigator.pop(context);
          },
          child: Container(
            // margin: EdgeInsets.all(8),
              child: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Color(0xFFFEFEFE),
        title: new Text(
        translator.translate( "انشاء حساب"),
          textAlign: TextAlign.center,
          style: TextStyle(
           fontWeight: FontWeight.w700,
            fontSize: 14,
            color:Color(0xff747474),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              test((v){
                setState(() {
                  base64Image=v;
                });

              }),
              // new Container(
              //   height: 88.00,
              //   width: 90.00,
              //   decoration: BoxDecoration(
              //     color: Color(0xffe5e5e5),
              //     border: Border.all(width: 1.00, color: Color(0xffd9d9d9),), borderRadius: BorderRadius.circular(8.00),
              //   ),
              // ),

              SizedBox(height: 10,),
              Container(
                height:ee? MediaQuery.of(context).size.height< 743.4285714285714?MediaQuery.of(context).size.height*0.76: MediaQuery.of(context).size.height*0.76

                    : MediaQuery.of(context).size.height*0.52,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textFiled("الإسم",(val)=>setState(()=>name=val),_controllerName),
                      textFiled("البريد الإلكتروني",(val)=>setState(()=>email=val),_controllerEmail),
                      textFiled("كلمة المرور",(val)=>setState(()=>password=val),_controllerPass),
                      textFiled("تأكيد كلمة المرور",(val)=>setState(()=>confirmPassword=val),_controllerCpass),
                      textFiled("النوع",(val)=>setState(()=>gender=val),_controllerG),
                      textFiled("تاريخ الميلاد",(val)=>setState(()=>birthDate=val),_controllerD),
                      textFiled("الدولة",(val)=>setState(()=>city=val),_controllerCitiy),
                    ],
                  ),

                ),
              ),
          Container(
            height: MediaQuery.of(context).size.height*0.2,
           child: Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: ()async{

                      if (_formKey.currentState.validate()) {
                        await  getUserHasAccount();
                        if(message=="Rigisterd Successfully"){
                         // Navigator.push(context, new MaterialPageRoute(builder: (context)=>  Home()));
                          // phoneNumber == null ? null : verifyPhoneNumber(context);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text( translator.translate('Processing Data'))));
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (_){
                                return  Home();
                              }),(route)=> false
                          );
                        }
                        // If the form is valid, display a Snackbar.

                      }else{
                   await  getUserHasAccount();
                      if(message=="Rigisterd Successfully"){
                       Navigator.push(context, new MaterialPageRoute(builder: (context)=>  Home()));
                       // phoneNumber == null ? null : verifyPhoneNumber(context);
                      }}
                      // networkRequest.Register( name, password, confirmPassword, email, phone,
                      //      gender, birthDate, generatedCode);
                    },
                    child: new Container(
                        height: 48.00,
                        width: 311.00,
                        decoration: BoxDecoration(
                          color: Color(0xff38056e),borderRadius: BorderRadius.circular(25.00),
                        ),
                        child:Center(
                          child: new Text(
                            translator.translate("إنشاء حساب"),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color:Color(0xffffffff),
                            ), // new Text(
                            //   "بمجرد الضغط علي انشاء الحساب انت توافق علي الشروط و الاحكام",
                            //   textAlign: TextAlign.right,
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.w500,
                            //     fontSize: 9,
                            //     color:Color(0xff909090),
                            //   ),
                            // )
                          ),
                        )
                    ),
                  ),
                  SizedBox(height: 16,),


                ],
              ),
           )
          )
            ],
          ),
        ),
      ),
    );
  }


  Widget textFiled(String text,onChanged, TextEditingController controller){
    bool init=false;  bool error;
    if(init==false){
      error=false;
    }
print(error);
    return Container(
      width:error?MediaQuery.of(context).size.width*0.965: MediaQuery.of(context).size.width*0.815,
      height:ee||eeName||eepass||eeEmail||eeCpass? MediaQuery.of(context).size.height*0.108: MediaQuery.of(context).size.height*0.062,
      child: TextFormField(//onChanged: (val)=>setState((){searchWord=val;}),
        cursorColor: Color(0xff38056e),
        keyboardType:TextInputType.text,
        autofocus: false,
        textAlign:translator.currentLanguage == 'ar' ? TextAlign.right:TextAlign.left,//(val)=>setState(()=>Name=val)
         onChanged:onChanged ,
        controller:controller ,
       // obscureText: false,
        obscureText:text=="كلمة المرور"? _obscureText:text=="تأكيد كلمة المرور"?_obscureText2:false,
        onTap:(){
         if (text=="الدولة"|| text=="النوع"||text=="تاريخ الميلاد")
    {
      FocusScope.of(context).requestFocus(_blankFocusNode);

      FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus.unfocus();}

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
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child:text=="الدولة"? BottomSheetExample(context):text=="تاريخ الميلاد"?BottomSheetExampleDate(context):BottomSheetExampleG(context),
              ),
            ),
          );}
        },

        validator:text=="تأكيد كلمة المرور"?(value){
          if(value==password){
            return null;
          }else
            return translator.translate("يجب ان تتطابق مع كلمة المرور");
          }: text=="البريد الإلكتروني"?
            (value){ value = value.trim();
          RegExp regExp2 = new RegExp(emailRegExp);
        if (value.isEmpty) {
        // The form is empty
        return translator.translate("please enter email");
        }
        if (regExp2.hasMatch(value)) {
          eeEmail=false;
          setState(() {

          });
        // So, the email is valid
        return null;
        }
            eeEmail=true;
        setState(() {

        });
        // The pattern of the email didn't match the regex above.
        return translator.translate( "email incorrect");}:text=="كلمة المرور"||text=="تأكيد كلمة المرور"? FieldValidator.password(
          minLength: 6,
          // shouldContainNumber: true,
          // shouldContainCapitalLetter: true,
          // shouldContainSpecialChars: true,
         errorMessage:text=="كلمة المرور"? "كلمة المرور يجب ان تتكون من 6 أرقام اوحروف " :"يجب ان تتطابق مع كلمة المرور",
          // onNumberNotPresent: () { return "$text must contain number"; },
          // onSpecialCharsNotPresent: () { return "$text must contain special characters"; },
          // onCapitalLetterNotPresent: () { return "$text must contain capital letters"; }

    ):(value) {
          if (value.isEmpty) {
            setState(() {
              if(text=="الإسم"){eeName=true;}
              if(text=="البريد اإلكتروني"){
                eeEmail=true;
              }
              if(text=="كلمة المرور"){
                eepass=true;
              }
              if(text=="تأكيد كلمة المرور"){
                eeCpass=true;
              }
              if(text=="النوع"){
                eeG=true;
              }
              if(text=="الدولة"){
                eeCitiy=true;
              }
              ee=true;
              init=true;
              error=true;
            });
            error=true;
            return "$text غير صحيحة " ;
          }else
         { setState(() {
           if(text=="الإسم"){eeName=false;}
           if(text=="البريد اإلكتروني"){
             eeEmail=false;
           }
           if(text=="كلمة المرور"){
             eepass=false;
           }
           if(text=="تأكيد كلمة المرور"){
             eepass=false;
           }
           if(text=="النوع"){
             eeG=false;
           }
           if(text=="الدولة"){
             eeCitiy=false;
           }
            init=true;
            error=false;
            if(eeEmail ||eepass||eepass||eeG||eeCitiy||eeName){
              ee==true;
            }else
          {  ee=false;}
          });

          return null;}
        },

        decoration: InputDecoration(

              suffixIcon:text=="كلمة المرور"? new InkWell(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Container(
                      margin:EdgeInsets.symmetric(horizontal: 5) ,
                      child: Icon(_obscureText? Icons.visibility_off: Icons.visibility ))):text=="تأكيد كلمة المرور"? new InkWell(
                  onTap: () {
                    setState(() {
                      _obscureText2 = !_obscureText2;
                    });
                  },
                  child: Container(
                      margin:EdgeInsets.symmetric(horizontal: 5) ,
                      child: Icon(!_obscureText2? Icons.visibility : Icons.visibility_off))): Icon(Icons.arrow_drop_down,color:text=="الدولة"|| text=="النوع"||text=="تاريخ الميلاد"?Colors.grey[300]: Color(0x0ffff),),
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

            hintText:translator.translate(text),


            // icon:tajerAccount?Image.asset("Assets/icon-store.png",color:Color(0xfff99b1d),):Image.asset("Assets/icon-account.png") ,
            hintStyle: TextStyle(
             fontWeight: FontWeight.w500,
              fontSize: 12,
              color:Color(0xff5e5e5e).withOpacity(0.48),
            ),
            labelStyle: null
        ),

      ),
    );
  }
   BottomSheetExample(context){
    return
        Container(
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
            Center(
              child:  Text(
                translator.translate("اختر الدولة"),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Tajawal",fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color:Color(0xff3d3b39),
                ),
              ),
            ),
            Container(
              height:170,
              width: 90,
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(top: 16, bottom: 40),
              color: Colors.white,
              child: ListWheelScrollView(
                  itemExtent: 50,
                  diameterRatio: 1.2,
                  offAxisFraction: -0.4,
                  squeeze: 0.8,
                  // clipToSize: true
                  //  itemExtent: 40,
                  useMagnifier: true,
                onSelectedItemChanged: (int){
                  {setState(()=>{
                  if(translator.currentLanguage == 'ar')
                    {
                                _controllerCitiy.text = data[int]['nameAr'],
                                city = data[int]['nameAr'],
                                countryId = data[int]['id']
                              }else{
                    _controllerCitiy.text = data[int]['nameEn'],
                    city = data[int]['nameEn'],
                    countryId = data[int]['id']
                  }
                          });}
                  HelperFunctions.saveUserAddressSharedPreference(data[int]['nameAr']);
                   },
                  // diameterRatio: 1.6,
                  children: <Widget>[
                    ...data.map((name) {
                      print(name['nameAr']);
                      return InkWell(
                        onTap: ()=>{setState(()=>{
                          if(translator.currentLanguage == 'ar')
                            {
                                    _controllerCitiy.text = name['nameAr'],
                                    city = name['nameAr'],
                                    countryId = name['id']
                                  }else{
                            _controllerCitiy.text = name['nameEn'],
                            city = name['nameEn'],
                            countryId = name['id']
                          }
                              }),},
                        child: Container(
                          width: double.infinity,

                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 1, color: Colors.black12)),
                          padding: EdgeInsets.all(5),
                          margin:EdgeInsets.all(3) ,
                          child: Center(
                            child: Text(translator.currentLanguage == 'ar' ? name['nameAr']:name['nameEn'],
                                style: TextStyle(
                                  fontFamily: "Tajawal",fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color:Color(0xff3d3b39),
                                )),
                          ),
                        ),
                      );
                    })
                  ]),
            ),
            InkWell(
              onTap:()=> Navigator.pop(context),
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
    );
  }
  DateTime _chosenDateTime;

  // Show the modal that contains the CupertinoDatePicker
  void _showDatePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
          height: 500,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Container(
                height: 400,
                child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (val) {
                      setState(() {
                        _chosenDateTime = val;
                      });
                    }),
              ),

              // Close the modal
              CupertinoButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(ctx).pop(),
              )
            ],
          ),
        ));}
  BottomSheetExampleG(context){
    return
      Container(
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
              Center(
                child:  Text(
                  translator.translate( "اختر النوع"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Tajawal",fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color:Color(0xff3d3b39),
                  ),
                ),
              ),
              Container(
                height:170,
                width: 90,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(top: 16, bottom: 40),
                color: Colors.white,
                child: ListWheelScrollView(
                    itemExtent: 50,
                    diameterRatio: 1.2,
                    offAxisFraction: -0.4,
                    squeeze: 0.8,
                    // clipToSize: true
                    //  itemExtent: 40,
                    useMagnifier: true,
                    onSelectedItemChanged: (int){
                      {setState(()=>{_controllerG.text=translator.translate(dataG[int]),gender=int+1});}
                       },
                    // diameterRatio: 1.6,
                    children: <Widget>[
                      ...dataG.map<Widget>((name) {
                      //  print(name['nameAr']);
                        return InkWell(
                        onTap: ()=>{setState(()=>{_controllerG.text=translator.translate(name)}),},
                          child: Container(
                            width: double.infinity,

                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 1, color: Colors.black12)),
                            padding: EdgeInsets.all(5),
                            margin:EdgeInsets.all(3) ,
                            child: Center(
                              child: Text(  translator.translate(name),
                                  style: TextStyle(
                                    fontFamily: "Tajawal",fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color:Color(0xff3d3b39),
                                  )),
                            ),
                          ),
                        );
                      })
                    ]),
              ),
              GestureDetector(
                 onTap:()=> {
                   print("ooo"),
                   Navigator.pop(context)},
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
      );
  }
  BottomSheetExampleDate(context){
    return
      Container(
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
              Center(
                child:  Text(
                  "تاريخ الميلاد",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Tajawal",fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color:Color(0xff3d3b39),
                  ),
                ),
              ),
              Container(

                height:200,
                width: 90,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(top: 16, bottom: 16),
                child: CupertinoDatePicker(
                  
                  maximumDate:DateTime(2021, 1, 1) ,
                  minimumDate:DateTime(1950, 1, 1) ,
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime(2021, 1, 1),
                  onDateTimeChanged: (DateTime newDateTime) {
                    DateFormat formatter = DateFormat('yyyy-MM-dd');
                    setState(() {
                      _chosenDateTime=newDateTime;birthDate="${formatter.format(newDateTime).split(" ")[0]}";
                      _controllerD.text="${formatter.format(newDateTime).split(" ")[0]}";
                    });
                    // Do something
                  },
                ),
              ),
              GestureDetector(
                onTap:()=> {
                  print("ooo"),
                  Navigator.pop(context)},
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
      );
  }
  getUserHasAccount() async {

    await  networkRequest.Register( name, password, confirmPassword, email, phoneNumber,
        gender, birthDate, generatedCode,base64Image,countryId).then((value){
      setState(() {
        message  = value;

      });
    });
  }
  String message;
}
