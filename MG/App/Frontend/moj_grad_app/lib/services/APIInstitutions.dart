import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mojgradapp/config/config.dart';
import 'package:mojgradapp/models/institution.dart';
import 'package:mojgradapp/models/modelsViews/postInfo.dart';

class APIInstitutions {
  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  static Future<List<Institution>> getAllInstitutions(String jwt) async {
    var url = institutionsURL;
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

  static Future<List<Institution>> getInstitutionsByCityAndCategory(
      String jwt, int categoryID, int cityID) async {
    var url = institutionsFromCityURL +
        "/city/" +
        cityID.toString() +
        "/category/" +
        categoryID.toString() + "/verificated/1";
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

  static Future<List<PostInfo>> getInstitutionPosts(
      int institutionID, String jwt) async {
    String url =
        getPostsForInstitution + '/institutionID=' + institutionID.toString();

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var response = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<PostInfo> postList = new List<PostInfo>();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var post in data) {
        postList.add(PostInfo.fromObject(post));
      }
      return postList;
    }
    return null;
  }
}
