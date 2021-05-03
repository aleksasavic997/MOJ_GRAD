import 'package:WEB_flutter/models/category.dart';
import 'package:WEB_flutter/models/institution.dart';
import 'package:WEB_flutter/models/modelsViews/institutionInfo.dart';
import 'package:http/http.dart' as http;
import 'package:WEB_flutter/config/config.dart';
import 'dart:convert';

class APIInstitutions {
  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  static Future<Institution> getInstitutionByID(int id, String jwt) async {
    String url = userDataURL + "/" + id.toString();

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var res = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    var data2 = jsonDecode(res.body);
    Institution institution = Institution.fromObject(data2);
    return institution;
  }

  static Future<InstitutionInfo> getInstitutionInfoByID(
      int id, String jwt) async {
    String url = userDataURL + "/" + id.toString();

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var res = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });
    var data2 = jsonDecode(res.body);
    InstitutionInfo institution = InstitutionInfo.fromObject(data2);
    return institution;
  }

  static Future<List<Institution>> getInstitutionsByCityAndCategory(
      String jwt, int categoryID, int cityID) async {
    var url = institutionsFromCityURL +
        "/city/" +
        cityID.toString() +
        "/category/" +
        categoryID.toString() +
        "/verificated/0";
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var res = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<Institution> institutions = new List<Institution>();

    if (res.statusCode == 200) {
      var data1 = jsonDecode(res.body);
      for (var institution in data1) {
        institutions.add(Institution.fromObject(institution));
      }
      return institutions;
    } else
      return null;
  }

  static Future<bool> changeInstitution(
      String jwt, Institution institution) async {
    String url = changeUserInfoURL;
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var data2 = institution.toMap();
    var jsonBody = jsonEncode(data2);
    var res = await http.post(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        },
        body: jsonBody);
    if (res.body == 'true')
      return true;
    else
      return false;
  }

  static Future<bool> verifyInstitution(String jwt, int id) async {
    var url = verificationURL + id.toString();

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var res = await http.post(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    if (res.body == "true")
      return true;
    else
      return false;
  }

  static Future<bool> followCategories(
      String username, List<Category> categories) async {
    var url = institutionFollowCategoryURL + username;

    List<Map<String, dynamic>> data2 = List<Map<String, dynamic>>();

    for (var cat in categories) {
      print(cat.name);
      data2.add(cat.toMap());
    }
    var jsonBody = jsonEncode(data2);

    var res = await http.post(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonBody);

    print(res.statusCode);

    if (res.body == "true")
      return true;
    else
      return false;
  }

  static Future<List<Category>> getCategoriesUserFollow(
      String jwt, int id) async {
    var url = getCategoriesUserFollowURL + id.toString();

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var res = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<Category> categories = new List<Category>();

    if (res.statusCode == 200) {
      var data1 = jsonDecode(res.body);
      for (var category in data1) {
        categories.add(Category.fromObject(category));
      }
      return categories;
    } else
      return null;
  }

  static Future<List<Institution>> getNotVerifiedInstitutions(String jwt) async {
    var url = notVerifiedInstitutionsURL;

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var response = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<Institution> notVerifiedInstitutions = new List<Institution>();

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (var institution in data) {
        notVerifiedInstitutions.add(Institution.fromObject(institution));
      }
      return notVerifiedInstitutions;
    } else {
      return null;
    }
  }

  static Future<List<Institution>> getInstitutionsByCityAndCategoryNEW(
      String jwt, int categoryID, int cityID) async {
    var url = newnew + cityID.toString() + "/category/" + categoryID.toString();
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var res = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<Institution> institutions = new List<Institution>();
    print(res.statusCode);
    if (res.statusCode == 200) {
      var data1 = jsonDecode(res.body);
      for (var institution in data1) {
        institutions.add(Institution.fromObject(institution));
      }
      return institutions;
    } else
      return null;
  }
}
