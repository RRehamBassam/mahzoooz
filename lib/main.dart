import 'dart:async';
import 'package:mahzoooz/services/helperFunctions.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mahzoooz/Screen/Auth/login.dart';
import 'Screen/Auth/welcome.dart';
import 'Screen/Home.dart';
import 'package:provider/provider.dart';
import 'package:mahzoooz/services/providerUser.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await translator.init(
    localeDefault: LocalizationDefaultType.device,
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'Assets/langs/',
    apiKeyGoogle: '<Key>', // NOT YET TESTED
  ); // intialize

  runApp(LocalizedApp(
      child:   MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => providerUser()),
      ],child: MyApp())));
}

class MyApp extends StatelessWidget {



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'محظوظ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Tajawal',
        primarySwatch: Colors.blue,
        primaryColor: Color(0xff38056e),
      ),
      routes: <String, WidgetBuilder> {

        '/login': (BuildContext context) => login("+9705941025",true),

      },
      home: MyHomePage(),
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //
      // ],
       localizationsDelegates: translator.delegates,
      locale: translator.locale,
      supportedLocales: translator.locals(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool userIsLoggedIn;

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn  = value;
      });
    });
  }

  // getLoggedInState() async {
  //   await HelperFunctions.getUserLoggedInSharedPreference().then((value){
  //     setState(() {
  //       userIsLoggedIn  = value;
  //     });
  //   });
  // }

  void initState(){
    userIsLoggedIn=false;
    //getLoggedInState();
    getLoggedInState();
    super.initState();
    start();
  }
  start()async{

    return Timer(const Duration(seconds: 3), (){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_){
            return userIsLoggedIn != null ?  userIsLoggedIn ? Home() :  welcome(false): welcome(false);;//
          })
      );
    }) ;
  }
  bool _enabled = true;
  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return  Scaffold(
      body: Container(
          width: double.infinity,
          child: Center(
            child:Image.asset("Assets/1.png",fit: BoxFit.fill,height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width ,),// Text(translator.translate('appTitle')),//
          )),
    );


  }
}