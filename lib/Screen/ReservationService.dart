import 'package:flutter/material.dart';
import 'package:animated_clipper/animated_clipper.dart';
import 'package:mahzoooz/Widget/dayBox.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:mahzoooz/services/app_state.dart';
import 'package:provider/provider.dart';
import 'package:mahzoooz/api/NetworkRequest.dart';
import 'package:mahzoooz/services/helperFunctions.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mahzoooz/Screen/Auth/welcome.dart';
import 'package:page_transition/page_transition.dart';
import 'package:mahzoooz/Screen/RestaurantData.dart';

class ReservationService extends StatefulWidget {
  var data;
  var id;
  var dataRestaurantData;
  @override
  _ReservationServiceState createState() => _ReservationServiceState(data,id,dataRestaurantData);

  ReservationService(this.data,this.id,this.dataRestaurantData);
}

class _ReservationServiceState extends State<ReservationService> {
  var data;
  var id; var dataRestaurantData;
  NetworkRequest networkRequest=new NetworkRequest();
  _ReservationServiceState(this.data,this.id,this.dataRestaurantData);
  List occasionList=["يوم ميلاد","ذكرى سنوية","وجبة عمل","موعد ليلى"];
  int Count;
  var ShowCount;
  int selectDay;
  var token;
   var SpecialRequest;
  void gettoken()async{
  await HelperFunctions.getUserEmailSharedPreference().then((value){
  token  = value ;
  });
  }
  @override
  void initState() {
    SpecialRequest="";
    gettoken();
    _bool=false;
    select=-1;
    selectoccasion=-1;
    selectDay=0;
    Count=1;
    ShowCount=false;
    // TODO: implement initState
    super.initState();
  }
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    var timing=data;
    print(data);
    return Scaffold(
        key: scaffoldKey,
      appBar:appBar() ,
        body:data==[]?Container(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(translator.translate("لايوجد مواعيد للحجز"))
            ],
          ),
        ):Container(
          width: MediaQuery.of(context).size.width,

          margin: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
         //   mainAxisAlignment:MainAxisAlignment.center,
              children: [
               // SizedBox(height:25),
                Text(translator.translate("Available Reservation Timings"),
                  style: TextStyle(fontWeight:FontWeight.w700,fontSize: 20,color:Colors.black ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.13,//105,
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount:data.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        double scale = 1.0;
                        return InkWell(
                          onTap: (){
                            setState(() {
                              selectDay=index;
                            });
                          },
                            child:tim(index,selectDay==index));}), //dayBox(selectDay==index, timing));}),
                ),
                Text(translator.translate("Choose the number of guests"),
                  style: TextStyle(fontWeight:FontWeight.w700,fontSize: 18,color:Colors.black ),
                ),
                ChangeNotifierProvider<AppState>(
                  create: (_) => AppState(),
                  child: Consumer<AppState>(
                    builder: (context, appState, _) {
                      print(appState.selectedCategory);
                      if(appState.selectedCategory==1){
                        //  networkRequest.changestatusorder(id,"4");
                        //  Navigator.pop(context);
                      }

                      return Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          // boxShadow: [BoxShadow(
                          //     color: Color.fromRGBO(34, 134, 234, .3),
                          //     blurRadius: 20,
                          //     offset: Offset(0, 10)
                          // )],color:Colors.white,



                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35.0),
                            topRight: Radius.circular(35.0),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            // SizedBox(height: 16,),
                            // Center(
                            //   child:  Text(
                            //     "",
                            //     textAlign: TextAlign.center,
                            //     style: TextStyle(
                            //       fontFamily: "Tajawal",fontWeight: FontWeight.w500,
                            //       fontSize: 16,
                            //       color:Color(0xff3d3b39),
                            //     ),
                            //   ),
                            // ),
                            Container(
                             // height: MediaQuery.of(context).size.height*0.064,//105,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(8),
                            //  margin: EdgeInsets.only(top: 2),
                             // color: Colors.white,
                              child: Column(
                                children: [
                                  Container(
                                    width:MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            // Image.asset("Assets/Profile.png",color:Color(0xff38056e)),
                                            // SizedBox(width: 16,),
                                            // Text(translator.translate("Persons"),
                                            //   style: TextStyle(fontWeight:FontWeight.w700,fontSize: 18,color:Color(0xff38056e) ),
                                            // ),
                                            SizedBox(width: 40,),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap:(){
                                                    if(Count>1){
                                                      setState(() {
                                                        Count--;
                                                      });
                                                      appState.updateCount(Count);
                                                    }

                                                  },
                                                  child: Container(
                                                    width: 34.0,
                                                    height: 34.0,
                                                    //  padding: EdgeInsets.only(bottom: 6),
                                                    decoration: new BoxDecoration(
                                                    //     boxShadow: [BoxShadow(
                                                    //     color: Color.fromRGBO(34, 134, 234, .3),
                                                    //      blurRadius: 2,
                                                    //     offset: Offset(0, 2)
                                                    // )],
                                                      border: Border.all(color: Colors.black45),
                                                      //color: Colors.orange,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Center(child:Container(
                                                      height: 2,
                                                      width: 16,
                                                      color:Color(0xff38056e),
                                                    )),

                                                  ),

                                                ),
                                                SizedBox(width: 20,),
                                                Text(appState.count==0?"$Count":"${appState.count}"),
                                                SizedBox(width: 20,),
                                                InkWell(
                                                  onTap: (){
                                                    setState(() {
                                                      Count++;
                                                    });
                                                    appState.updateCount(Count);
                                                  },
                                                  child: Container(
                                                    width: 34.0,
                                                    height: 34.0,
                                                    decoration: new BoxDecoration(
                                                      border: Border.all(color: Colors.black45),
                                                      //  color: Colors.orange,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Icon(Icons.add),
                                                  ),
                                                )
                                              ],
                                            )

                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  // SizedBox(height: 15,),
                                  // GestureDetector(
                                  //   onTap:()=> {
                                  //     setState(
                                  //             (){
                                  //           ShowCount=true;
                                  //         }
                                  //     ),
                                  //     print("ooo"),
                                  //     Navigator.pop(context)},
                                  //   child: new Container(
                                  //     margin:EdgeInsets.only(right: 30, left: 30),
                                  //     width:MediaQuery.of(context).size.width*0.6,
                                  //     height: 42,
                                  //     decoration: BoxDecoration(
                                  //       color: Color(0xff38056e),borderRadius: BorderRadius.circular(25.00),
                                  //     ),
                                  //     child: Center(
                                  //       child: new Text(
                                  //         "موافق",
                                  //         textAlign: TextAlign.center,
                                  //         style: TextStyle(
                                  //           fontWeight: FontWeight.w500,
                                  //           fontSize: 14,
                                  //           color:Color(0xffffffff),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      );},
                  ),
                ),
            // Center(
            //   child: InkWell(
            //     onTap: (){
            //       showModalBottomSheet(
            //         context: context,
            //         isScrollControlled: true,
            //         builder: (context) => SingleChildScrollView(
            //           child: Container(
            //             decoration: BoxDecoration(
            //               color:Colors.white,
            //               borderRadius: BorderRadius.only(
            //                 topLeft: Radius.circular(20.0),
            //                 topRight: Radius.circular(20.0),
            //               ),
            //             ),
            //
            //             padding: EdgeInsets.only(
            //                 bottom: MediaQuery.of(context).viewInsets.bottom),
            //             child: BottomSheetExample(context),
            //           ),
            //         ),
            //       );
            //     },
            //     child: Container(
            //       height: MediaQuery.of(context).size.height*0.06,
            //       width:MediaQuery.of(context).size.width*0.5,
            //       margin: EdgeInsets.symmetric(horizontal: 16,vertical: 18),
            //       child: Material(
            //         borderRadius: BorderRadius.circular(22.0),
            //         elevation: 2,
            //         child: Container(
            //           height: 48,
            //           width:MediaQuery.of(context).size.width*0.5,
            //          // margin: EdgeInsets.symmetric(horizontal: 16,vertical: 18),
            //           decoration: BoxDecoration(
            //             border: Border.all(color:Color(0xff38056e) ),
            //             borderRadius: BorderRadius.circular(22.0),
            //             color: const Color(0xfffFfffF),
            //           ),
            //
            //           child:Center(
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //
            //                 ShowCount?Text("$Count",
            //               style: TextStyle(fontWeight:FontWeight.w700,fontSize: 18,color:Color(0xff38056e) ),
            //
            //             ):  Text("اختر",
            //                   style: TextStyle(fontWeight:FontWeight.w700,fontSize: 18,color:Color(0xff38056e) ),
            //
            //                 ),
            //                 SizedBox(width: 16,),
            //                 Image.asset("Assets/Profile.png",color:Color(0xff38056e)),
            //               ],
            //             ),
            //           )),
            //       ),
            //     ),
            //   ),
            // ),
            //     Text(translator.translate("Please select a time"),
            //       style: TextStyle(fontWeight:FontWeight.w700,fontSize: 18,color:Colors.black ),
            //     ),
                Container(
                  margin:EdgeInsets.symmetric(horizontal: 12,vertical: 8) ,
                  child: Text(translator.translate("Available times"),style: TextStyle(fontWeight:FontWeight.w700,fontSize: 18,color:Colors.black )
                  //  style: TextStyle(fontWeight:FontWeight.w700,fontSize: 14,color:Colors.black ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.072,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount:data[selectDay]['details'].length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        double scale = 1.0;
                        return timeBox(index);}), //dayBox(selectDay==index, timing));}),
                ),
                Text(translator.translate("Occasion type"),
                  style: TextStyle(fontWeight:FontWeight.w700,fontSize: 18,color:Colors.black ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.072,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount:occasionList.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        double scale = 1.0;
                        return occasionBox(index);}), //dayBox(selectDay==index, timing));}),
                ),
                Text(translator.translate("Special request"),
                  style: TextStyle(fontWeight:FontWeight.w700,fontSize: 18,color:Colors.black ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.15,
                   width:MediaQuery.of(context).size.width*0.9,
                  child: TextFormField(//onChanged: (val)=>setState((){searchWord=val;}),
                    cursorColor: Color(0xff38056e),
                    keyboardType:TextInputType.text,
                    autofocus: false,
                    textAlign:translator.currentLanguage == 'ar' ? TextAlign.right:TextAlign.left,//(val)=>setState(()=>Name=val)
                     onChanged:(val){
                      setState(() {
                        SpecialRequest=val;
                      });
                     },
                    // controller:controller ,
                    minLines: 3,
                    maxLines: 7,

                    obscureText: false,
                    decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(width: 0.5,color: Colors.grey[300]),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(width: 0.5,color:Color(0xff38056e))
                        ),
                        filled: true,
                        fillColor: Color(0xFFF8F8F8).withOpacity(0.7),
                        // prefixIcon:tajerAccount?Image.asset("Assets/icon-store.png",color:Color(0xfff99b1d),):Image.asset("Assets/icon-account.png") ,

                        hintText:translator.translate("إضافة طلب خاص(اختيارى)"),

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
                Center(
                  child: InkWell(
                    onTap: () async {
                      if(selectoccasion==-1){
                        Fluttertoast.showToast(
                            msg:translator.translate( "يجب عليك اختيار مناسبة"),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Color(0xff38056e).withOpacity(0.9),
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }

                      await gettoken();
                     if(token!=null || token!=""){
                       if(data[selectDay]['details'][select]['isBooking']){
                         Fluttertoast.showToast(
                             msg:translator.translate( "هذا الوقت محجوز "),
                             toastLength: Toast.LENGTH_SHORT,
                             gravity: ToastGravity.BOTTOM,
                             timeInSecForIosWeb: 1,
                             backgroundColor: Color(0xff38056e).withOpacity(0.9),
                             textColor: Colors.white,
                             fontSize: 16.0
                         );

                       }else {
                         print("$id  id");
                        await getAddBookingState(data[selectDay]['details'][select]['bookingTime'],
                             "${data[selectDay]['dayDate']}",Count,occasionList[selectoccasion],SpecialRequest,id);
                        if(AddBooking=="notOk"){
                          Fluttertoast.showToast(
                              msg:translator.translate("لم تتم عملية الحجز حاول مرة الاخرى"),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Color(0xff38056e).withOpacity(0.9),
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }else if(AddBooking=="ok"){
                          Fluttertoast.showToast(
                              msg: translator.translate("تم الحجز"),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Color(0xff38056e).withOpacity(0.9),
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (a, b, c) => RestaurantData(dataRestaurantData),
                              transitionDuration: Duration(seconds: 0),
                            ),
                          );
                       //   Navigator.pop(context);
                        }else if(AddBooking is int){
                          Fluttertoast.showToast(
                              msg:translator.currentLanguage == 'ar' ?  "العدد المسموح به $AddBooking": "Allowed number $AddBooking",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 3,
                              backgroundColor: Color(0xff38056e).withOpacity(0.9),
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }
                        else if(AddBooking =="no"){
                          Fluttertoast.showToast(
                              msg:translator.translate("لم تتم عملية الحجز حاول مرة الاخرى"),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Color(0xff38056e).withOpacity(0.9),
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }else{
                          Fluttertoast.showToast(
                              msg:translator.translate("لم تتم عملية الحجز حاول مرة الاخرى"),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Color(0xff38056e).withOpacity(0.9),
                              textColor: Colors.white,
                              fontSize: 16.0
                          );

                        }
                         // networkRequest.AddBooking(data[selectDay]['details'][select]['bookingTime'],
                         //     "${data[selectDay]['dayDate']}",Count,occasionList[selectoccasion],SpecialRequest,id);

                      //   Navigator.pop(context);
                       }

                     }else
                     {
                       Fluttertoast.showToast(
                           msg: translator.translate("لإتمام عملية الحجز يجب عليك تسجيل دخول"),
                           toastLength: Toast.LENGTH_SHORT,
                           gravity: ToastGravity.BOTTOM,
                           timeInSecForIosWeb: 1,
                           backgroundColor: Color(0xff38056e).withOpacity(0.9),
                           textColor: Colors.white,
                           fontSize: 16.0
                       );
                      await getData();
                      Navigator.push(context,PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 550) ,
                        reverseDuration: Duration(milliseconds: 700),
                        child: welcome(true),
                      ),);
                       // Navigator.push(
                       //   context,
                       //   MaterialPageRoute(builder: (context) => welcome(true)),
                       // );

                      //  scaffoldKey.currentState.showSnackBar(SnackBar(
                      //      content: InkWell(
                      //      onTap: (){
                      //    Navigator.push(
                      //      context,
                      //      MaterialPageRoute(builder: (context) => welcome(true)),
                      //    );
                      //  },
                      // child: Row(
                      //   children: [
                      //   Text(
                      //   "يجب عليك تسجيل دخول"),
                      //     Spacer(),
                      //     Text(
                      //         " تسجيل "),
                      //   ],
                      // ),
                      // ))
                      //
                      //  );

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
                            translator.translate( "حجز"),
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
                // Container(
                //   height: 60,
                //   width:110,
                //   margin: EdgeInsets.all(4),
                //   decoration: BoxDecoration(
                //     border: Border.all(color:Color(0xff38056e) ),
                //     borderRadius: BorderRadius.circular(11.0),
                //     color: const Color(0xfffFfffF),
                //   ),
                //   child: Center(
                //       child: Text("إضافة طلب خاص(اختيارى)",
                //         style: TextStyle(fontWeight:FontWeight.w500,fontSize: 18,color:Color(0xff38056e) ),
                //       )),
                //
                // )
                // Container(
                //   height: MediaQuery.of(context).size.height*0.5,
                //   child: GridView.count(
                //     crossAxisCount: 4,
                //
                //     childAspectRatio: 65/ 60,
                //     children: List.generate(12, (index) {
                //       return Center(
                //         child:timeBox(index),
                //       );
                //     }),
                //   ),
                // )
                // FutureBuilder<dynamic>(
                //     future: networkRequest.CategoriesGetPaged(),
                //     builder: (context, snapshot) {
                //       if (snapshot.hasData) {
                //         return  ListView.builder(
                //             shrinkWrap: true,
                //             scrollDirection: Axis.horizontal,
                //             itemCount:snapshot.data.length,
                //             physics: BouncingScrollPhysics(),
                //             itemBuilder: (context, index) {
                //               double scale = 1.0;
                //               return Categories(snapshot.data[index],false);});}
                //       else if (snapshot.hasError) {
                //         return Center(child: Text("تأكد من إتصال بالإنرنت"));
                //       }
                //       // By default, show a loading spinner.
                //       return Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           SizedBox(height: 30,),
                //           CategoriesLoud(snapshot.data,true),
                //           CategoriesLoud(snapshot.data,true),
                //           CategoriesLoud(snapshot.data,true),
                //           //  CategoriesLoud(snapshot.data,true),
                //           //  Loading(),
                //           // Center(
                //           //   child: PixLoader(
                //           //       loaderType: LoaderType.Spinner, faceColor: Color(0xfff99b1d)),
                //           // )
                //           //CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xfff99b1d) ),)
                //         ],
                //       );}),
              ],
            ),
          ),
        )
    );
  }
  var AddBooking;
  getAddBookingState(bookingTime, dayDate,numberOfPerson ,occasion,SpecialRequest,id) async {
    await networkRequest.AddBooking(data[selectDay]['details'][select]['bookingTime'],
             "${data[selectDay]['dayDate']}",Count,occasionList[selectoccasion],SpecialRequest,id).then((value){
      setState(() {
        AddBooking  = value;
      });
    });
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

                return Container(
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
               // SizedBox(height: 16,),
                // Center(
                //   child:  Text(
                //     "",
                //     textAlign: TextAlign.center,
                //     style: TextStyle(
                //       fontFamily: "Tajawal",fontWeight: FontWeight.w500,
                //       fontSize: 16,
                //       color:Color(0xff3d3b39),
                //     ),
                //   ),
                // ),
                Container(
                  height: MediaQuery.of(context).size.height*0.13,//105,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.only(top: 16),
                  color: Colors.white,
                 child: Column(
                   children: [
                     Container(
                       width:MediaQuery.of(context).size.width,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                          Row(
                            children: [
                              Image.asset("Assets/Profile.png",color:Color(0xff38056e)),
                              SizedBox(width: 16,),
                              Text(translator.translate("أشخاص"),
                                style: TextStyle(fontWeight:FontWeight.w700,fontSize: 18,color:Color(0xff38056e) ),
                              ),
                              SizedBox(width: 40,),
                             Row(
                               children: [
                                 InkWell(
                                   onTap:(){
                                     if(Count>1){
                                       setState(() {
                                         Count--;
                                       });
                                       appState.updateCount(Count);
                                     }

            },
                                   child: Container(
                                     width: 32.0,
                                     height: 32.0,
                                   //  padding: EdgeInsets.only(bottom: 6),
                                     decoration: new BoxDecoration(
                                       border: Border.all(color: Colors.black45),
                                       //color: Colors.orange,
                                       shape: BoxShape.circle,
                                     ),
                                   child: Center(child:Container(
                                     height: 2,
                                     width: 16,
                                     color:Color(0xff38056e),
                                   )),

                                   ),

                                 ),
                                 SizedBox(width: 20,),
                                 Text(appState.count==0?"$Count":"${appState.count}"),
                                 SizedBox(width: 20,),
                                 InkWell(
                                   onTap: (){
                                     setState(() {
                                       Count++;
                                     });
                                     appState.updateCount(Count);
                                   },
                                   child: Container(
                                     width: 32.0,
                                     height: 32.0,
                                     decoration: new BoxDecoration(
                                       border: Border.all(color: Colors.black45),
                                     //  color: Colors.orange,
                                       shape: BoxShape.circle,
                                     ),
                                     child: Icon(Icons.add),
                                   ),
                                 )
                               ],
                             )

                            ],
                          )
                         ],
                       ),
                     ),
                     SizedBox(height: 15,),
                     GestureDetector(
                       onTap:()=> {
                         setState(
                             (){
                               ShowCount=true;
                             }
                         ),
                         print("ooo"),
                         Navigator.pop(context)},
                       child: new Container(
                         margin:EdgeInsets.only(right: 30, left: 30),
                         width:MediaQuery.of(context).size.width*0.6,
                         height: 42,
                         decoration: BoxDecoration(
                           color: Color(0xff38056e),borderRadius: BorderRadius.circular(25.00),
                         ),
                         child: Center(
                           child: new Text(
                             "موافق",
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
                 ),
                ),

              ],
            ),
          ),
        );},
          ),
      );
  }

   appBar(){
    return AppBar(
      leading: InkWell(
        onTap: (){
          Navigator.pop(context);
        },
          child: Icon(Icons.arrow_back_ios,color:Color(0xff38056e))),
      toolbarHeight: 65,
      elevation: 1,
      backgroundColor: Colors.white,
      title:Text( translator.translate("Reservation Service"),style: TextStyle(color:Color(0xff38056e)),) ,
      centerTitle: true,
    );
  }
  int select;
  int selectoccasion;
  Widget timeBox(index){
    return InkWell(
      onTap: (){
        if(data[selectDay]['details'][index]['isBooking']){

        }else{
          setState(() {
            select=index;
          });
        }

      },
      child: Container(
          height: 60,
          width:110,
          margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color:Color(0xff38056e) ),
      borderRadius: BorderRadius.circular(11.0),
      color:data[selectDay]['details'][index]['isBooking']? Colors.grey.withOpacity(0.2):select==index?Color(
          0xff38056e).withOpacity(0.9): const Color(0xfffFfffF),
      ),
      child: Stack(
        children: [
          Center(
              child: Text(translator.currentLanguage == 'ar' ?"${data[selectDay]['details'][index]['bookingTime'].split(':')[1].split(':')[0]} : ${data[selectDay]['details'][index]['bookingTime'].split(':')[0]}":"${data[selectDay]['details'][index]['bookingTime'].split(':')[0]} : ${data[selectDay]['details'][index]['bookingTime'].split(':')[1].split(':')[0]}",
                style: TextStyle(fontWeight:FontWeight.w500,fontSize: 18,color:data[selectDay]['details'][index]['isBooking']?Color(0xff38056e):select==index?Colors.white:Color(0xff38056e) ),
              )),
          data[selectDay]['details'][index]['isBooking']?Positioned(
    left: 37,
    bottom: 1,child:  Container(
      margin:EdgeInsets.all(4) ,

            child: Text("محجوز",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),))):Container(),
        ],
      ),

      ),
    );

  }
  Widget occasionBox(index){
    return InkWell(
      onTap: (){
        setState(() {
          selectoccasion=index;
        });
      },
      child: Container(
        height: 60,
        width:110,
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color:Color(0xff38056e) ),
          borderRadius: BorderRadius.circular(11.0),
          color:selectoccasion==index?Color(0xff38056e).withOpacity(0.9): const Color(0xfffFfffF),
        ),
        child: Center(
            child: Text(translator.translate(occasionList[index]),
              style: TextStyle(fontWeight:FontWeight.w500,fontSize: 16,color:selectoccasion==index?Colors.white:Color(0xff38056e) ),
            )),

      ),
    );

  }
   Map<int,String> monthsInYear = {
  1: "January",
  2: "February",
  3: "March",
  04: "April",
  05: "May",
  06: "June",
     07:"",
  12: "December"
  };
  Widget tim(index,bool) {

    return Container(
     child:selectDay==index?Container(
        height: MediaQuery.of(context).size.height*0.13,// 105,
        width: 110,
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11.0),
          color: const Color(0xffffffff),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(11.0),
          elevation: 2,
          child: Container(
            height: MediaQuery.of(context).size.height*0.13,// 105,
            width: 110,
            // margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.0),
              color: const Color(0xffffffff),

            ),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.043,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(11.0),
                        topRight: Radius.circular(11.0)),
                    //color: const Color(0xfff5f5f5),
                    color: Color(0xff38056e),
                  ),

                  child: Center(
                    child: Text(translator.currentLanguage == 'ar' ?data[index]['dayOfWeekAr']:data[index]['dayOfWeekEn'],
                      style: TextStyle(fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xff38056e).withOpacity(0.9),
                    // borderRadius: BorderRadius.only(topLeft: Radius.circular(11.0),topRight:Radius.circular(11.0)),
                    //color: const Color(0xfff5f5f5),
                    //  color:Color(0xff38056e) ,
                  ),
                  height: MediaQuery.of(context).size.height*0.042,
                  child: Center(
                    child: Text(data[index]['dayDate'].toString().split('-')[2].toString().split('T')[0],
                      style: TextStyle(fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(11.0),
                        bottomRight: Radius.circular(11.0)),
                    color: Color(0xff38056e).withOpacity(0.9),
                    // borderRadius: BorderRadius.only(topLeft: Radius.circular(11.0),topRight:Radius.circular(11.0)),
                    //color: const Color(0xfff5f5f5),
                    //  color:Color(0xff38056e) ,
                  ),
                  height: MediaQuery.of(context).size.height*0.035,
                  child: Center(
                    child: Text(translator.currentLanguage == 'ar' ?data[index]['monthAr']:data[index]['monthEn'],
                      style: TextStyle(fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ): Container(
        height:  MediaQuery.of(context).size.height*0.13,//105,
        width: 110,
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11.0),
          color: const Color(0xffffffff),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(11.0),
          elevation: 2,
          child: Container(
            height: MediaQuery.of(context).size.height*0.13,// 105,
            width: 110,
            // margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.0),
              color: const Color(0xffffffff),

            ),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.042,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(11.0),
                        topRight: Radius.circular(11.0)),
                    //color: const Color(0xfff5f5f5),
                    color: Color(0xff38056e),
                  ),

                  child: Center(
                    child: Text(translator.currentLanguage == 'ar' ?data[index]['dayOfWeekAr']:data[index]['dayOfWeekEn'],
                      style: TextStyle(fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(11.0),
                        topRight: Radius.circular(11.0)),
                    //color: const Color(0xfff5f5f5),
                    //  color:Color(0xff38056e) ,
                  ),
                  height: MediaQuery.of(context).size.height*0.042,
                  child: Center(
                    child: Text(data[index]['dayDate'].toString().split('-')[2].toString().split('T')[0],
                      style: TextStyle(fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  height:MediaQuery.of(context).size.height*0.035,
                  child: Center(
                    child: Text(translator.currentLanguage == 'ar' ?data[index]['monthAr']:data[index]['monthEn'],
                      style: TextStyle(fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
  Future<String> getData() async {
    await Future<void>.delayed(Duration(seconds: 3));
  //   if (shouldFail) {
  //     throw PlatformException(code: '404');
  //   }
  //   return 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?';
  }
  bool _bool;
  void _toggleBool(bool newValue) {
    setState(() {
      _bool = newValue;
    });

  }
}
