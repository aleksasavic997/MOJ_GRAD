import 'package:mojgradapp/screens/institutePage.dart';
import 'package:mojgradapp/screens/posts/viewPostPage.dart';
import 'package:mojgradapp/screens/profilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mojgradapp/config/config.dart';
import 'package:mojgradapp/services/APIInstitutions.dart';
import 'package:mojgradapp/services/APIUsers.dart';
import 'package:mojgradapp/services/token.dart';
import 'package:mojgradapp/models/modelsViews/userInfo.dart';
import 'viewPostPage.dart';

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
                          subtitle: snapshot.data[index].userTypeID == 1 ?
                          Text(snapshot.data[index].name +
                              " " +
                              snapshot.data[index].lastname) :
                               Text(snapshot.data[index].name),
                          onTap: () async{
                            if(snapshot.data[index].userTypeID == 1)
                            {
                              ProfilePage.user = snapshot.data[index];
                              Navigator.of(context).pushNamed('/profile');
                            }
                            else
                            {
                              InstitutePage.institution = await APIInstitutions.getInstitutionByID(snapshot.data[index].id, Token.jwt);
                              Navigator.of(context).pushNamed('/institutePage');
                            }
                          },
                        );
                      });
                }
              }),
        ),
      );
}

Future<List<UserInfo>> _makeFuture() {
  switch (UsersThatReacted.filterIndex) {
    case 0:
      return APIUsers.getAllUsersByPostID(Token.jwt, ViewPost.postId);
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
}
