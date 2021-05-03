import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:mojgradapp/config/config.dart';

class UserData {
  int id;
  String name;
  String lastname;
  String username;
  String password;
  String email;
  String phone;
  int cityId;
  String profilePhoto;
  int userTypeID;
  bool isLogged;

  int get getId => id;

  set setId(int id) => this.id = id;

  String get getName => name;

  set setName(String name) => this.name = name;

  String get getLastname => lastname;

  set setLastname(String lastname) => this.lastname = lastname;

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

  UserData(name, lastname, username, password, email, phone, cityId,
      profilePhoto, userTypeID, isLogged) {
    this.name = name;
    this.lastname = lastname;
    this.username = username;
    this.password = password;
    this.email = email;
    this.phone = phone;
    this.cityId = cityId;
    this.profilePhoto = profilePhoto;
    this.userTypeID = userTypeID;
    this.isLogged = isLogged;
  }

  UserData.id(id, name, lastname, username, password, email, phone, cityId,
      profilePhoto, userTypeID, isLogged) {
    this.id = id;
    this.name = name;
    this.lastname = lastname;
    this.username = username;
    this.password = password;
    this.email = email;
    this.phone = phone;
    this.cityId = cityId;
    this.profilePhoto = profilePhoto;
    this.userTypeID = userTypeID;
    this.isLogged = isLogged;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) map['id'] = id;
    map['name'] = name;
    map['lastname'] = lastname;
    map['username'] = username;
    map['password'] = password;
    map['email'] = email;
    map['phone'] = phone;
    map['cityID'] = cityId;
    map['profilePhotoPath'] = profilePhoto;
    map['userTypeID'] = userTypeID;
    map['isLogged'] = isLogged;
    return map;
  }

  UserData.fromObject(dynamic o) {
    this.id = o['id'];
    this.name = o['name'];
    this.lastname = o['lastname'];
    this.username = o['username'];
    this.password = o['password'];
    this.email = o['email'];
    this.phone = o['phone'];
    this.cityId = o['cityID'];
    this.profilePhoto = o['profilePhotoPath'];
    this.userTypeID = o['userTypeID'];
    this.isLogged = o['isLogged'];
  }
  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  static Future<String> checkUser(String username, String password) async {
    int userTypeID = 1;
    String url = loginURL + "/UserTypeID=" + userTypeID.toString();

    var data = Map();
    data['username'] = username;
    data['password'] = password;

    var jsonBody = convert.jsonEncode(data);
    var res = await http.post(url, headers: header, body: jsonBody);
    String data2 = res.body.toString();
    if (res.statusCode != 200) return ('false');
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

  static Future<bool> registration(UserData user) async {
    print("aahahahah");
    String url = userDataURL;
    var data = user.toMap();
    var jsonBody = convert.jsonEncode(data);
    print(jsonBody);
    var email = (await checkEmail(user.email)).toString();
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

  static bool isNameOrLastName(String name) {
    RegExp nameCorrect = new RegExp(r'^[a-zA-ZŠĐĆČŽšđžčć]{1,20}$');
    return nameCorrect.hasMatch(name);
  }

  static bool isPhone(String phone) {
    RegExp phoneCorrect = new RegExp(r'^\+?[0-9]{1,20}$');
    return phoneCorrect.hasMatch(phone);
  }

  static bool isPass(String pass) {
    RegExp passCorrect = new RegExp(
        r'^(?=.*[0-9]+.*)(?=.*[a-zA-ZŠĐĆČŽšđžčć]+.*)[0-9a-zA-ZŠĐĆČŽšđžčć]{8,}$'); //sadrzi najmanje jedno slovo, najmanje jedan broj i 8 ili vise karaktera

    return passCorrect.hasMatch(pass);
  }
}
