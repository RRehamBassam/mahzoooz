import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:mahzoooz/api/NetworkRequest.dart';
import 'package:http/http.dart' as http;
import 'package:mahzoooz/services/helperFunctions.dart';
import 'dart:convert';
import 'dart:ui';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
class CouponDiscount extends StatefulWidget {
  var datapath;
  var databranches;

  CouponDiscount(this.datapath,this.databranches);

  @override
  _CouponDiscountState createState() => _CouponDiscountState(datapath,databranches);
}

class _CouponDiscountState extends State<CouponDiscount> {
  var datapath;
  var databranches;
  _CouponDiscountState(this.datapath,this.databranches);

  NetworkRequest networkRequest=new NetworkRequest();
  var id;
var newStudentsName;
  var newStudentsid;
  var newStudentsNameid;
  @override
  void initState() {
    super.initState();
    this.getSWData(datapath['schoolType']);
    StudentsData=[];
    StudentsDataApi=[];
  }
  var StudentsData=List<Students>();
  var StudentsDataApi=List<Map<String, dynamic>>();
  List data =[]; //edited line
var token;
  Future<String> getSWData(id) async {
    await HelperFunctions.getUserEmailSharedPreference().then((value){
      token  = value ;
    });
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    var itemCount ;
    HttpClientRequest request = await client.getUrl(Uri.parse("http://ahmed453160-001-site1.etempurl.com/SchoolStages/GetAllStagesBySchoolType/$id"));
    request.headers.set('content-type', 'application/json');
   // request.headers.set('content-type', 'application/json');
    request.headers.set('Authorization', 'Bearer $token');
    // request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print(response.statusCode);
    print(reply);
    var jsonResponse = convert.jsonDecode(reply);

    //return jsonResponse['data'];
    // var res = await http
    //     .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    // var resBody = json.decode(res.body);
    // print(resBody);
    setState(() {
      data = jsonResponse['data'];
      newStudentsid==data[0]["id"];
      newStudentsNameid=data[0]["nameAr"];
    });
    print(data);

    return "Sucess";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios,color:Color(0xff38056e))),
        toolbarHeight: 65,
        elevation: 1,
        backgroundColor: Colors.white,
        title:new Text(
          translator.currentLanguage == 'ar' ?"كوبون الخصم":"Discount Coupon", //data['providerNameAr'] ==null? "مطاعم البيك السعودية":translator.currentLanguage == 'ar' ? data['providerNameAr']:data['providerNameEn'],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color:Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body:    Container( width: MediaQuery.of(context).size.width,
        margin:EdgeInsets.all(16)  ,
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,

            children: [

    Align(
    //   heightFactor: 0.7,
    alignment: Alignment.topCenter,
    child:Container(
    margin: EdgeInsets.only(bottom: 8,top: 2),
    decoration: BoxDecoration(

    borderRadius: BorderRadius.circular(10.0),),
    child: Material(
    elevation: 1,
    borderRadius: BorderRadius.circular(10.0),
    child: Container(
      padding: EdgeInsets.all(11),
    decoration: BoxDecoration(
color: Colors.white,
    borderRadius: BorderRadius.circular(10.0),),
   child:   Container(
     height: MediaQuery.of(context).size.height*0.08,
     child:Column(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
           SizedBox(
             width: MediaQuery.of(context).size.width,
             child: Text(translator.currentLanguage == 'ar' ?"المدرسة":"school",//textDirection: TextDirection.rtl,
               style: TextStyle(fontWeight:FontWeight.w700,fontSize: 19,color:Colors.black ,),
             ),
           ),
           // Container(
           //   width: MediaQuery.of(context).size.width*0.815,
           //   height: MediaQuery.of(context).size.height*0.032,
           //   child: TextFormField(//onChanged: (val)=>setState((){searchWord=val;}),
           //     cursorColor: Color(0xff38056e),
           //     keyboardType:TextInputType.text,
           //     autofocus: false,
           //     textAlign: TextAlign.right,//(val)=>setState(()=>Name=val)
           //     // onChanged:onChanged ,
           //     // controller:controller ,
           //     obscureText: false,
           //
           //
           //
           //     decoration: InputDecoration(
           //         //suffixIcon: Icon(Icons.arrow_drop_down,color:text=="الدولة"|| text=="النوع"||text=="تاريخ الميلاد"?Colors.grey[300]: Color(0x0ffff),),
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
           //         hintText:'أدخل اسم المدرسة',
           //
           //         // icon:tajerAccount?Image.asset("Assets/icon-store.png",color:Color(0xfff99b1d),):Image.asset("Assets/icon-account.png") ,
           //         hintStyle: TextStyle(
           //           fontWeight: FontWeight.w500,
           //           fontSize: 12,
           //           color:Color(0xff5e5e5e).withOpacity(0.48),
           //         ),
           //         labelStyle: null
           //     ),
           //
           //   ),
           // ),
           SizedBox(
             width: MediaQuery.of(context).size.width,
             child: Text(translator.currentLanguage == 'ar' ?datapath['providerNameAr']:datapath['providerNameEn'],
               style: TextStyle(fontWeight:FontWeight.w600,fontSize: 18,color:Color(0xff38056e) ),
             ),
           ),
       ],
     ) ,
   ),
          )))),
              Align(
                //   heightFactor: 0.7,
                  alignment: Alignment.topCenter,
                  child:Container(
                      margin: EdgeInsets.only(bottom: 8,top: 2),
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(10.0),),
                      child: Material(
                          elevation: 1,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            padding: EdgeInsets.all(11),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),),
                           child:   Container(
  width:MediaQuery.of(context).size.width ,
  height: MediaQuery.of(context).size.height*0.15+StudentsData.length*MediaQuery.of(context).size.height*0.03,
  child:Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(translator.currentLanguage == 'ar' ?"بيانات الأبناء":"Children's data",
          style: TextStyle(fontWeight:FontWeight.w700,fontSize: 18,color:Colors.black ),
      ),
      Container(
          // height: MediaQuery.of(context).size.height,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount:StudentsData.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return childs(StudentsData[index].name,StudentsData[index].schoolStageId,StudentsData[index].schoolStageIdname,index);
              }),
      ),
      Center(
          child: InkWell(
            onTap: ()async{
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
                    child: BottomSheetExample(context),
                  ),
                ),
              );
            },
            child: new Container(
                height: 38.00,
                width:168.00,
                decoration: BoxDecoration(
                  color: Color(0xff38056e),borderRadius: BorderRadius.circular(25.00),
                ),
                child:Center(
                  child: new Text(
                    translator.currentLanguage == 'ar' ? "اضف بيانات ابن جديد":"Add a new son's data",
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
      ),
      // Text(translator.translate("مدرسة فاطمة العالمية"),
      //   style: TextStyle(fontWeight:FontWeight.w700,fontSize: 20,color:Colors.black ),
      // ),
    ],
  ) ,
),
                          )))),
    Align(
    //   heightFactor: 0.7,
    alignment: Alignment.topCenter,
    child:Container(
    margin: EdgeInsets.only(bottom: 8,top: 2),
    decoration: BoxDecoration(

    borderRadius: BorderRadius.circular(10.0),),
    child: Material(
    elevation: 1,
    borderRadius: BorderRadius.circular(10.0),
    child: Container(
    padding: EdgeInsets.all(11),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.0),),
    child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Container(
           width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.13,
            child:Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height:16,),
                Text(translator.currentLanguage == 'ar' ?"تفاصيل الخصم":"Discount Details",
                  style: TextStyle(fontWeight:FontWeight.w700,fontSize: 18,color:Colors.black ),
                ),
                SizedBox(height: 8,),
                Text(translator.currentLanguage == 'ar' ?datapath['titeAr']:datapath['titleEn'],
                  style: TextStyle(fontWeight:FontWeight.w600,fontSize: 18,color:Color(0xff38056e) ),
                ),
              ],
            ) ,
          ),
          Container(
              width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.1,
            child:Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(translator.currentLanguage == 'ar' ?"صالح لغاية":"valid up to",
                    style: TextStyle(fontWeight:FontWeight.w700,fontSize: 18,color:Colors.black ),
                  ),
                ),
                SizedBox(height: 8,),
                Container
                  (width: MediaQuery.of(context).size.width,
                  child: Text(translator.translate( datapath['offerExpireDate'].toString().split('T')[0]),
                    style: TextStyle(fontWeight:FontWeight.w500,fontSize: 18,color:Color(0xff38056e) ),
                  ),
                ),
              ],
            ) ,
          ),
      ],
    ),)))),


              SizedBox(height: 16,),
              StudentsData.length==0?SizedBox():  Center(
                child: InkWell(
                  onTap: ()async{
                    await getLoggedInState(datapath['offerExpireDate'],datapath['id']);
                    if(result=='Created'){
                      Fluttertoast.showToast(
                          msg: "تم الحصول على كوبون الخصم للمدرسة",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color(0xff38056e).withOpacity(0.9),
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      Navigator.pop(context);
                    }else{
                      Fluttertoast.showToast(
                          msg: "لم يتم حصول على كوبون حاول مرة اخرى",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color(0xff38056e).withOpacity(0.9),
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }

                  },
                  child: new Container(
                      height: 44.00,
                      width: MediaQuery.of(context).size.width*0.62,
                      decoration: BoxDecoration(
                        color: Color(0xff38056e),borderRadius: BorderRadius.circular(25.00),
                      ),
                      child:Center(
                        child: new Text(
                          "الحصول على كوبون الخصم",
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
              ),
            ],

          ),
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
                  "بيانات ابن جديد",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Tajawal",fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color:Color(0xff3d3b39),
                  ),
                ),
              ),
              Container(
                height:355,
                width: 90,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(top: 8, bottom: 8),
                color: Colors.white,
                child:Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 0, bottom: 16),
                          width: MediaQuery.of(context).size.width*0.7,
                          child: Text(
                            translator.currentLanguage == 'ar' ? 'الإسم':'name',
                            style: TextStyle(

                              fontSize: 15,
                              color:  Colors.black54,
                            ),
                          //  textAlign: TextAlign.right,
                          ),
                        ),
                Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: MediaQuery.of(context).size.height*0.06,
                    child: TextFormField(onChanged: (val)=>setState((){newStudentsName=val;}),
                      cursorColor: Color(0xff38056e),
                      keyboardType:TextInputType.text,
                      autofocus: false,
                    //  textAlign: TextAlign.right,
                      //(val)=>setState(()=>Name=val)
                      // onChanged:onChanged ,
                      // controller:controller ,
                      obscureText: false,
                      decoration: InputDecoration(
                          //suffixIcon: Icon(Icons.arrow_drop_down,color:text=="الدولة"|| text=="النوع"||text=="تاريخ الميلاد"?Colors.grey[300]: Color(0x0ffff),),
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
                          hintText:translator.currentLanguage == 'ar' ?'أدخل اسم طالب جديد':'Enter a new student\'s name',

                          // icon:tajerAccount?Image.asset("Assets/icon-store.png",color:Color(0xfff99b1d),):Image.asset("Assets/icon-account.png") ,
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color:Color(0xff5e5e5e).withOpacity(0.48),
                          ),
                          labelStyle: null
                      ),

                    ),
                  ),

                ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16, bottom: 16),
                      width: MediaQuery.of(context).size.width*0.7,
                      child: Text(
                        translator.currentLanguage == 'ar' ? 'المرحلة':'stage',
                        style: TextStyle(

                          fontSize: 15,
                          color:  Colors.black54,
                        ),
                       // textAlign: TextAlign.right,
                      ),
                    ),
                    Container(
                      height:150,
                      width: MediaQuery.of(context).size.width*0.8,
                      padding: EdgeInsets.all(0),
                     // margin: EdgeInsets.only(top: 16, bottom: 40),
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
                                {setState(()=>{newStudentsid=data[int]['id'],newStudentsNameid=data[int]['nameAr']});}
                              },
                          // diameterRatio: 1.6,
                          children: <Widget>[
                            ...data.map((name) {
                              print(name['nameAr']);
                              return InkWell(
                              onTap: ()=>{setState(()=>{newStudentsid=name['id'],newStudentsNameid=name['nameAr']}),},
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
                    Center(
                      child: InkWell(
                        onTap: ()async{
                           Students StudentsItem = new Students(schoolStageId:newStudentsid,name:newStudentsName,schoolStageIdname:newStudentsNameid );
                      await  setState(() {

                        if(newStudentsName==null ||newStudentsid==null){
                          Fluttertoast.showToast(
                              msg:  translator.currentLanguage == 'ar' ?"لم تتم اضافة ابن":"No son has been added",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 3,
                              backgroundColor: Color(0xff38056e).withOpacity(0.9),
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }else{
                          StudentsDataApi.add( {
                            "id": 0,
                            "studentName": newStudentsName,
                            "schoolStageId":newStudentsid,
                            "schoolCouponId": 0
                          });

                          //Studentsdata(id:0,studentName:newStudentsName,schoolStageId:newStudentsid,schoolCouponId:0));
                          StudentsData.add(StudentsItem);
                        }

                        });
                           setState(() {
                             newStudentsName=null;
                             newStudentsid==null;
                           });
                           Navigator.pop(context);
                         print(StudentsData[0].schoolStageId);
                        },
                        child: new Container(
                          margin: EdgeInsets.only(top: 13),
                            height: 38.00,
                            width:228.00,
                            decoration: BoxDecoration(
                              color: Color(0xff38056e),borderRadius: BorderRadius.circular(25.00),
                            ),
                            child:Center(
                              child: new Text(
                                translator.currentLanguage == 'ar' ? "اضف ابن جديد":'Add a new son',
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
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
      );
  }

  var result;
  getLoggedInState(expireDate,branchId) async {
    await networkRequest.SchoolCouponsAdd(expireDate,branchId,StudentsDataApi).then((value){
      setState(() {
        result  = value;
      });
    });
  }
 Widget childs(name,id,nameid,index){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4) ,
      child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width:  MediaQuery.of(context).size.width*0.6,
            child: Text(translator.translate(name),overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight:FontWeight.w600,fontSize: 18,color:Color(0xff38056e)),
            ),
          ),
          Container(
            width:  MediaQuery.of(context).size.width*0.2,
            child: Center(
              child: Text(translator.translate(nameid),
                style: TextStyle(fontWeight:FontWeight.w600,fontSize:nameid.length>8?14: 18,color:Color(0xff38056e) ),
              ),
            ),
          ),
        //  Spacer(),
   InkWell(
     onTap: (){
       setState(() {
         StudentsData.removeAt(index);
       });
     },
     child: Container(
     //         margin: EdgeInsets.only(top: 20),
            height: 22.00,
             width: 22.00,
             // padding:EdgeInsets.all( 2) ,
              decoration: BoxDecoration(
               color:Color(0xff80AB40),borderRadius: BorderRadius.circular(12.00),
             ),child:  Center(child: Icon(Icons.clear,size: 18,))),
   ),
        ],
      ),

    );
  }
}

class Students {
  final int schoolStageId;
  final String name;
  final String schoolStageIdname;
  Students({this.schoolStageId, this.name,this.schoolStageIdname});
}
class Studentsdata {
  final int id;
  final String studentName;
  final int schoolStageId;
  final int schoolCouponId;
  Studentsdata( {this.id, this.studentName,this.schoolStageId,this.schoolCouponId});
}