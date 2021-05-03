import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Korisnik{
  int id;
  String ime;
  String prezime;
  String email;
  String lozinka;

  Korisnik(ime, prezime, email, lozinka) {
    this.ime = ime;
    this.prezime = prezime;
    this.email = email;
    this.lozinka = lozinka;
  }

  Korisnik.id(id, ime, prezime, email, lozinka)
  {
    this.id = id;
    this.ime = ime;
    this.prezime = prezime;
    this.email = email;
    this.lozinka = lozinka;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if(id != null)
      map['id'] = id;
    map['ime'] = ime;
    map['prezime'] = prezime;
    map['email'] = email;
    map['lozinka'] = lozinka;
    return map;
  }

  Korisnik.fromObject(dynamic o) {
    this.id = o['id'];
    this.ime = o['ime'];
    this.prezime = o['prezime'];
    this.email = o['email'];
    this.lozinka = o['lozinka'];
  }

  static Map<String, String> header = {
    'Content-type' : 'application/json',
    'Accept' : 'application/json'
  };

  static Future<String> proveriKorisnika(String email, String password) async {
    String url = "http://10.0.2.2:54794/api/Korisniks/login";

    var data = Map();
    data['email'] = email;
    data['lozinka'] = password;
    var jsonBody = convert.jsonEncode(data);
    //print(jsonBody);
    var res = await http.post(url, headers: header, body: jsonBody);
    String data_2 = res.body.toString();
    //print(data_2);
    return data_2;
  }

    static Future<String> proveriEmail(String email) async {
    String url = "http://10.0.2.2:54794/api/Korisniks/email";

    var data = Map();
    data['email'] = email;
    var jsonBody = convert.jsonEncode(data);
    //print(jsonBody);
    var res = await http.post(url, headers: header, body: jsonBody);
    String data_2 = res.body.toString();
    //print(data_2);
    return data_2;
  }
  
  static Future<bool> registrujKorisnika(Korisnik korisnik) async {
    String url = "http://10.0.2.2:54794/api/Korisniks";
    var korisnikMap = korisnik.toMap();
    var jsonBody = convert.jsonEncode(korisnikMap);
    var proveraMejla = (await proveriEmail(korisnik.email)).toString();
    if(proveraMejla == "true")
      return false;
    else {
      var res = await http.post(url, headers: header, body: jsonBody);
      return true;
    }
  }

}