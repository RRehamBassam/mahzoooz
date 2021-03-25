import 'package:flutter/material.dart';
class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.855,
      height: MediaQuery.of(context).size.height*0.059,
      child: TextFormField(//onChanged: (val)=>setState((){searchWord=val;}),
        cursorColor: Color(0xff38056e),
        keyboardType:TextInputType.text,
        autofocus: false,
        textAlign: TextAlign.right,//(val)=>setState(()=>Name=val)

        obscureText: false,
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
            fillColor: Color(0xFFF8F8F8).withOpacity(0.7),
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
    );
  }
}
