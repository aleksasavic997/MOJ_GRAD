import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Korisnik
{
  int id;
  String email;
  String password;

  Korisnik(String email, String password)
  {
    this.email = email;
    this.password = password;
  }

  Korisnik.id(int id,String email,String password)
  {
    this.id = id;
    this.email = email;
    this.password = password;
  }

  Map<String,dynamic> toMap()
  {
    var map = Map<String,dynamic>();
    if(id != null)
      map['id'] = id;
    map['email'] = email;
    map['password'] = password;

    return map;
  }

  Korisnik.fromObject(dynamic o)
  {
    this.id = o['id'];
    this.email = o['email'];
    this.password = o['password'];
  }

  static Map<String, String> header = {
    'Content-type' : 'application/json',
    'Accept' : 'application/json'
  };

  static Future<String> checkUser(String email, String password) async {
    String url = "http://10.0.2.2:60777/api/Korisniks/login";
    //String url = "http://10.0.2.2:60777/api/Automobils"; //// /login, gde je route?
    var data = Map();
    data['email'] = email;
    data['password'] = password;
    var jsonBody = convert.jsonEncode(data);
    var myRsponse = await http.post(url, headers: header, body: jsonBody);
    String data2 = myRsponse.body.toString();

    return data2;
  }

  static Future<bool> signUpUser(Korisnik user) async {
    String url = "http://10.0.2.2:60777/api/Korisniks";
    var userMap = user.toMap();
    var jsonBody = convert.jsonEncode(userMap);
    if(checkUser(user.email, user.password).toString() == "true")
      return false;
    else {
      var myRsponse = await http.post(url, headers: header, body: jsonBody);
      return true;
    }
  }
}