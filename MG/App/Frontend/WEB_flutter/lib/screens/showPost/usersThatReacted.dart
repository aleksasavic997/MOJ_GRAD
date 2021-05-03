import 'package:WEB_flutter/services/APIUsers.dart';
import 'package:flutter/material.dart';
import 'package:WEB_flutter/hover_extensions.dart';
import '../../config/config.dart';
import '../../models/institution.dart';
import '../../models/modelsViews/postInfo.dart';
import '../../models/modelsViews/userInfo.dart';
import '../../services/APIInstitutions.dart';
import '../../services/token.dart';
import '../institutions/profilePage/instProfile.dart';
import '../userProfile/userProfile.dart';
import 'showPost.dart';

class UsersThatReacted extends StatefulWidget {
  static int filterIndex;
  static int commentID;
  @override
  _UsersThatReactedState createState() => _UsersThatReactedState();
}

class _UsersThatReactedState extends State<UsersThatReacted> {
  String name;
  String lastname;

  @override
  @override
  Widget build(BuildContext context) {
    return Dialog(
        //key: _scaffoldstate,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: _buildChild(context));
  }

  _buildChild(BuildContext context) => SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          padding: EdgeInsets.all(20.0),
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white70.withOpacity(0.95),
          ),
          child: FutureBuilder(
              future: _makeFuture(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<UserInfo>> snapshot) {
                if (!snapshot.hasData) {
                  print("ovde sam");
                  return Container(
                    child: Center(child: Text('Loading...')),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                wwwrootURL + snapshot.data[index].profilePhoto),
                          ),
                          title: Text(snapshot.data[index].username),
                          subtitle: snapshot.data[index].userTypeID == 1
                              ? Text(snapshot.data[index].name +
                                  " " +
                                  snapshot.data[index].lastname)
                              : Text(snapshot.data[index].name),
                          onTap: () async{
                            if(snapshot.data[index].userTypeID == 1)
                            {
                              UserInfo user = snapshot.data[index];
                              Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => UserProfile(user: user)));
                            }
                            else
                            {
                              Institution institution = await APIInstitutions.getInstitutionByID(snapshot.data[index].id, Token.jwt);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => InstitutionProfile(institution: institution,)));
                            }
                            // UserInfo user = snapshot.data[index];
                            // Navigator.of(context).pushNamed('/profile');
                          },
                        ).showPointerOnHover;
                      });
                }
              }),
        ),
      );
}

Future<List<UserInfo>> _makeFuture() {
  PostInfo post = ShowPost.post;
  switch (UsersThatReacted.filterIndex) {
    case 0:
      return APIUsers.getAllUsersByPostID(Token.jwt, post.id);
      break;
    case 1:
      return APIUsers.getUsersThatLikedComment(
          Token.jwt, UsersThatReacted.commentID);
      break;
    case 2:
      return APIUsers.getUsersThatDislikedComment(
          Token.jwt, UsersThatReacted.commentID);
      break;
  }
  return null;
}
