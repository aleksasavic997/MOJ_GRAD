import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class UserData
{
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

  UserData(name, lastname, username, password, email, phone, cityId, profilePhoto, userTypeID, isLogged)
  {
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

  Map<String, dynamic> toMap() 
  {
    var map = Map<String, dynamic>();
    if(id != null)
      map['id'] = id;
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

  UserData.fromObject(dynamic o) 
  {
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

  static Future<String> checkUser(String userName, String password) async {
    String url = "http://10.0.2.2:58482/api/UserDatas/login";

    var data = Map();
    data['username'] = userName;
    data['password'] = password;

    var jsonBody = convert.jsonEncode(data);
    var res = await http.post(url, headers: header, body: jsonBody);
    String data2 = res.body.toString();
    return data2;
  }

  
  static bool isPhone(String phone) {
    RegExp phoneCorrect = new RegExp(r'^\+?[0-9]{1,20}$');
    return phoneCorrect.hasMatch(phone);
  }

  static bool isPass(String pass) {
    RegExp passCorrect = new RegExp(
      r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{8,}$'); //sadrzi najmanje jedno slovo, najmanje jedan broj i 8 ili vise karaktera

  return passCorrect.hasMatch(pass);
  }
}