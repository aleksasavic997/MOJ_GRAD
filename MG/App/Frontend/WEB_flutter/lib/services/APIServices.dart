import 'dart:convert';
import 'package:WEB_flutter/models/modelsViews/categoryStatistic.dart';
import 'package:WEB_flutter/models/sponsor.dart';
import 'package:http/http.dart' as http;
import 'package:WEB_flutter/config/config.dart';
import 'package:WEB_flutter/models/category.dart';
import '../models/city.dart';
import 'package:WEB_flutter/models/modelsViews/userStatisticInfo.dart';

class APIServices {
  static Future fetchCategory() async {
    return await http.get(categoryURL);
  }

  static Future fetchCity() async {
    return await http.get(cityURL);
  }

  static Future<List<City>> getCity() async {
    var response = await http.get(cityURL,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          //'Authorization': 'Bearer $jwt'
        });
    List<City> gradovi = new List<City>();
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var grad in data) {
        gradovi.add(City.fromObject(grad));
      }
      return gradovi;
    } else {
      return null;
    }
  }

  static Future<List<Category>> getCategory() async {
    var response = await http.get(categoryURL,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          
        });

    List<Category> listCategory = new List<Category>();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var category in data) {
        listCategory.add(Category.fromObject(category));
      }
      return listCategory;
    } else {
      return null;
    }
  }

  static Future fetchPost() async {
    return await http.get(postURL);
  }

  static Future fetchType() async {
    return await http.get(typeURL);
  }

  static Future fetchAdmin() async {
    return await http.get(adminURL);
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
    'Accept': 'application/json'
  };

/*
  static Future<List<PostInfo>> getPostsInst() async {
    // var data = jsonDecode(jwt);
    // jwt = data['token'].toString();

    var response = await http.get(postURL,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer'
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
*/

  static Future<List<CategoryStatistic>> getCategoryStatistic(String jwt) async {

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var response = await http.get(getCategoryStatistics,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<CategoryStatistic> statisticList = new List<CategoryStatistic>();

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      for (var item in data) {
        statisticList.add(CategoryStatistic.fromObject(item));
      }
      return statisticList;
    }
    return null;
  }

  static Future<String> addImageForWeb(String jwt, String image,
      {int institution = 0}) async {
    var url = imageUploadWebURL;
    if (institution == 1) url = imageUploadForInstitution;
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var map = Map();
    map['image'] = image;
    var jsonBody = json.encode(map);
    var res = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        },
        body: jsonBody);
    return res.body;
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

  static Future<List<UserStatisticInfo>> getUserStatistic(
      int cityID, int byDay, int byMonth, int byYear, String jwt) async {

        var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    //+ /cityID={cityID}/byDay={byDay}/byMonth={byMonth}/byYear={byYear}
    var url = getUserStatisticsURL +
        '/cityID=' +
        cityID.toString() +
        '/byDay=' +
        byDay.toString() +
        '/byMonth=' +
        byMonth.toString() +
        '/byYear=' +
        byYear.toString();

    var response = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<UserStatisticInfo> userStatisticList = new List<UserStatisticInfo>();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var item in data) {
        userStatisticList.add(UserStatisticInfo.fromObject(item));
      }
      return userStatisticList;
    }
    return null;
  }

  static Future<bool> deleteSponsor(String jwt, int id) async {
    var url = deleteSponsorURL + id.toString();
    print(url);
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var res = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });
    print(res.statusCode);
    print(res.body);
    return Future.value(res.statusCode == 201 ? true : false);
  }

  static Future<bool> addSponsor(String jwt, Sponsor sponsor) async {
    var url = addSponsorURL;

    var data = jsonDecode(jwt);

    jwt = data['token'].toString();

    var data2 = sponsor.toMap();
    var jsonBody = jsonEncode(data2);
    var res = await http.post(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        },
        body: jsonBody);

    print(res.statusCode);
    print(res.body);

    if (res.body == 'true')
      return true;
    else
      return false;
  }
}
