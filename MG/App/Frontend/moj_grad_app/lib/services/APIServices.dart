import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mojgradapp/config/config.dart';
import 'package:mojgradapp/models/category.dart';
import 'package:mojgradapp/models/sponsor.dart';
import '../config/config.dart';
import '../models/city.dart';
import 'package:mojgradapp/models/type.dart';

class APIServices {
  static Future fetchCategory(String jwt) async {
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();
    return await http.get(categoryURL,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });
  }

  static Future<List<Category>> fetchCategories(String jwt) async {
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    http.Response response = await http.get(categoryURL,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<Category> categoryList = new List<Category>();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var category in data) {
        categoryList.add(Category.fromObject(category));
      }
      return categoryList;
    }
    return null;
  }

  static Future<List<City>> fetchCity() async {
    var response = await http.get(cityURL,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });

    List<City> gradovi = new List<City>();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var grad in data) {
        gradovi.add(City.fromObject(grad));
      }
      return gradovi;
    } else
      return null;
  }

  static Future fetchPost() async {
    return await http.get(postURL);
  }

  static Future<List<Type>> fetchTypes(String jwt) async {
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var response = await http.get(typeURL,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<Type> tipovi = new List<Type>();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var type in data) {
        tipovi.add(Type.fromObject(type));
      }
      return tipovi;
    } else
      return null;
  }

  static Future<bool> logOut(String jwt, int id) async {
    var url = logoutURL + "/" + id.toString();

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var res = await http.post(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    if (res.body == 'true')
      return true;
    else
      return false;
  }

  static Future<List<Sponsor>> getAllSponsors(String jwt) async {
    var url = getAllSponsorsURL;

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var response = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<Sponsor> sponsors = new List<Sponsor>();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var sponsor in data) {
        sponsors.add(Sponsor.fromObject(sponsor));
      }
      return sponsors;
    } else
      return null;
  }

  static Future fetchComment() async {
    return await http.get(commentURL);
  }

  static Future fetchCommentDislike() async {
    return await http.get(commentDislikeURL);
  }

  static Future fetchCommentLike() async {
    return await http.get(commentLikeURL);
  }

  static Future fetchNotification() async {
    return await http.get(notificationURL);
  }

  static Future fetchPostReaction() async {
    return await http.get(postReactionURL);
  }

  static Future fetchPostReport() async {
    return await http.get(postReportURL);
  }

  static Future fetchUserReport() async {
    return await http.get(userReportURL);
  }

  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
}
