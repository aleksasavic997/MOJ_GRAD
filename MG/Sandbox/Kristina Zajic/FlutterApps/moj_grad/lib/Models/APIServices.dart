import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mojgrad/Models/Automobil.dart';

class APIServices {
  static String carUrl="http://10.0.2.2:60777/api/Automobils";

  static Future fetchCars() async
  {
    return await http.get(carUrl);
  }
/*
  static Future<List<Automobil>> fetchAutomobile() async
  {
    http.Response response = await http.get('http://10.0.2.2:60777/Api/Automobils');

    if(response.statusCode == 200)
    {
      var data = jsonDecode(response.body);
      List<Automobil> carsList = new List<Automobil>();

      for(var car in data)
      {
        carsList.add(Automobil.fromObject(car));
      }
      return carsList;
    }
  }

  static Map<String,String> header = {
    'Content-type' : 'application/json',
    'Accept' : 'application/json'
  };

  static Future<bool> postCar(Automobil car) async
  {
    var myCar = car.toMap();
    var carBody = json.encode(myCar);
    var myResponse = await http.post(carUrl, headers: header, body: carBody);
    return Future.value(myResponse.statusCode == 200 ? true : false);
  }

  static Future<bool> deleteCar(int id) async
  {
    var myResponse = await http.delete(carUrl + id.toString(),headers: header);
    print(carUrl + id.toString());
    return Future.value(myResponse.statusCode == 200 ? true : false);
  }
  */

}