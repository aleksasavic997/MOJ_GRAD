import 'package:WEB_flutter/config/config.dart';
import 'package:WEB_flutter/models/modelsViews/userInfo.dart';
import 'package:WEB_flutter/screens/userProfile/userProfile.dart';
import 'package:WEB_flutter/services/APIUsers.dart';
import 'package:WEB_flutter/services/token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:WEB_flutter/hover_extensions.dart';
import 'package:WEB_flutter/main.dart';

class ListAllUsers extends StatefulWidget {
  @override
  _ListAllUsersState createState() => _ListAllUsersState();
}

class _ListAllUsersState extends State<ListAllUsers> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          padding: EdgeInsets.all(10.0),
          child: idUserFilter == 0 //ListAllUsers.id == 0
              ? FutureBuilder(
                  future: APIUsers.getAllUsers(Token.jwt),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<UserInfo>> snapshot) {
                    if (snapshot.data == null) {
                      return Center(
                          child: Container(
                              //child: Text('Nije dobro')),
                              child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                      )));
                    } else {
                      return snapshot.data.length == 0
                          ? Center(
                              child: Container(
                                  padding: EdgeInsets.only(top: 100),
                                  height: 200,
                                  child: Text(
                                    "Nema korisnika ",
                                    style: TextStyle(color: Colors.white),
                                  )))
                          : ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return _contactList(snapshot.data[index]);
                              });
                    }
                  },
                )
              //u suprotnom "uzimamo" korisnika sa tim id-ijem
              : FutureBuilder(
                  future: APIUsers.fetchUserData(idUserFilter, Token.jwt),
                  builder:
                      (BuildContext context, AsyncSnapshot<UserInfo> snapshot) {
                    print("bbbbbbbbbbbbbbbbbbbbb");
                    if (snapshot.data == null) {
                      return Center(
                          child: Container(
                              //child: Text('Nije dobro')),
                              child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                      )));
                    } else {
                      return ListView.builder(
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return _contactList(snapshot.data);
                          });
                    }
                  },
                )),
    );
  }

  Widget _contactList(UserInfo user) {
    var nameInitial = user.username[0].toUpperCase();
    if (user.profilePhoto.length > 0) {
      //ako je prosledejena slika
      nameInitial = ""; //
    }

    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: FlatButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UserProfile(user: user)));
        },
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              backgroundImage: user.profilePhoto.length > 0
                  ? NetworkImage(wwwrootURL + user.profilePhoto)
                  : null,
              radius: 30,
              child: Text(
                nameInitial,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.grey[200]),
              ),
            ),
            title: Container(child: Text('Korisničko ime: ${user.username}')),
            subtitle: Container(
              padding: EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Text('Ime i prezime: ${user.name} ${user.lastname}'),
                  SizedBox(
                    height: 8,
                  ),
                  Text('E-mail: ${user.email}')
                ],
              ),
            ),
          ),
        ),
      ).showPointerOnHover,
    );
  }
}
