import 'package:flutter/foundation.dart';
class providerUser with ChangeNotifier, DiagnosticableTreeMixin {
  String _tokenUser = "";
  String _city = "";
  String _name = "";
  String _mobile = "";
  String _pass = "";
  String _gender = "";
  String _date = "";
  String _email = "";
  double _RandomNum = 0;
  String get tokenUser => _city;
  String get name => _name;
  String get mobile => _mobile;
  String get pass => _pass;
  String get geder => _gender;
  String get date => _date;
  String get email => _email;
  double get RandomNum => _RandomNum;



  void increment(String val) {
    _tokenUser=val;
    // _tokenUser++;
    notifyListeners();
  }
  void updateRandomNum(double val) {
    _RandomNum=val;
    // _tokenUser++;
    notifyListeners();
  }
  void updateName(String val) {
    _name=val;
    // _tokenUser++;
    notifyListeners();
  }
  void updateEmail(String val) {
    _email=val;
    // _tokenUser++;
    notifyListeners();
  }
  void updateCity(String val) {
    _city=val;
    // _tokenUser++;
    notifyListeners();
  }
  void updatMobile(String val) {
    _mobile=val;
    // _tokenUser++;
    notifyListeners();
  }
  void updatePass(String val) {
    _pass=val;
    // _tokenUser++;
    notifyListeners();
  }
  void updateGender(String val) {
    _gender=val;
    // _tokenUser++;
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // properties.add(IntProperty('count', tokenUser));
  }
}