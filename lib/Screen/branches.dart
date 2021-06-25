import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:mahzoooz/Widget/singleBranch.dart';
class branches extends StatefulWidget {
var data;

branches(this.data);

  @override
  _branchesState createState() => _branchesState(data);
}

class _branchesState extends State<branches> {
  var data;

  _branchesState(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Container(
        height: MediaQuery.of(context).size.height*0.82,
child: ListView.builder(
      shrinkWrap: true,
      itemCount:data.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return    singleBranch(data[index]); }),

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
      title:Text( translator.translate("الفروع المتاحة"),style: TextStyle(color:Color(0xff38056e),fontSize: 20),) ,
      centerTitle: true,
    );
  }

}
