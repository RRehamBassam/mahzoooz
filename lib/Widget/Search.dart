import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:mahzoooz/Screen/SearchScreen.dart';
class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:Color(0xfe38056e),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: EdgeInsets.only(top: 14,bottom: 14),
              width: MediaQuery.of(context).size.width*0.915,
              height: MediaQuery.of(context).size.height*0.045,
              child: TextFormField(//onChanged: (val)=>setState((){searchWord=val;}),
                cursorColor: Color(0xff38056e),
                keyboardType:TextInputType.text,
                autofocus: false,
                textAlign: TextAlign.right,//(val)=>setState(()=>Name=val)

                obscureText: false,
                onTap: (){
                  Navigator.push(context,PageTransition(
                    type: PageTransitionType.leftToRight,
                    duration: Duration(milliseconds: 550) ,
                    reverseDuration: Duration(milliseconds: 700),
                    child: SearchScreen(),
                  ),);
                },
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.clear, size: 18,),
                    prefixIcon: Icon(Icons.search,size: 18,),
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
                    fillColor:Colors.white,// Color(0xFFF8F8F8).withOpacity(0.7),
                    // prefixIcon:tajerAccount?Image.asset("Assets/icon-store.png",color:Color(0xfff99b1d),):Image.asset("Assets/icon-account.png") ,

                    hintText:"ابحث في العروض",

                    // icon:tajerAccount?Image.asset("Assets/icon-store.png",color:Color(0xfff99b1d),):Image.asset("Assets/icon-account.png") ,
                    hintStyle:TextStyle(
                      fontSize: 15,
                      color:Color(0xffd9d9d9),
                    ),
                    labelStyle: null
                ),

              ),
            ),
            // Row(
            //   children: [
            //     Container(
            //         margin: EdgeInsets.only(top: 20),
            //         height: 32.00,
            //         width: 32.00,
            //         decoration: BoxDecoration(
            //           color: Colors.white,borderRadius: BorderRadius.circular(25.00),
            //         ),child: Image.asset("Assets/Notification.png",color:Color(0xfe38056e),scale: 1.2,)),
            //     SizedBox(width: 8,),
            //     Container(
            //         margin: EdgeInsets.only(top: 20),
            //         height: 32.00,
            //         width: 32.00,
            //         decoration: BoxDecoration(
            //           color:Colors.white,borderRadius: BorderRadius.circular(25.00),
            //         ),child: Image.asset("Assets/gift (1).png",color:Color(0xfe38056e),scale: 1.2,)),
            //
            //
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
