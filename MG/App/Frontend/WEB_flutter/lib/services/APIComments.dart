import 'package:WEB_flutter/models/comment.dart';
import 'package:WEB_flutter/models/commentReaction.dart';
import 'package:WEB_flutter/models/modelsViews/commentInfo.dart';
import 'package:http/http.dart' as http;
import 'package:WEB_flutter/config/config.dart';
import 'dart:convert';

import '../main.dart';

class APIComments {
  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  static Future<List<CommentInfo>> getAllComments(String jwt) async {
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var response = await http.get(commentURL,
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

  static Future<List<CommentInfo>> getReportedComment(
      String jwt, int userID) async {
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var url = commentsWithDislikesURL + "/userID=" + userID.toString();

    var response = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<CommentInfo> reportedCommentList = new List<CommentInfo>();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var comment in data) {
        reportedCommentList.add(CommentInfo.fromObject(comment));
      }
      return reportedCommentList;
    }
    return null;
  }

  static Future<List<CommentInfo>> getAllCommentsByPostID(
      String jwt, int id) async {
    var url = commentURL + "/post/" + id.toString();
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var response = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<CommentInfo> comments = new List<CommentInfo>();

    if (response.statusCode == 200) {
      var data2 = jsonDecode(response.body);

      for (var comm in data2) {
        comments.add(CommentInfo.fromObject(comm));
      }
      return comments;
    }
    return null;
  }

  static Future<List<CommentInfo>> getComments(String jwt, int postID) async {
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();
    String url = commentURL +
        '/Post/' +
        postID.toString() +
        "/userId=" +
        loginInstitutionID.toString();

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

  static Future<void> addComment(String jwt, Comment comment) async {
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
  }

  static Future<void> addCommentReaction(
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
  }

  static Future<bool> dissmissCommentReports(String jwt, int id) async {
    print('OVDE SAAAAM');
    var url = dissmissCommentReportsURL + id.toString();

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var res = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });
  
  print(res.statusCode);

    if (res.body == "true")
      return true;
    else
      return false;
  }

  static Future<List<CommentInfo>> getApprovedReportedComments(
      String jwt, int userID) async {
    var url = getApprovedReportedCommentsURL + userID.toString();
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

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
}
