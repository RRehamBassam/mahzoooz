
import 'package:flutter/material.dart';
import 'package:mahzoooz/Screen/bottomNavigationBar/homeWidget.dart';
import 'package:mahzoooz/Screen/bottomNavigationBar/Discounts.dart';
import 'package:mahzoooz/Screen/bottomNavigationBar/Profile.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex ;  bool Admin=false;
  List<Widget> _widgettajerAccount = <Widget>[
    homeWidget(),Discounts(),
    Profile(),

    homeWidget(),

  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void initState() {
    _selectedIndex=0;

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgettajerAccount.elementAt(_selectedIndex),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }
  Widget bottomNavigationBar(){
    return Container(

      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,


        items: [
          BottomNavigationBarItem(
            icon: Container(
              margin:EdgeInsets.only(bottom: 6,top: 2) ,
                child: Image.asset("Assets/Home.png",color: _selectedIndex==0?Color(0xff38056e):Color(0xFF748A9D),)),
            label: 'الرئيسية',

          ),
          BottomNavigationBarItem(
            icon:Container(
                margin:EdgeInsets.only(bottom: 6,top: 2) ,
                child: Image.asset("Assets/Stroke 7.png",color: _selectedIndex==1?Color(0xff38056e):Color(0xFF748A9D),)),
            label: 'الخصومات',
          ),
          BottomNavigationBarItem(
            icon:Container( margin:EdgeInsets.only(bottom: 6,top: 2) ,
                child: Image.asset("Assets/Profile.png",color: _selectedIndex==2?Color(0xff38056e):Color(0xFF748A9D),)),
            label: 'صفحتي',
          ),
          BottomNavigationBarItem(
            icon: Container(
                margin:EdgeInsets.only(bottom: 6,top: 2) ,
                child: Image.asset("Assets/Chat.png",color: _selectedIndex==3?Color(0xff38056e):Color(0xFF748A9D),)),
            label: 'المساعده',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff38056e),
        onTap: _onItemTapped,
      ),
    );
  }
}
