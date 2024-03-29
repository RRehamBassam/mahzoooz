import 'package:http/http.dart' as http;
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:mahzoooz/api/ServerAddresses.dart';
import 'dart:convert';
import 'dart:ui';
import 'dart:convert' as convert;
import 'dart:io';


import 'package:mahzoooz/services/helperFunctions.dart';
class NetworkRequest{
  static final NetworkRequest _instance = NetworkRequest._internal();
  factory NetworkRequest() => _instance;

  NetworkRequest._internal();
  Future<String> register() async {
    // String _result;

    try {
      final response = await http.post(
          Uri.parse( ServerAddresses.serverAddress + ServerAddresses.register),
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
          Uri.parse( ServerAddresses.serverAddress + ServerAddresses.Login),
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
          Uri.parse( ServerAddresses.serverAddress + ServerAddresses.UserHasAccount),
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
  Future<dynamic> SendOtp(String phone ) async {
    print(phone);
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/Accounts/SendOtp';
    print("sendotp");
    Map map ={
      "phone": phone,
    };
    String username = 'mahzoooz';
    String password = 'Mahzoooz@123';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var itemCount ;
    try {
      HttpClientRequest request = await client.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json'); //headers: <String, String>{'authorization': basicAuth}
      request.headers.set('authorization', basicAuth);
      request.add(convert.utf8.encode(convert.json.encode(map)));
      HttpClientResponse response = await request.close();
      String reply = await response.transform(convert.utf8.decoder).join();
      print(response.statusCode);
      print(reply);
      print("sendotp");
      var jsonResponse = convert.jsonDecode(reply);
      // if (reply == "Name +966111122222 is already taken.") {
      //   itemCount="Name +966111122222 is already taken.";
      // }else{
      //   itemCount = jsonResponse['result'];}

      // dynamic itemCount2 = jsonResponse;
      print(jsonResponse['data']['hasAccount']);
      // HelperFunctions.saveUserEmailSharedPreference(itemCount);
      return jsonResponse;
    }catch(e){
      print("sendotp");
      print(e);
    }
  }

  Future<dynamic> Login(String phone,String pass,token) async {
    print(" $token token token token");
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/Accounts/Login';

    Map map ={
    "phone": phone,
    "password": pass,
      "token":token
    };
    var itemCount ;
    try {
      HttpClientRequest request = await client.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.add(convert.utf8.encode(convert.json.encode(map)));
      HttpClientResponse response = await request.close();
      String reply = await response.transform(convert.utf8.decoder).join();
      print(response.statusCode);
      print(reply);
      var jsonResponse = convert.jsonDecode(reply);
      HelperFunctions.saveUserEmailSharedPreference(
          jsonResponse['data']['token']);
      HelperFunctions.saveUserLoggedInSharedPreference(true);
      return jsonResponse;
    }
    catch(e){
      return {"data":null,"status":"NotFound","message":"عفوا كلمة المرور غير صحيحة","exception":null};
    }
    // if (reply == "Name +966111122222 is already taken.") {
    //   itemCount="Name +966111122222 is already taken.";
    // }else{
    //   itemCount = jsonResponse['result'];}
    //
    // dynamic itemCount2 = jsonResponse;
    //
    // // HelperFunctions.saveUserEmailSharedPreference(itemCount);
    // return itemCount;
  }
  Future<dynamic> resetPass(String phone,String pass,code) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/Accounts/ResetPassword';
    String username = 'mahzoooz';
    String password = 'Mahzoooz@123';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    Map map ={
      "phone": phone,
      "code": code,
      "password":pass,
      "confirmPassword": pass
    };
    var itemCount ;
    try {
      HttpClientRequest request = await client.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
     // request.headers.set('content-type', 'application/json'); //headers: <String, String>{'authorization': basicAuth}
      request.headers.set('authorization', basicAuth);
      request.add(convert.utf8.encode(convert.json.encode(map)));

      HttpClientResponse response = await request.close();
      String reply = await response.transform(convert.utf8.decoder).join();
      print(response.statusCode);
      print("qqq");
      print(reply);
      var jsonResponse = convert.jsonDecode(reply);
      HelperFunctions.saveUserEmailSharedPreference(
          jsonResponse['data']['token']);
      HelperFunctions.saveUserLoggedInSharedPreference(true);
      return jsonResponse;
    }
    catch(e){
      return {"data":null,"status":"NotFound","message":"عفوا كلمة المرور غير صحيحة","exception":null};
    }
    // if (reply == "Name +966111122222 is already taken.") {
    //   itemCount="Name +966111122222 is already taken.";
    // }else{
    //   itemCount = jsonResponse['result'];}
    //
    // dynamic itemCount2 = jsonResponse;
    //
    // // HelperFunctions.saveUserEmailSharedPreference(itemCount);
    // return itemCount;
  }
  Future<dynamic> Register(String name,String password,String confirmPassword,String email,String phone,
      int gender, birthDate,int generatedCode, base64Image,countryId) async {
    print("$phone"+"${generatedCode}");
    print(name);
    print(password);
    print(gender);//null
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
      "imageName":base64Image== "data:image/jpeg;base64,null"?null:'$base64Image',
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
    HelperFunctions.saveUserEmailSharedPreference(jsonResponse['data']['token']);
    HelperFunctions.saveUserLoggedInSharedPreference(true);
    return jsonResponse['message'];
  }
  Future<dynamic> UpdateUserProfile(id,String name,String password,String confirmPassword,String email,String phone,
       gender, birthDate, base64Image,countryId) async {
    await HelperFunctions.getUserEmailSharedPreference().then((value){
      token  = value ;
    });
    print("kkk");
    print(name);
    print(password);
    print(gender);//null
    print(birthDate);
    print(base64Image);
    print(countryId);
    print(email);
    print(name);

    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/Users/UpdateUserProfile';

    Map map =  {
      "id":id,
      "name": name,
      "email": email,
      "gender": gender,
      "birthDate": birthDate,
      "countryId": countryId,
      "imageBase64":base64Image,
      "image": null

    };
    var itemCount ;

      HttpClientRequest request = await client.putUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.headers.set('Authorization', 'Bearer $token');
      request.headers.set('content-type', 'application/json');
      request.add(convert.utf8.encode(convert.json.encode(map)));
      HttpClientResponse response = await request.close();
      String reply = await response.transform(convert.utf8.decoder).join();
      print(response.statusCode);
      print(reply);
      var jsonResponse = convert.jsonDecode(reply);


      return jsonResponse['message'];

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
  }
  Future<dynamic> OfferGetDetails(id) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/Offers/GetDetails/${id}';

    var itemCount ;
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    // request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print(response.statusCode);
    print(reply);
    var jsonResponse = convert.jsonDecode(reply);

    return jsonResponse['data'];
  }
  Future<dynamic> SettingsGetAll() async {
    HttpClient client = new HttpClient();
    print("${translator.currentLanguage} lololololo");
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/Settings/GetAll';

    var itemCount ;
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.headers.set('lang', '${translator.currentLanguage}');
    // request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print(response.statusCode);
    print(reply);
    var jsonResponse = convert.jsonDecode(reply);

    return jsonResponse['data'];
  }
  Future<dynamic> Copy(id) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/Offers/UpdateLastUse/${id}';
       print(id);
    var itemCount ;
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    // request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print(response.statusCode);
    print(reply);
    var jsonResponse = convert.jsonDecode(reply);

    return jsonResponse['data'];
  }
 // http://ahmed453160-001-site1.etempurl.com/Offers/UpdateLastUse/1
  Stream<dynamic> OffersGetPagedSearch(bool isSpecial,String searchText) async* {


    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/Offers/GetPaged';

    Map map ={
      "pageNumber": 1,
      "pageSize": 10,
      "filter": {
        "searchText": "",
        "isSpecial": null,
        "latitude": "24.75007441712588",
        "longitude": "46.775951958232405"
      }
    };
    var itemCount ;
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print(response.statusCode);  var jsonResponse = convert.jsonDecode(reply);
    print(jsonResponse['data']['data']);

   // return jsonResponse['data']['data'];

  }

  Future<dynamic> OffersGetPaged(bool isSpecial,String searchText,lat,long,colId) async {
print(colId);

print('ppp2 ${colId}');
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/Offers/GetPaged';
    Map map={
      "pageNumber": 1,
      "pageSize": 10,
      "filter": {
        "searchText": "",
        "isSpecial": isSpecial,
        "orderByIsClosest":colId=="1"?true: false,
        "latitude": lat,
        "longitude": long
      },
      "orderByValue": [
        {
          "colId": colId=="1"?"CreatedDate":"$colId",
          "sort": "desc"
        }
      ]
    };
      // if(colId=="1"){
      //    map ={
      //     "pageNumber": 1,
      //     "pageSize": 10,
      //     "filter": {
      //       "searchText": "",
      //       "isSpecial": isSpecial,
      //       "orderByIsClosest":true,
      //       // "latitude": "24.75007441712588",
      //       // "longitude": "46.775951958232405"
      //       "latitude": lat,
      //       "longitude": long
      //     },
      //      "orderByValue": [
      //        {
      //          "colId": "$colId",
      //          "sort": "desc"
      //        }
      //      ],
      //   };
      // }else{
      //    map ={
      //     "pageNumber": 1,
      //     "pageSize": 10,
      //     "filter": {
      //       "searchText": "",
      //       "isSpecial": isSpecial,
      //       // "latitude": "24.75007441712588",
      //       // "longitude": "46.775951958232405"
      //       "latitude": lat,
      //       "longitude": long
      //     },
      //      "orderByValue": [
      //        {
      //          "colId": "IsBestOffer",
      //          "sort": "desc"
      //        }
      //      ],
      //   };
      // }

    var itemCount ;
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print(response.statusCode);  var jsonResponse = convert.jsonDecode(reply);
    print(jsonResponse['data']['data']);

    return jsonResponse['data']['data'];

  }
  Future<dynamic> CancelBooking(id) async {
    await HelperFunctions.getUserEmailSharedPreference().then((value){
      token  = value ;
    });

    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/BookingSettings/CancelBooking/${id}';

    var itemCount ;
    HttpClientRequest request = await client.deleteUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.headers.set('Authorization', 'Bearer $token');
   // request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print(response.statusCode);  var jsonResponse = convert.jsonDecode(reply);
   // print(jsonResponse['data']['data']);

    return jsonResponse;

  }
  Future<dynamic> CancelBookingSchool(id) async {
    await HelperFunctions.getUserEmailSharedPreference().then((value){
      token  = value ;
    });

    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/SchoolCoupons/CancelCoupon/${id}';

    var itemCount ;
    HttpClientRequest request = await client.deleteUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.headers.set('Authorization', 'Bearer $token');
    // request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print(response.statusCode);  var jsonResponse = convert.jsonDecode(reply);
    // print(jsonResponse['data']['data']);

    return jsonResponse;

  }
  Future<dynamic> OffersGetPagedS(bool isSpecial,String searchText,latLnglocation) async {

    // print(latLnglocation.longitude);
    // print(latLnglocation.latitude);
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/Offers/GetPaged';

    Map map ={
      "pageNumber": 1,
      "pageSize": 10,
      "filter": {
        "searchText": searchText,

        "latitude": latLnglocation.latitude,
        "longitude": latLnglocation.longitude
      }
    };
    var itemCount ;
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
  var jsonResponse = convert.jsonDecode(reply);


    return jsonResponse['data']['data'];

  }
  Future<dynamic> OffersFavourites(bool isSpecial) async {

    await HelperFunctions.getUserEmailSharedPreference().then((value){
      token  = value ;
    });
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/Offers/GetPaged';

    Map map ={
      "pageNumber": 1,
      "pageSize": 10,
      "filter": {
        "isFavourite": true,
        "latitude": "24.75007441712588",
        "longitude": "46.775951958232405"
      }
    };
    var itemCount ;
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.headers.set('Authorization', 'Bearer $token');
    request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    var jsonResponse = convert.jsonDecode(reply);


    return jsonResponse['data']['data'];

  }
  String token ;
  Future<dynamic> CategoriesGetPaged(latitude,long) async {

    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/Categories/GetPaged';

    Map map ={
      "pageNumber": 1,
      "pageSize": 10,
      "filter": {
        "name": "",
        "latitude": latitude,
        "longitude": long
      },


    };
    var itemCount ;
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
   var jsonResponse = convert.jsonDecode(reply);


    return jsonResponse['data']['data'];

  }
  double lat;
  double lng;
  Future<dynamic> subCategoriesGetPaged(id,latLnglocation) async {

    await HelperFunctions.getUserLatInSharedPreference().then((value){

        lat  = value;

    });
    await HelperFunctions.getUserLngSharedPreference().then((value){

        lng  = value;
        //latLnglocation=LatLng(lat ==null?1:lat,lng==null?1:lng);

    });
print(id);
print("ppp");

    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/Offers/GetPaged';

    Map map ={
      "pageNumber": 1,
      "pageSize": 10,
      "filter": {
        "categoryId": id,
        "latitude":lat,
        "longitude":lng

      },


    };
    var itemCount ;
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    var jsonResponse = convert.jsonDecode(reply);
print("pp");
print(response.statusCode);
    return jsonResponse['data'];

  }
  Future<dynamic> AddBooking(bookingTime, dayDate,numberOfPerson ,occasion,SpecialRequest,id) async {//String bookingTime, dayDate,numberOfPerson ,occasion
    await HelperFunctions.getUserEmailSharedPreference().then((value){
      token  = value ;
    });

    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/BookingSettings/AddBooking';

    Map map ={
      "bookingTime": bookingTime,
      "dayDate": dayDate,
      "numberOfPerson":numberOfPerson,
      "occasion": occasion,
      "notes": SpecialRequest,
      "offerId":id
    };


   try{
     HttpClientRequest request = await client.postUrl(Uri.parse(url));
     request.headers.set('content-type', 'application/json');
     request.headers.set('Authorization', 'Bearer $token');
     request.add(convert.utf8.encode(convert.json.encode(map)));
     HttpClientResponse response = await request.close();
     String reply = await response.transform(convert.utf8.decoder).join();

     var jsonResponse = convert.jsonDecode(reply);
     if(jsonResponse['status']=="Conflict"){

       return jsonResponse['data']['numberOfPerson'];
     }else if(jsonResponse['status']=="Created"){

       return 'ok';
     }
     return "no";
     //
     // if(response.statusCode!=200&&response.statusCode!=201 ){
     //
     //   print("Ok"); print(response.statusCode);
     //   print(jsonResponse);
     //   return "notOk";
     // }
     //
     // print("Ok"); print(response.statusCode);
     // print(jsonResponse);
     // return "ok";

   }catch(v){
     // Fluttertoast.showToast(
     //     msg: "لم تتم الحجز",
     //     toastLength: Toast.LENGTH_SHORT,
     //     gravity: ToastGravity.BOTTOM,
     //     timeInSecForIosWeb: 1,
     //     backgroundColor: Color(0xff38056e).withOpacity(0.9),
     //     textColor: Color(0xffffffff),
     //     fontSize: 16.0
     // );
     print(v);
   }


  }
  Future<dynamic> getProfile() async {//String bookingTime, dayDate,numberOfPerson ,occasion
    await HelperFunctions.getUserEmailSharedPreference().then((value){
      token  = value ;
    });
    //print(" $bookingTime, $dayDate,$numberOfPerson ,$occasion,$SpecialRequest");


    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/Users/GetUserProfile';
    try{
      HttpClientRequest request = await client.getUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.headers.set('Authorization', 'Bearer $token');
      //request.add(convert.utf8.encode(convert.json.encode(map)));
      HttpClientResponse response = await request.close();
      String reply = await response.transform(convert.utf8.decoder).join();

      var jsonResponse = convert.jsonDecode(reply);
      if(jsonResponse['status']=="OK"){
        print(jsonResponse['data']);
        return jsonResponse['data'];
      }else {
       // print(jsonResponse['status']);
        return jsonResponse['message'];
      }
      return "no";
      //
      // if(response.statusCode!=200&&response.statusCode!=201 ){
      //
      //   print("Ok"); print(response.statusCode);
      //   print(jsonResponse);
      //   return "notOk";
      // }
      //
      // print("Ok"); print(response.statusCode);
      // print(jsonResponse);
      // return "ok";

    }catch(v){
      // Fluttertoast.showToast(
      //     msg: "لم تتم الحجز",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Color(0xff38056e).withOpacity(0.9),
      //     textColor: Color(0xffffffff),
      //     fontSize: 16.0
      // );
      print(v);
    }


  }
  Future<dynamic> getLuck(latLnglocation) async {//String bookingTime, dayDate,numberOfPerson ,occasion
    await HelperFunctions.getUserEmailSharedPreference().then((value){
      token  = value ;
    });

   print(" ${latLnglocation.latitude}  yyyyyyyy ${latLnglocation.longitude}");

    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/Offers/GetRandomOffers';
    Map map ={
    // "latitude": "24.75007441712588",
    // "longitude": "46.775951958232405"
      "latitude": "${latLnglocation.latitude}",
      "longitude": "${latLnglocation.longitude}"
    };


      HttpClientRequest request = await client.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
    request.headers.set('lang', '${translator.currentLanguage}');
      request.headers.set('Authorization', 'Bearer $token');

      request.add(convert.utf8.encode(convert.json.encode(map)));
      HttpClientResponse response = await request.close();
      String reply = await response.transform(convert.utf8.decoder).join();
      print(reply);
      var jsonResponse = convert.jsonDecode(reply);
      if(jsonResponse['status']=="OK"){
        print(" ${jsonResponse['data']} qwqwqqqqqqq");
        print(jsonResponse['status']);
        return jsonResponse['data'];
      }else {
        print(jsonResponse['status']);
        return jsonResponse['message'];
      }
      return "no";
      //
      // if(response.statusCode!=200&&response.statusCode!=201 ){
      //
      //   print("Ok"); print(response.statusCode);
      //   print(jsonResponse);
      //   return "notOk";
      // }
      //
      // print("Ok"); print(response.statusCode);
      // print(jsonResponse);
      // return "ok";


  }
  Future<dynamic> AddFavourites(tableId) async {//String bookingTime, dayDate,numberOfPerson ,occasion
    await HelperFunctions.getUserEmailSharedPreference().then((value){
      token  = value ;
    });
   // print(" $bookingTime, $dayDate,$numberOfPerson ,$occasion,$SpecialRequest");
    print(token);
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/Favourites/Add';
  //  print(id);
    Map map ={
      "id": 0,
      "tableId": tableId,
      "favouriteType": 0
    };


    try{
      HttpClientRequest request = await client.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.headers.set('Authorization', 'Bearer $token');
      request.add(convert.utf8.encode(convert.json.encode(map)));
      HttpClientResponse response = await request.close();
      String reply = await response.transform(convert.utf8.decoder).join();
      print(reply);
      var jsonResponse = convert.jsonDecode(reply);
      if(jsonResponse['status']=="Created"){
        print(jsonResponse['status']);
        return jsonResponse['message'];
      }
      return jsonResponse['message'];
      //
      // if(response.statusCode!=200&&response.statusCode!=201 ){
      //
      //   print("Ok"); print(response.statusCode);
      //   print(jsonResponse);
      //   return "notOk";
      // }
      //
      // print("Ok"); print(response.statusCode);
      // print(jsonResponse);
      // return "ok";

    }catch(v){
      // Fluttertoast.showToast(
      //     msg: "لم تتم الحجز",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Color(0xff38056e).withOpacity(0.9),
      //     textColor: Color(0xffffffff),
      //     fontSize: 16.0
      // );
      print(v);
    }


  }
  Future<dynamic> AddRate(comment,rate,offerId) async {//String bookingTime, dayDate,numberOfPerson ,occasion
    await HelperFunctions.getUserEmailSharedPreference().then((value){
      token  = value ;
    });
    print(" $comment, $rate,$offerId lll");
    print(token);
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/Offers/AddRate';
    //  print(id);
    Map map ={

      "commentrate":comment,
      "rate":rate ,
      "offerId": offerId
    };


    try{
      HttpClientRequest request = await client.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.headers.set('Authorization', 'Bearer $token');
      request.add(convert.utf8.encode(convert.json.encode(map)));
      HttpClientResponse response = await request.close();
      String reply = await response.transform(convert.utf8.decoder).join();
      print(reply);
      var jsonResponse = convert.jsonDecode(reply);
      if(jsonResponse['status']=="Created"){
        print(jsonResponse['status']);
        return jsonResponse['message'];
      }
      return jsonResponse['message'];
      //
      // if(response.statusCode!=200&&response.statusCode!=201 ){
      //
      //   print("Ok"); print(response.statusCode);
      //   print(jsonResponse);
      //   return "notOk";
      // }
      //
      // print("Ok"); print(response.statusCode);
      // print(jsonResponse);
      // return "ok";

    }catch(v){
      // Fluttertoast.showToast(
      //     msg: "لم تتم الحجز",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Color(0xff38056e).withOpacity(0.9),
      //     textColor: Color(0xffffffff),
      //     fontSize: 16.0
      // );
      print(v);
    }


  }
  Future<dynamic> MyBooking() async {//String bookingTime, dayDate,numberOfPerson ,occasion
    await HelperFunctions.getUserEmailSharedPreference().then((value){
      token  = value ;
    });
   // print(" $bookingTime, $dayDate,$numberOfPerson ,$occasion,$SpecialRequest");
    print(token);
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/BookingSettings/GetMyBooking';
   // print(id);
    Map map ={
      "pageNumber": 1,
      "pageSize": 10,
      "filter": "",
      "orderByValue": [
        // {
        //   "colId": "string",
        //   "sort": "string"
        // }
      ]
    };


    try{
      HttpClientRequest request = await client.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.headers.set('Authorization', 'Bearer $token');
      request.add(convert.utf8.encode(convert.json.encode(map)));
      HttpClientResponse response = await request.close();
      String reply = await response.transform(convert.utf8.decoder).join();
      print(reply);
      var jsonResponse = convert.jsonDecode(reply);
      return jsonResponse['data']['data'];

      //
      // if(response.statusCode!=200&&response.statusCode!=201 ){
      //
      //   print("Ok"); print(response.statusCode);
      //   print(jsonResponse);
      //   return "notOk";
      // }
      //
      // print("Ok"); print(response.statusCode);
      // print(jsonResponse);
      // return "ok";

    }catch(v){
      // Fluttertoast.showToast(
      //     msg: "لم تتم الحجز",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Color(0xff38056e).withOpacity(0.9),
      //     textColor: Color(0xffffffff),
      //     fontSize: 16.0
      // );
      print(v);
    }


  }
  Future<dynamic> GetMyCoupons() async {//String bookingTime, dayDate,numberOfPerson ,occasion
    await HelperFunctions.getUserEmailSharedPreference().then((value){
      token  = value ;
    });
    // print(" $bookingTime, $dayDate,$numberOfPerson ,$occasion,$SpecialRequest");
    print(token);
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/SchoolCoupons/GetMyCoupons';
    // print(id);
    Map map ={
      "pageNumber": 1,
      "pageSize": 10,
      "filter": "",
      "orderByValue": [

      ]
    };


    try{
      HttpClientRequest request = await client.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.headers.set('Authorization', 'Bearer $token');
      request.add(convert.utf8.encode(convert.json.encode(map)));
      HttpClientResponse response = await request.close();
      String reply = await response.transform(convert.utf8.decoder).join();
      print(reply);
      var jsonResponse = convert.jsonDecode(reply);
      return jsonResponse['data']['data'];

      //
      // if(response.statusCode!=200&&response.statusCode!=201 ){
      //
      //   print("Ok"); print(response.statusCode);
      //   print(jsonResponse);
      //   return "notOk";
      // }
      //
      // print("Ok"); print(response.statusCode);
      // print(jsonResponse);
      // return "ok";

    }catch(v){
      // Fluttertoast.showToast(
      //     msg: "لم تتم الحجز",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Color(0xff38056e).withOpacity(0.9),
      //     textColor: Color(0xffffffff),
      //     fontSize: 16.0
      // );
      print(v);
    }


  }
  Future<dynamic> SchoolCouponsAdd(expireDate,branchId,list) async {//String bookingTime, dayDate,numberOfPerson ,occasion
    await HelperFunctions.getUserEmailSharedPreference().then((value){
      token  = value ;
    });
  //  print(" $bookingTime, $dayDate,$numberOfPerson ,$occasion,$SpecialRequest");
    print(token);
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='http://ahmed453160-001-site1.etempurl.com/SchoolCoupons/Add';
   // print(id);
    Map map ={
      "id": 0,
      "notes": "string",
      "expireDate": expireDate,
      "offerId": branchId,
      "schoolCouponStudents":list
    };
    try{
      HttpClientRequest request = await client.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.headers.set('Authorization', 'Bearer $token');
      request.add(convert.utf8.encode(convert.json.encode(map)));
      HttpClientResponse response = await request.close();
      String reply = await response.transform(convert.utf8.decoder).join();
      var jsonResponse = convert.jsonDecode(reply);
      if(response.statusCode!=200&&response.statusCode!=201 ){

        print("Ok"); print(response.statusCode);
        print(jsonResponse);
        return "notOk";
      }else if(jsonResponse['status']=='Created'){
        return "Created";
      }
     // var jsonResponse = convert.jsonDecode(reply);
     //  print("Ok"); print(response.statusCode);
     //  print(jsonResponse);
     //  return "ok";

    }catch(v){
      // Fluttertoast.showToast(
      //     msg: "لم تتم الحجز",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Color(0xff38056e).withOpacity(0.9),
      //     textColor: Color(0xffffffff),
      //     fontSize: 16.0
      // );
      print(v);
    }


  }
  Future<String> AddBooking2() async {
    await HelperFunctions.getUserEmailSharedPreference().then((value){
      token  = value ;
    });
    print(token); print(token);
    try {
      final response = await http.post(
          Uri.parse("http://ahmed453160-001-site1.etempurl.com/BookingSettings/AddBooking"),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body:{
          "bookingTime": "18:30:00",
          "dayDate": "2021-04-19T13:00:00.7814678-07:00",
          "numberOfPerson": "5",
          "occasion": "string",
          "notes": "string",
          "branchId":"1"
        },
      );
      print(token);
      print(response.statusCode);
      Map _result;
      bool status;
      print(jsonDecode(response.body).toString());
      if (response.statusCode == 200) {
        _result = jsonDecode(response.body);
        status = _result['status'];
       // HelperFunctions.saveUserNameSharedPreference(name);
        print(status);
        if (status) {
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
}