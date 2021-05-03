import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Korisnici
{
  int id;
  String ime;
  String prezime;
  String username;
  String password;
  String uloga;

  Korisnici(username, password)
  {
    this.username = username;
    this.password = password;
  }

  /*Korisnici.Detalji(ime, prezime, username, password, uloga)
  {
    this.ime = ime;
    this.prezime = prezime;
    this.username = username;
    this.password = password;
    this.uloga = uloga;
  }*/

  Korisnici.id(id, ime, prezime, username, password, uloga)
  {
    this.id = id;
    this.ime = ime;
    this.prezime = prezime;
    this.username = username;
    this.password = password;
    this.uloga = uloga;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['ime'] = ime;
    map['prezime'] = prezime;
    map['username'] = username;
    map['password'] = password;
    map['uloga'] = uloga;
    return map;
  }

  Korisnici.fromObject(dynamic o) {
    this.id = o['id'];
    this.ime = o['ime'];
    this.prezime = o['prezime'];
    this.username = o['username'];
    this.password = o['password'];
    this.uloga = o['uloga'];
  }

  static Map<String, String> header = {
    'Content-type' : 'application/json',
    'Accept' : 'application/json'
  };

  static Future<String> checkUser(String username, String password) async
  {
    String url = 'http://10.0.2.2:56856/api/Korisnicis/login'; 
    var data = Map();
    data['username'] = username;
    data['password'] = password;
    
    var jsonBody = convert.jsonEncode(data);
    
    var res = await http.post(url, headers: header, body: jsonBody);
    String pod = res.body.toString();
    return pod;
  }

  static Future<bool> registerUser(Korisnici u) async
  {
    String url = 'http://10.0.2.2:56856/api/Korisnicis/';
    var userMap = u.toMap();
    var jsonBody = convert.jsonEncode(userMap);

    if(await checkUser(u.username, u.password).toString() == "true")
      return false;
    else
    {
      var res = await http.post(url, headers: header, body: jsonBody);
      return true;
    }
  } 
}