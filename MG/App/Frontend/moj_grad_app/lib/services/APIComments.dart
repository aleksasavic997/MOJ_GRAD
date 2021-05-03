import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mojgradapp/config/config.dart';
import 'package:mojgradapp/models/comment.dart';
import 'package:mojgradapp/models/commentReaction.dart';
import 'package:mojgradapp/models/modelsViews/commentInfo.dart';

import '../main.dart';

class APIComments {
  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  static Future<bool> deleteCommentById(int id, String jwt) async {
    var urlCommentById = commentURL + "/" + id.toString();
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var res = await http.delete(urlCommentById,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    return Future.value(res.statusCode == 201 ? true : false);
  }

  static Future<List<CommentInfo>> getComments(String jwt, int postID) async {
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();
    String url = commentURL +
        '/Post/' +
        postID.toString() +
        "/userId=" +
        loginUserID.toString();

    var response = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<CommentInfo> commentList = new List<CommentInfo>();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var comment in data) {
        commentList.add(CommentInfo.fromObject(comment));
      }
      return commentList;
    }
    return null;
  }

  static Future<CommentInfo> getCommentByID(int id, String jwt) async {
    String url = commentURL + "/" + id.toString();
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
      CommentInfo commentInfo = CommentInfo.fromObject(data1);
      return commentInfo;
    }
    return null;
  }

  static Future<bool> addComment(String jwt, Comment comment) async {
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    String url = commentURL;

    var data2 = comment.toMap();
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

  static Future<bool> addCommentReaction(
      String jwt, CommentReaction commentReaction) async {
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    String url = newCommentReactionURL;

    var data2 = commentReaction.toMap();
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
}
