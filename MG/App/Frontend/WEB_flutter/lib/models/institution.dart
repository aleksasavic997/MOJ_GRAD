import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:WEB_flutter/config/config.dart';

class Institution {
  int id;
  String name;
  String username;
  String password;
  String email;
  String phone;
  int cityId;
  String profilePhoto;
  int userTypeID;
  String address;
  bool isVerified;


 int get getId => id;

 set setId(int id) => this.id = id;

 String get getName => name;

 set setName(String name) => this.name = name;

 String get getUsername => username;

 set setUsername(String username) => this.username = username;

 String get getPassword => password;

 set setPassword(String password) => this.password = password;

 String get getEmail => email;

 set setEmail(String email) => this.email = email;

 String get getPhone => phone;

 set setPhone(String phone) => this.phone = phone;

 int get getCityId => cityId;

 set setCityId(int cityId) => this.cityId = cityId;

 String get getProfilePhoto => profilePhoto;

 set setProfilePhoto(String profilePhoto) => this.profilePhoto = profilePhoto;

  Institution(name, username, password, email, phone, cityId, profilePhoto, userTypeID, address, isVerified) {
    this.name = name;
    this.username = username;
    this.password = password;
    this.email = email;
    this.phone = phone;
    this.cityId = cityId;
    this.profilePhoto = profilePhoto;
    this.userTypeID = userTypeID;
    this.address = address;
    this.isVerified = isVerified;
  }

  Institution.id(id, name, username, password, email, phone, cityId, profilePhoto, userTypeID, address, isVerified) {
    this.id = id;
    this.name = name;
    this.username = username;
    this.password = password;
    this.email = email;
    this.phone = phone;
    this.cityId = cityId;
    this.profilePhoto = profilePhoto;
    this.userTypeID = userTypeID;
    this.address = address;
    this.isVerified = isVerified;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) map['id'] = id;
    map['name'] = name;
    map['username'] = username;
    map['password'] = password;
    map['email'] = email;
    map['phone'] = phone;
    map['cityID'] = cityId;
    map['profilePhotoPath'] = profilePhoto;
    map['userTypeID'] = userTypeID;
    map['address'] = address;
    map['isVerified'] = isVerified;
    return map;
  }

  Institution.fromObject(dynamic o) {
    this.id = o['id'];
    this.name = o['name'];
    this.username = o['username'];
    this.password = o['password'];
    this.email = o['email'];
    this.phone = o['phone'];
    this.cityId = o['cityID'];
    this.profilePhoto = o['profilePhotoPath'];
    this.userTypeID = o['userTypeID'];
    this.address = o['address'];
    this.isVerified = o['isVerified'];
  }
  
  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  static Future<String> checkUser(String username, String password) async {
    int userTypeID = 2;
    String url = loginURL + userTypeID.toString();

    var data = Map();
    data['username'] = username;
    data['password'] = password;

    var jsonBody = convert.jsonEncode(data);
    var res = await http.post(url, headers: header, body: jsonBody);
    String data2 = res.body.toString();
    if(res.statusCode != 200)
      return ('false');
    return data2;
  }

  static Future<String> checkEmail(String email) async {
    String url = emailURL;

    var data = Map();
    data['email'] = email;
    var jsonBody = convert.jsonEncode(data);
    //print(jsonBody);
    var res = await http.post(url, headers: header, body: jsonBody);
    String data_2 = res.body.toString();
    //print(data_2);
    return data_2;
  }

  static Future<String> checkUsername(String username) async {
    String url = usernameURL;

    var data = Map();
    data['username'] = username;
    var jsonBody = convert.jsonEncode(data);
    var res = await http.post(url, headers: header, body: jsonBody);
    String data_2 = res.body.toString();
    return data_2;
  }

  static Future<bool> registration(Institution institution) async {
    print("aahahahah");
    String url = userDataURL;
    var data = institution.toMap();
    var jsonBody = convert.jsonEncode(data);
    print(jsonBody);
    var email = (await checkEmail(institution.email)).toString();
    if (email == "true")
      return false;
    else {
      var res = await http.post(url, headers: header, body: jsonBody);
      return true;
    }
  }

  static bool isEmail(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
 
    RegExp regExp = new RegExp(p);
 
    return regExp.hasMatch(email);
  }
}
