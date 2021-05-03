import 'package:http/http.dart';

class APIServices{
  static String dogadjajURL="http://127.0.0.1:62743/api/Dogadjajs";

  static Future uzmiBDogadjaj() async{
    return await get(dogadjajURL);
  }
}