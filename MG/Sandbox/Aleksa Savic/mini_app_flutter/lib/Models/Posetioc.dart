import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Posetioc{
  int idPosetioca;
  String ime;
  String prezime;
  String username;
  String password;

  Posetioc(ime, prezime, username, password) {
    this.ime = ime;
    this.prezime = prezime;
    this.username = username;
    this.password = password;
  }

  Posetioc.idPosetioca(idPosetioca, ime, prezime, username,password)
  {
    this.idPosetioca = idPosetioca;
    this.ime = ime;
    this.prezime = prezime;
    this.username = username;
    this.password = password;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if(idPosetioca != null)
      map['idPosetioca'] = idPosetioca;
    map['ime'] = ime;
    map['prezime'] = prezime;
    map['username'] = username;
    map['password'] = password;
    return map;
  }

  Posetioc.fromObject(dynamic o) {
    this.idPosetioca = o['idPosetioca'];
    this.ime = o['ime'];
    this.prezime = o['prezime'];
    this.username = o['username'];
    this.password = o['password'];
  }

  static Map<String, String> header = {
    'Content-type' : 'application/json',
    'Accept' : 'application/json'
  };

  static Future<String> proveriPosetioca(String username, String password) async {
    String url = "http://10.0.2.2:56233/api/Posetiocs/login";

    var data = Map();
    data['username'] = username;
    data['password'] = password;
    var jsonBody = convert.jsonEncode(data);
    //print(jsonBody);
    var res = await http.post(url, headers: header, body: jsonBody);
    String data_2 = res.body.toString();
    //print(data_2);
    return data_2;
  }
  
  static Future<bool> registrujPosetioca(Posetioc posetioc) async {
    String url = "http://10.0.2.2:56233/api/Posetiocs";
    var posetiocMap = posetioc.toMap();
    var jsonBody = convert.jsonEncode(posetiocMap);
    if(proveriPosetioca(posetioc.username, posetioc.password).toString() == "true")
      return false;
    else {
      var res = await http.post(url, headers: header, body: jsonBody);
      return true;
    }
  }

}
