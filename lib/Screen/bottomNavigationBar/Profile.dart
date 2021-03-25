import 'package:flutter/material.dart';
import 'package:mahzoooz/Widget/AppBarTop.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ScrollController _controller = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white,  Color(0xffffffff).withOpacity(0.9)],
              tileMode: TileMode.clamp,
              begin: Alignment.topCenter,
              stops: [0.0, 1.0],
              end: Alignment.bottomCenter),
        ),
        child: Column(

         // shrinkWrap: true,
          children: [
            Column(
              children: [
                SizedBox(height: 30,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("Assets/Image-2.png")
                  ],
                ),
              ],
            ),
            SizedBox(height: 8,),
            Container(
              height: MediaQuery.of(context).size.height< 743.4285714285714? MediaQuery.of(context).size.height*0.7: MediaQuery.of(context).size.height*0.782,

              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(), // new
                controller: _controller,
                shrinkWrap: true,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: MediaQuery.of(context).size.height*0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: const Color(0xf2f5f5f5),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.95,
                              height: MediaQuery.of(context).size.height*0.15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: const Color(0xf238056e),
                              ),

                            ),
                            Image.asset('Assets/Intersection.png'),
                            Container(
                              width: MediaQuery.of(context).size.width*0.9,
                              height: MediaQuery.of(context).size.height*0.15,
                              padding: EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Image.asset('Assets/man.png'),
                                  SizedBox(width: 16,),
                                  Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "بيبو رمزي لويز",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color:Color(0xffffffff),
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                        Text(
                                          "01101970947",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color:Color(0xffffffff),
                                          ),
                                        )

                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'رصيد',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: const Color(0xffc8c7cc),
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  SizedBox(height: 8,),
                                  // Adobe XD layer: '0.2 km' (text)
                                  Text(
                                    '100 ر.س',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: const Color(0xff242e42),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.right,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'نقطة',
                                    style: TextStyle(

                                      fontSize: 13,
                                      color: const Color(0xffc8c7cc),
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  // Adobe XD layer: '0.2 km' (text)
                                  SizedBox(height: 8,),
                                  Text(
                                    "100",
                                    style: TextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff242e42),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.right,
                                  )
                                ],
                              ),
                              Column(
                                children: [

                                  Text(
                                    'طلب',
                                    style: TextStyle(
                                      fontFamily: 'DIN Next LT Arabic',
                                      fontSize: 13,
                                      color: const Color(0xffc8c7cc),
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  // Adobe XD layer: '0.2 km' (text)
                                  SizedBox(height: 8,),
                                  Text(
                                    '0.0',
                                    style: TextStyle(
                                      fontFamily: 'DIN Next LT Arabic',
                                      fontSize: 15,
                                      color: const Color(0xff242e42),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.right,
                                  )
                                ],
                              )

                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                  SizedBox(height: 22,),
                  Box("الصفحة الشخصية",Image.asset('Assets/Calling.png',color:  Color(0xff38056e),),),
                  SizedBox(height: 4,),
                  Box("العروض الخاصة و الحجوزات",Image.asset('Assets/Time Square.png',color:  Color(0xff38056e),),),
                  SizedBox(height: 4,),
                  Box("المفضلة",Image.asset('Assets/Group 39851.png',color:  Color(0xff38056e),),),
                  SizedBox(height: 4,),
                  Box("العروض المرسلة",Image.asset('Assets/Location.png',color:  Color(0xff38056e),),),
                  SizedBox(height: 4,),
                  Box("الجوائز",Image.asset('Assets/Document.png',color:  Color(0xff38056e),),),
                  SizedBox(height: 4,),
                  Box("الاعدادت",Image.asset('Assets/Bag 2.png',color:  Color(0xff38056e),),),
                  SizedBox(height: 4,),
                  Box("عن التطبيق",Image.asset('Assets/Document.png',color:  Color(0xff38056e),),),
                  SizedBox(height: 4,),
                  Box("خروج",Image.asset('Assets/Bag 2.png',color:  Color(0xff38056e),),),
                  SizedBox(height: 4,),
                ],
              ),
            ),


          ],
        ),
      ),

    );
  }
  Widget Box(String text,Widget widget){
    return           Container(
      decoration: BoxDecoration(
        color: Color(0xffffffff),borderRadius: BorderRadius.circular(11.00),
      ),
      margin:EdgeInsets.all(2) ,
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(11.00),
        child: new Container(
          height: 59.00,

          width: MediaQuery.of(context).size.width*0.82,
          padding:EdgeInsets.symmetric(vertical: 8,horizontal: 12) ,
          decoration: BoxDecoration(
            color: Color(0xffffffff),borderRadius: BorderRadius.circular(11.00),
          ),
          child: Row(
            children: [

              widget,
              SizedBox(width: 16,),
              new Text(
                text,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color:Color(0xff747474),
                ),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios,color: Color(0xffD9D9D9),size: 18,)

            ],
          ),
        ),
      ),
    );
  }
}
