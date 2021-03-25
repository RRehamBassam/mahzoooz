import 'package:flutter/material.dart';
class AppBarTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.14,
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
    );
  }
}
