//editProfile
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahzoooz/api/NetworkRequest.dart';
import 'package:mahzoooz/Screen/Home.dart';
import 'package:mahzoooz/Widget/test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mahzoooz/Screen/Auth/ActivateCode.dart';
import 'package:mahzoooz/services/helperFunctions.dart';
import 'package:mahzoooz/services/providerUser.dart';
import 'package:provider/provider.dart';
import 'package:the_validator/the_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class editProfile extends StatefulWidget {
 var UserName;
var UserEmile;
 var userMobile;
 var gender;
 var city;
 var date;
var phoneNumber;
var add;

 editProfile(this.UserName, this.UserEmile, this.userMobile,this.gender,this.city,this.date,this.phoneNumber,this.add);

 // editProfile();

  @override
  _editProfileState createState() => _editProfileState(UserName,UserEmile,userMobile,gender,city,date,phoneNumber,add);
}

class _editProfileState extends State<editProfile> {
  var UserName;
  var UserEmile;
  var genderInt;
  var cityInt;
  var dateInt;
  var phoneNumber;
  var add;
  _editProfileState(this.UserName,this.UserEmile,this.userMobile,this.genderInt,this.cityInt,this.dateInt,this.phoneNumber,this.add);

  var userMobile;


  // String phoneNumber;
  // var generatedCode;
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  int countryId=0;
  String base64Image;
  String otp, authStatus = "";
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

    );
  }

  final String url = "http://ahmed453160-001-site1.etempurl.com/Countries/GetAll";

  List data =[]; //edited line
  List dataG =["ذكر","أنثى"];
  Future<String> getSWData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    print(resBody);
    setState(() {
      data = resBody['data'];
    });
    for(int i;i<data.length;i++){
      if(data[i]['id']==cityInt)
        setState(() {
          _controllerCitiy=new TextEditingController(text:data[i]['nameAr']);
        });

    };
    print(data);

    return "Sucess";
  }
  TextEditingController _controllerCitiy = new TextEditingController();
  TextEditingController _controllerD = new TextEditingController();
  TextEditingController _controllerName = new TextEditingController();
  TextEditingController _controllerEmail = new TextEditingController();
  TextEditingController _controllerPass = new TextEditingController();
  TextEditingController _controllerCpass = new TextEditingController();
  TextEditingController _controllerG = new TextEditingController();
  String city;
  String name;String password;String confirmPassword;String email;
  int gender;var birthDate;
  NetworkRequest networkRequest=new NetworkRequest();
  var Address;
  void getAddress()async{
    await HelperFunctions.getUserAddressSharedPreference().then((value){
      Address  = value ;
    });
  }
  @override
  void initState() {
    getAddress();
    name=UserName;
    email=UserEmile;
    birthDate=dateInt.toString();
   gender=1;

    super.initState();
    this.getSWData();
  }

  var _blankFocusNode = new FocusNode();
  var focusNode = new FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _controllerName=new TextEditingController(text: UserName);
    _controllerEmail=new TextEditingController(text: UserEmile);
    _controllerG=new TextEditingController(text:genderInt==1?"ذكر":"أنثى");
    _controllerCitiy=new TextEditingController(text:add);
    _controllerD=new TextEditingController(text:dateInt);
    String nameUser =
        Provider.of<providerUser>(context, listen: true).name;
    // String mobileUser =
    //     Provider.of<providerUser>(context, listen: true).mobile;
    String emailUser =
        Provider.of<providerUser>(context, listen: true).email;
    return Scaffold(
     // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Color(0xFFFEFEFE),
        title: new Text(
          "انشاء حساب",
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
                      textFiled("الإسم",(val)=>setState(()=>name=val,),_controllerName,UserName),
                      textFiled("البريد الإلكتروني",(val)=>setState(()=>email=val),_controllerEmail,UserEmile),
                      textFiled("كلمة المرور",(val)=>setState(()=>password=val),_controllerPass,null),
                      textFiled("تأكيد كلمة المرور",(val)=>setState(()=>confirmPassword=val),_controllerCpass,null),
                      textFiled("النوع",(val)=>setState(()=>gender=val),_controllerG,genderInt==1?"ذكر":"أنثى"),
                      textFiled("تاريخ الميلاد",(val)=>setState(()=>birthDate=val),_controllerD,dateInt),
                      textFiled("الدولة",(val)=>setState(()=>city=val),_controllerCitiy,null),
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
                              if(message=="Data Updated Successfully"){
                                Fluttertoast.showToast(
                                    msg: message,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Color(0xff38056e).withOpacity(0.9),
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                                Navigator.pop(context);
                               // Navigator.push(context, new MaterialPageRoute(builder: (context)=>  Home()));
                                // phoneNumber == null ? null : verifyPhoneNumber(context);
                              }else{
                                Fluttertoast.showToast(
                                    msg: message,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Color(0xff38056e).withOpacity(0.9),
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }
                              // If the form is valid, display a Snackbar.
                              // ScaffoldMessenger.of(context)
                              //     .showSnackBar(SnackBar(content: Text('Processing Data')));
                            }else{
                              await  getUserHasAccount();
                              if(message=="Data Updated Successfully"){
                                Fluttertoast.showToast(
                                    msg: message,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Color(0xff38056e).withOpacity(0.9),
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                                Navigator.pop(context);
                             //   Navigator.push(context, new MaterialPageRoute(builder: (context)=>  Home()));
                                // phoneNumber == null ? null : verifyPhoneNumber(context);
                              }else{
                                Fluttertoast.showToast(
                                    msg: message,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Color(0xff38056e).withOpacity(0.9),
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }
                            }
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
                                  "تعديل الملف الشخصي",
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
                        SizedBox(height: 16,),
                        new Text(
                          "بمجرد الضغط علي انشاء الحساب انت توافق علي الشروط و الاحكام",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 9,
                            color:Color(0xff909090),
                          ),
                        )

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
  Widget textFiled(String text,onChanged, TextEditingController controller,initialValue){
    bool init=false;  bool error;
    if(init==false){
      error=false;
    }
    print(error);
    return Container(
      width:error?MediaQuery.of(context).size.width*0.965: MediaQuery.of(context).size.width*0.815,
      height:ee? MediaQuery.of(context).size.height*0.108: MediaQuery.of(context).size.height*0.062,
      child: TextFormField(//onChanged: (val)=>setState((){searchWord=val;}),
        cursorColor: Color(0xff38056e),
        keyboardType:TextInputType.text,
        autofocus: false,
        textAlign: TextAlign.right,//(val)=>setState(()=>Name=val)
        onChanged:onChanged ,
        controller:text=="الدولة" ?controller :null,
        obscureText: false,
        initialValue: initialValue,

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
        validator:text=="كلمة المرور"|| text=="تأكيد كلمة المرور"? FieldValidator.password(
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


       // initialValue:initialValue ,
        decoration: InputDecoration(
            suffixIcon: Icon(Icons.arrow_drop_down,color:text=="الدولة"|| text=="النوع"||text=="تاريخ الميلاد"?Colors.grey[300]: Color(0x0ffff),),
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

            hintText:text,

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
                  "اختر الدولة",
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
                      {setState(()=>{_controllerCitiy.text=data[int]['nameAr'],city=data[int]['nameAr'],countryId=data[int]['id']});}
                    },
                    // diameterRatio: 1.6,
                    children: <Widget>[
                      ...data.map((name) {
                        print(name['nameAr']);
                        return InkWell(
                         onTap: ()=>{setState(()=>{_controllerCitiy.text=name['nameAr'],city=name['nameAr'],countryId=name['id']}),},
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
                              child: Text(name['nameAr'],
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
                      "حفظ",
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
                  "اختر النوع",
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
                      {setState(()=>{_controllerG.text=dataG[int],gender==int+1});}
                    },
                    // diameterRatio: 1.6,
                    children: <Widget>[
                      ...dataG.map<Widget>((name) {
                        //  print(name['nameAr']);
                        return InkWell(
                         onTap: ()=>{setState(()=>{_controllerG.text=name,}),},
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
                              child: Text(name,
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
                      "حفظ",
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
                      "حفظ",
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
    await  networkRequest.UpdateUserProfile( name, password, confirmPassword, email, phoneNumber,
        gender, birthDate,base64Image,countryId).then((value){
      setState(() {
        message  = value;

      });
    });
  }
  String message;
}
