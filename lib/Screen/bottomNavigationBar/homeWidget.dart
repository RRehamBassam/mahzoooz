
import 'package:flutter/material.dart';

class homeWidget extends StatefulWidget {
  @override
  _homeWidgetState createState() => _homeWidgetState();
}

class _homeWidgetState extends State<homeWidget> {
  bool open=true;
  @override
  void initState() {
    open=true;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.2,
            child: Stack(
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
                Positioned(
                  left: 40,
                  top: 47,
                  child: Row(
                    children: [
                      Image.asset("Assets/Notification.png",color:Color(0xfe38056e)),
                      SizedBox(width: 8,),
                      Image.asset("Assets/gift (1).png",color:Color(0xfe38056e)),


                    ],
                  ),
                )
              ],
            ),
          ),
      Container(
      height: MediaQuery.of(context).size.height*0.23,
      child:open? Column(
        children: [
          new Text(
            "السحب جاهز دلوقتي",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 19,
              color:Color(0xffb4b9b9),
            ),
          ),
          SizedBox(height: 2,),
          new Text(
            "أضغط و استتمع",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 33,
              color:Color(0xff38056e),
            ),
          ),
          SizedBox(height: 2,),
          new Text(
            "دلوقتي تقدر تلعب انت و أصحابك",
            textAlign: TextAlign.center,
            style: TextStyle(

              fontSize: 14,
              color:Color(0xffb4b9b9),
            ),
          )
        ],
      ):
      Column(
        children: [
          new Text(
           "باقي علي فتح بوابه الحظ",
            textAlign: TextAlign.center,
            style: TextStyle(

              fontSize: 19,
              color:Color(0xffb4b9b9),
            ),
          ),
          SizedBox(height: 2,),
          new Text(
           "00:20:30",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 33,
              color:Color(0xff38056e),
            ),
          ),
          SizedBox(height: 2,),
          new Text(
            "دلوقتي تقدر تلعب انت و أصحابك",
            textAlign: TextAlign.center,
            style: TextStyle(

              fontSize: 14,
              color:Color(0xffb4b9b9),
            ),
          )
        ],
      ),
      ),
          open?  InkWell(onTap: ()=>setState(()=>open=!open),
              child: Image.asset("Assets/Group 39799.png",scale: 1.5,)):Image.asset("Assets/Group 39784.png",scale: 1.5,),


        ],
      ),
    );
  }
}
