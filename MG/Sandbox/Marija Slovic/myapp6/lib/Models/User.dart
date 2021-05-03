import 'dart:convert';
import 'package:http/http.dart';


class User{
  int id;
  String email;
  String password;
  String username;

  User({this.email, this.password, this.username});

  Map<String, dynamic>napraviMap(){
    Map map=Map<String, dynamic>();
    map['id']=id;
    map['email']=email;
    map['password']=password;
    map['username']=username;
    return map;
  }

  User.fromObject(dynamic obj){     //proslediObjekat ili posaljiObjekat
    this.id=obj['id'];
    this.email=obj['email'];
    this.password=obj['password'];
    this.username=obj['username'];
  }

  static Map<String, dynamic> header={
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  static Future<String> daLiPostojiUser(String email, String password) async{
    String url="";

    Map data=Map();     //var
    data['email']=email;
    data['password']=password;
    var jsonBody=jsonEncode(data);
    var t=await post(url, headers: header, body: jsonBody);
    String tBody=t.body.toString();
    return tBody;
  }

  static Future<bool> registracijaUsera(User user) async{
    String url="";
    Map userMap=user.napraviMap();
    var jsonBody=jsonEncode(userMap);

    if(daLiPostojiUser(user.email, user.password).toString() == 'true')
      return false;
    else
    {
      var t=await post(url, headers: header, body: jsonBody);
      return true;
    }
  }
}