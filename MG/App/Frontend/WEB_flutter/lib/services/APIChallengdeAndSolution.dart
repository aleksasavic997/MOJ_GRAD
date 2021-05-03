import 'package:WEB_flutter/models/modelsViews/postInfo.dart';
import 'package:WEB_flutter/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:WEB_flutter/config/config.dart';
import 'dart:convert';

class APIChallengeAndSolution {
  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  static Future<bool> isSolutionApproved(String jwt, int solutionID) async {
    var url = isSolutionApprovedURL + solutionID.toString();

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

  static Future<List<PostInfo>> getChallengeOrSolution(
      String jwt, int postID, int isApproved) async {
    var url = getChallengeOrSolutionURL +
        "/postID=" +
        postID.toString() +
        "/IsApproved=" +
        isApproved.toString();

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var res = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<PostInfo> postList = new List<PostInfo>();

    if (res.statusCode == 404)
      return null;
    else {
      var data = jsonDecode(res.body);

      for (var post in data) {
        postList.add(PostInfo.fromObject(post));
      }
      return postList;
    }
  }

  static Future<int> addSolution(
      String jwt, int challengeID, Post solution) async {
    var url = addChallengeSolutionURL + challengeID.toString();

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var data2 = solution.toMap();
    var jsonBody = jsonEncode(data2);

    var res = await http.post(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        },
        body: jsonBody);
    return int.parse(res.body);
  }
}
