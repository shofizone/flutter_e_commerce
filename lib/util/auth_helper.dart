import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class AuthHelper{

  static  String baseUrl = "http://192.168.0.106:1337";
  static String loginUrl = baseUrl+"/auth/local";
  static String registrationUrl = baseUrl+"/auth/local/register";

  Future<http.Response> login(email,password)async{
    http.Response response =  await  http.post(loginUrl,body: {
      "identifier": email,
      "password": password
    });

    return response;
  }

  Future<http.Response> register(username,email,password)async{

    http.Response response =  await  http.post(registrationUrl,body: {
      "username": username,
      "email": email,
      "password": password
    });

    return response;
  }

  storeUserData(responseData) async{
    final pref = await SharedPreferences.getInstance();
    Map<String,dynamic> user = responseData['user'];
    user.putIfAbsent("jwt", ()=>responseData["jwt"]);
    pref.setString('user',json.encode(user));
  }

  getUser() async{
    final pref = await SharedPreferences.getInstance();
    var storedUSer = pref.getString("user");
    var data = json.decode(storedUSer);
    print(data);
  }

}

AuthHelper authHelper = AuthHelper();