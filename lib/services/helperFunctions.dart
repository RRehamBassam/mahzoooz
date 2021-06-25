import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserAddressKey = "USERAddressKEY";
  static String sharedPreferenceUserAddressLocalKey = "USERAddresslKEY";
  static String sharedPreferenceUserAddressChangeKey = "USERAddressChKEY";
  static String sharedPreferenceUserMobileKey = "USERMOBILEKEY";
  static String sharedPreferenceUserIdKey = "USERIDKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";
  static String sharedPreferenceDataEmptyKey = "DataEmpty";
  static String sharedPreferenceUserAdminKey = "USERAdminKEY";
  static String sharedPreferenceUserImageKey = "USERImageKEY";
  static String sharedPreferenceUserIsRecevidInKey ="isRecevid";
  static String sharedPreferenceUserlocationLatKey = "locationLat";
  static String sharedPreferenceUserlocationLngKey = "locationLng";
  static String sharedPasslocationLngKey = "p";
  /// saving data to sharedpreference
  static Future<bool> saveUserLoggedInSharedPreference(bool isUserLoggedIn) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }
  static Future<bool> saveDataEmptyInSharedPreference(bool isUserLoggedIn) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPreferenceDataEmptyKey, isUserLoggedIn);
  }
  static Future<bool> saveUserIsRecevidSharedPreference(String isRecevid) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserIsRecevidInKey, isRecevid);
  }

  static Future<bool> saveUserNameSharedPreference(String userName) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserNameKey, userName);
  }
  static Future<bool> saveUserlocationLatSharedPreference( double Lat) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setDouble(sharedPreferenceUserlocationLatKey, Lat);
  }
  static Future<bool> saveUserlocationlngSharedPreference(double Lat) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setDouble(sharedPreferenceUserlocationLngKey, Lat);
  }
  static Future<bool> saveUserPassWordSharedPreference( String Lat) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPasslocationLngKey, Lat);
  }
  static Future<bool> saveUserMobileSharedPreference(String userName) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserMobileKey, userName);
  }
  static Future<bool> saveUserIdSharedPreference(String userName) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserIdKey, userName);
  }

  static Future<bool> saveUserAddressSharedPreference(String userName) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserAddressKey, userName);
  }
  static Future<bool> saveUserAddressLocalSharedPreference(String userName) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserAddressLocalKey, userName);
  }

  static Future<bool> saveUserAddressChangeSharedPreference(String userName) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserAddressChangeKey, userName);
  }


  static Future<bool> saveUserEmailSharedPreference(String userEmail) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserEmailKey, userEmail);
  }
  static Future<bool> saveUserImageSharedPreference(String userEmail) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserImageKey, userEmail);
  }
  static Future<bool> saveUserAdminSharedPreference(bool userEmail) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPreferenceUserAdminKey, userEmail);
  }

  /// fetching & getting data from sharedpreference

  static Future<bool> getUserLoggedInSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(sharedPreferenceUserLoggedInKey);
  }
  static Future<bool> getDataEmptyInSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(sharedPreferenceDataEmptyKey);
  }
  static Future<String> getUserIsRecevidSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserIsRecevidInKey);
  }
  static Future<String> getUserPassSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPasslocationLngKey);
  }
  static Future<double> getUserLatInSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getDouble(sharedPreferenceUserlocationLatKey);
  }
  static Future<double> getUserLngSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getDouble(sharedPreferenceUserlocationLngKey);
  }


  static Future<String> getUserNameSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserNameKey);
  }
  static Future<String> getUserAddressSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserAddressKey);
  }
  static Future<String> getUserAddressLocalSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserAddressLocalKey);
  }
  static Future<String> getUserAddressChangeSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserAddressChangeKey);
  }
  static Future<String> getUserMobileSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserMobileKey);
  }
  static Future<String> getUserIdSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserIdKey);
  }

  static Future<String> getUserEmailSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserEmailKey);
  }
  static Future<String> getUserImageSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserImageKey);
  }
  static Future<bool> getUserAdminSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(sharedPreferenceUserAdminKey);
  }

}