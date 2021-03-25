import 'package:http/http.dart' as http;
import 'package:mahzoooz/api/ServerAddresses.dart';
import 'dart:convert';
import 'dart:ui';
import 'dart:convert' as convert;
import 'dart:io';
class NetworkRequest{
  static final NetworkRequest _instance = NetworkRequest._internal();
  factory NetworkRequest() => _instance;

  NetworkRequest._internal();
  Future<String> register() async {
    // String _result;

    try {
      final response = await http.post(
        ServerAddresses.serverAddress + ServerAddresses.register,
        body: {
          "id": 0,
          "name": "reham",
          "password": "123456",
          "confirmPassword": "123456",
          "email": "reham@example.com",
          "phone": "0594102511",
          "gender": 1,
          "birthDate": "2021-02-28T14:46:53.386Z",
          "countryId": 0,
          "imageName": "m.png",
          "generatedCode": 0
        },
      );
      Map _result;
      bool status;
      print(jsonDecode(response.body).toString());
      if (response.statusCode == 200) {
        _result = jsonDecode(response.body);
        status = _result['status'];
      // HelperFunctions.saveUserNameSharedPreference(name);
        print(status);
        if (status == true) {
          // login(phone,password);
          print("yes");
          return "تم";
        }else{
          return _result['message'];
        }
      } else {
        throw Exception("Incorrect Registration Data.");
      }
    } catch (error) {
      print('ERROR: ' + error.toString());
      //throw CustomException(error.toString()).toString();
      rethrow;
    }
    // return _result;
  }
  Future<String> login(String phone,String password) async {
    // String _result;

    try {
      final response = await http.post(
        ServerAddresses.serverAddress + ServerAddresses.Login,
        body:{
          "phone": phone,
          "password": password
        }
      );
      Map _result;
      bool status;
      print(jsonDecode(response.body).toString());
      if (response.statusCode == 200) {
        _result = jsonDecode(response.body);
        status = _result['status'];
        // HelperFunctions.saveUserNameSharedPreference(name);
        print(status);
        if (status == true) {
          // login(phone,password);
          print("yes");
          return "تم";
        }else{
          return _result['message'];
        }
      } else {
        throw Exception("Incorrect Registration Data.");
      }
    } catch (error) {
      print('ERROR: ' + error.toString());
      //throw CustomException(error.toString()).toString();
      rethrow;
    }
    // return _result;
  }
  Future<String> UserHasAccount1() async {
    // String _result;

    try {
      final response = await http.post(
          ServerAddresses.serverAddress + ServerAddresses.UserHasAccount,
          body:{
            "phone": "0594102511",
          }
      );
      Map _result;
      bool status;
      print(jsonDecode(response.body).toString());
      if (response.statusCode == 200) {
        _result = jsonDecode(response.body);
        status = _result['status'];
        // HelperFunctions.saveUserNameSharedPreference(name);
        print(status);
        if (status == true) {
          // login(phone,password);
          print("yes");
          return "تم";
        }else{
          return _result['message'];
        }
      } else {
        throw Exception("Incorrect Registration Data.");
      }
    } catch (error) {
      print('ERROR: ' + error.toString());
      //throw CustomException(error.toString()).toString();
      rethrow;
    }
    // return _result;
  }
  Future<dynamic> UserHasAccount(String phone ) async {
    print(phone);
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/Accounts/UserHasAccount';

    Map map ={
      "phone": phone,
    };
    var itemCount ;
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print(response.statusCode);
     print(reply);
    var jsonResponse = convert.jsonDecode(reply);
    // if (reply == "Name +966111122222 is already taken.") {
    //   itemCount="Name +966111122222 is already taken.";
    // }else{
    //   itemCount = jsonResponse['result'];}

   // dynamic itemCount2 = jsonResponse;
    print(jsonResponse['data']['hasAccount']);
   // HelperFunctions.saveUserEmailSharedPreference(itemCount);
    return jsonResponse;
  }
  Future<dynamic> Login(String phone,String pass) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/Accounts/Login';

    Map map ={
    "phone": phone,
    "password": pass
    };
    var itemCount ;
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print(response.statusCode);
    print(reply);
    var jsonResponse = convert.jsonDecode(reply);
    return jsonResponse;
    if (reply == "Name +966111122222 is already taken.") {
      itemCount="Name +966111122222 is already taken.";
    }else{
      itemCount = jsonResponse['result'];}

    dynamic itemCount2 = jsonResponse;

    // HelperFunctions.saveUserEmailSharedPreference(itemCount);
    return itemCount;
  }
  Future<dynamic> Register(String name,String password,String confirmPassword,String email,String phone,
      int gender, birthDate,int generatedCode,String base64Image,countryId) async {
    print("$phone"+"${generatedCode}");
    print(name);
    print(password);
    print(gender);
    print(birthDate);
    print(base64Image);
    print(countryId);
    print(email);
    print(name);

    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/Accounts/Register';

    Map map ={
      "id": 0,
      "name": name,
      "password": password,
      "confirmPassword": confirmPassword,
      "email": email,
      "phone": phone,
      "gender": gender,
      "birthDate": birthDate,
      "countryId": countryId,
      "imageName": base64Image,
      "generatedCode": generatedCode
    };
    var itemCount ;
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print(response.statusCode);
    print(reply);
    var jsonResponse = convert.jsonDecode(reply);
    return jsonResponse['message'];
    if (reply == "Name +966111122222 is already taken.") {
      itemCount="Name +966111122222 is already taken.";
    }else{
      itemCount = jsonResponse['result'];}

    dynamic itemCount2 = jsonResponse;

    // HelperFunctions.saveUserEmailSharedPreference(itemCount);
    return itemCount;
  }

  Future<dynamic> Countries() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/Countries/GetAll';

    var itemCount ;
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
   // request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print(response.statusCode);
    print(reply);
    var jsonResponse = convert.jsonDecode(reply);

    return jsonResponse['message'];
    if (reply == "Name +966111122222 is already taken.") {
      itemCount="Name +966111122222 is already taken.";
    }else{
      itemCount = jsonResponse['result'];}

    dynamic itemCount2 = jsonResponse;

    // HelperFunctions.saveUserEmailSharedPreference(itemCount);
    return itemCount;
  }
}