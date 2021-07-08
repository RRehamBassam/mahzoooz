import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:mahzoooz/Screen/Map.dart';
import 'package:mahzoooz/Screen/OpenMap.dart';

class singleBranch extends StatefulWidget {
 var data;

 singleBranch(this.data);

  @override
  _singleBranchState createState() => _singleBranchState(data);
}

class _singleBranchState extends State<singleBranch> {
  var data;

  _singleBranchState(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(8.0),
        color: const Color(0xffffffff),
      ),
      height:90,
    child: SizedBox(

      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
                  // Navigator.push(context,
                  //     new MaterialPageRoute(builder: (context) => new maps(data['latitude'],data['longitude'])));
                  MapUtils.openMap(data['latitude'],data['longitude']);

                },
                child: Row(

                  children: [

                    Container(
                      width:MediaQuery.of(context).size.width*0.2<72?MediaQuery.of(context).size.width*0.59:MediaQuery.of(context).size.width*0.62,
                      child: Text(
                        translator.currentLanguage == 'ar' ? data['addressAr']: data['addressEn'],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color:Colors.black,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
              Text(translator.currentLanguage == 'ar' ? data['nameAr']:data['nameEn'],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color:Colors.grey,
                ),),
            ],
          ),
          Spacer(),
          InkWell(

              onTap: (){
                // Navigator.push(context,
                //     new MaterialPageRoute(builder: (context) => new maps(data['latitude'],data['longitude'])));
                MapUtils.openMap(double.parse(data['latitude']),double.parse(data['longitude']));
              }
          ,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 4),
height: 34,
  width:MediaQuery.of(context).size.width*0.2<72?MediaQuery.of(context).size.width*0.22:MediaQuery.of(context).size.width*0.2,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 1,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(25.0),
                color: const Color(0xff38056e),

              ),
                child:Center(
                  child: Text(translator.translate("Map"),style: TextStyle(
                    color: Colors.white,fontSize: 16
                  ),),
                )
            ),
          )
        ],
      ),
    ),
    );
  }
}
