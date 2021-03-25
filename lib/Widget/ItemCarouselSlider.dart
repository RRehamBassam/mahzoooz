
import 'package:flutter/material.dart';
class ItemCarouselSlider extends StatefulWidget {
  @override
  _ItemCarouselSliderState createState() => _ItemCarouselSliderState();
}

class _ItemCarouselSliderState extends State<ItemCarouselSlider> {
  @override
  Widget build(BuildContext context) {
    return   Stack(
      children: [
        Container(
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: AssetImage('Assets/Rectangle.png'),
              fit: BoxFit.cover,
            ),
          ),),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            margin: EdgeInsets.all(5.0),
            padding: EdgeInsets.all(5.0) ,
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.0),
            ),


            height: 66,
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      "مطعم البيك",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'Nimbus',
                        fontSize: 13,
                        color:Color(0xffffffff),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: new Text(
                        "خصم ١٠٠ ريال سعودي",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: 'Nimbus',
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color:Color(0xffffffff),
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  width: 60,
                  height:30,
                  decoration: BoxDecoration(
                    color: Color(0xff38056e),borderRadius: BorderRadius.circular(18.00),
                  ),
                  child: Center(
                    child: new Text(
                      "شوف العرض",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 8,
                        color:Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
