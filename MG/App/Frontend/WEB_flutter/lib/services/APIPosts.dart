import 'dart:convert';
import 'package:WEB_flutter/models/modelsViews/postInfo.dart';
import 'package:WEB_flutter/models/postReaction.dart';
import 'package:WEB_flutter/models/savedPost.dart';
import 'package:http/http.dart' as http;
import 'package:WEB_flutter/config/config.dart';

import '../main.dart';

class APIPosts {
  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  static Future<void> deletePost(String jwt, int id) async {
    var url = postURL + "/" + id.toString();

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var res = await http.delete(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });
  }

  static Future<List<PostInfo>> getPosts(String jwt) async {
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var response = await http.get(postURL,
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

  static Future<List<PostInfo>> getReportedPost(String jwt) async {
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var response = await http.get(getReportedPosts,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<PostInfo> reportedPostList = new List<PostInfo>();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var post in data) {
        reportedPostList.add(PostInfo.fromObject(post));
      }
      return reportedPostList;
    }
    return null;
  }

  static Future<List<PostInfo>> getReportedPostByUserID(
      String jwt, int userID) async {
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var url = getReportedPostsByUserID + userID.toString();

    var response = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<PostInfo> reportedPostList = new List<PostInfo>();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var post in data) {
        reportedPostList.add(PostInfo.fromObject(post));
      }
      return reportedPostList;
    }
    return null;
  }

  static Future<List<PostInfo>> getMostImportantPostsByUserID(
      int typeId, String jwt, int userID) async {
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var url = getMostImportantPostByUsesID +
        "/userID=" +
        userID.toString() +
        "/typeID=" +
        typeId.toString();

    var response = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<PostInfo> reportedPostList = new List<PostInfo>();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var post in data) {
        reportedPostList.add(PostInfo.fromObject(post));
      }
      return reportedPostList;
    }
    return null;
  }

  static Future<List<PostInfo>> getMostImportantPost(
      int cityId, int typeId, String jwt) async {
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var response = await http.get(
        getMostImportantPosts +
            "cityID=" +
            cityId.toString() +
            "/typeID=" +
            typeId.toString(),
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<PostInfo> reportedPostList = new List<PostInfo>();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var post in data) {
        reportedPostList.add(PostInfo.fromObject(post));
      }
      return reportedPostList;
    }
    return null;
  }

  static Future<List<PostInfo>> getAllPostsByUserID(String jwt, int id) async {
    String url = postURL + "/user/" + id.toString();

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

  static Future<PostInfo> getPostByID(int id, String jwt) async {
    String url = postURL + "/" + id.toString() + "/userId=";

    if (loginAdmin.isEmpty)
      url += loginInstitutionID.toString();
    else
      url += "0";
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var response = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });
    if (response.statusCode == 200) {
      var data1 = jsonDecode(response.body);
      PostInfo postInfo = PostInfo.fromObject(data1);
      return postInfo;
    }
    return null;
  }

  static Future<List<PostInfo>> getInstitutionPosts(
      int institutionID, String jwt) async {
    String url = getUserPostsFilteredByType +
        "/userID=" +
        institutionID.toString() +
        "/typeID=2";

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

  static Future<List<PostInfo>> getPostsByCityAndCategory(
      String jwt, int cityID, int categoryID) async {
    String url = postsByCityAndCategoryURL +
        cityID.toString() +
        "/category/" +
        categoryID.toString();

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

  static Future<List<PostInfo>> getPostsForInstitution(
      String jwt, int institutionID) async {
    String url = getPostsForInstitutionURL + institutionID.toString();

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

  static Future<List<PostInfo>> getPostsByCity(String jwt, int cityID) async {
    String url = postsByCityURL + cityID.toString();

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

  static Future<List<PostInfo>> getPostsByCategory(
      String jwt, int categoryID) async {
    String url = postsByCategoryURL + categoryID.toString();

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

  static Future<bool> postReaction(String jwt, int postID, int userID) async {
    String url = postReactionURL;

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    PostReaction reaction =
        new PostReaction(postID, userID, DateTime.now(), false);
    var data2 = reaction.toMap();
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

  static Future<List<PostInfo>> getPostsFilteredByType(
      int userID, int typeID, String jwt) async {
    String url = getUserPostsFilteredByType +
        "/userID=" +
        userID.toString() +
        "/typeID=" +
        typeID.toString();

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var response = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<PostInfo> postList = new List<PostInfo>();

    print(response.body);

    //print("APIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var post in data) {
        postList.add(PostInfo.fromObject(post));
      }
      //print(postList);
      return postList;
    }
    return null;
  }

  static Future<bool> saveUnsavePost(String jwt, SavedPost post) async {
    var url = saveOrUnsavePost;

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var data2 = post.toMap();
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

  static Future<List<PostInfo>> fetchSavedPosts(int userID, String jwt) async {
    var url = getSavedPosts + userID.toString();

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var response = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<PostInfo> postList = new List<PostInfo>();

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var post in data) {
        postList.add(PostInfo.fromObject(post));
      }
      return postList;
    }
    return null;
  }
  
  static Future<bool> checkIfSaved(int userID, int postID, String jwt) async {
    var url = checkIfSavedURL +
        '/UserID=' +
        userID.toString() +
        '/PostID=' +
        postID.toString();

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var response = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data == true)
        return true;
      else
        return false;
    }
    return false;
  }
}
