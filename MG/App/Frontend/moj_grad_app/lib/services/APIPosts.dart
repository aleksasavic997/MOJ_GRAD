import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mojgradapp/config/config.dart';
import 'package:mojgradapp/models/category.dart';
import 'package:mojgradapp/models/modelsViews/postInfo.dart';
import 'package:mojgradapp/models/post.dart';
import 'package:mojgradapp/models/postReaction.dart';
import 'package:mojgradapp/models/postReport.dart';
import 'package:mojgradapp/models/savedPost.dart';

import '../main.dart';

class APIPosts {
  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  static Future<bool> addPost(Post post) async {
    var newPost = post.toMap();
    var postBody = json.encode(newPost);

    var res = await http.post(postURL, headers: header, body: postBody);

    return Future.value(res.statusCode == 201 ? true : false);
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

  static Future<PostInfo> getPostByID(int id, String jwt) async {
    String url =
        postURL + "/" + id.toString() + "/userId=" + loginUserID.toString();
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

  static Future<List<PostInfo>> getAllPostsByUserID(int id, String jwt) async {
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
      var data1 = jsonDecode(response.body);

      for (var post in data1) {
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

  static Future<bool> isReacted(String jwt, int postID, int userID) async {
    String url = getpostReactionURL;

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

  static Future<bool> changePostInfo(String jwt, Post post) async {
    var url = changePostInfoURL;

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
    print(res.statusCode);
  }

  static Future<bool> addPostReport(String jwt, PostReport report) async {
    var url = postReportURL;

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var data2 = report.toMap();
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

  static Future<List<PostInfo>> getAllPostsOfUserThatYouFollow(
      String jwt) async {
    var url = getAllPostsOfUserThatYouFollowURL + "/" + loginUserID.toString();

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
    } else
      return null;
  }

  static Future<List<PostInfo>> getFilteredPosts(
      String jwt,
      int cityID,
      int fromFollowers,
      int activeChallenge,
      int sortByReactions,
      List<Category> categories) async {
    var url = getFilteredPostsURL +
        "/UserID=" +
        loginUserID.toString() +
        "/cityID=" +
        cityID.toString() +
        "/fromFollowers=" +
        fromFollowers.toString() +
        "/activeChallenge=" +
        activeChallenge.toString() +
        "/sortByReactions=" +
        sortByReactions.toString();

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    List<Map<String, dynamic>> data2 = List<Map<String, dynamic>>();

    for (var cat in categories) {
      data2.add(cat.toMap());
    }
    //if(data2 == null) data2 = categories;
    var jsonBody = jsonEncode(data2);

    var res = await http.post(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        },
        body: jsonBody);

    List<PostInfo> postList = new List<PostInfo>();

    if (res.statusCode == 200) {
      var data1 = jsonDecode(res.body);

      for (var post in data1) {
        postList.add(PostInfo.fromObject(post));
      }
      return postList;
    }
    return null;
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

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var post in data) {
        postList.add(PostInfo.fromObject(post));
      }
      return postList;
    }
    return null;
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
