import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mojgradapp/config/config.dart';
import 'package:mojgradapp/functions/dialogHelper.dart';
import 'package:mojgradapp/functions/loading.dart';
import 'package:mojgradapp/functions/mapPage.dart';
import 'package:mojgradapp/functions/solutionDialog.dart';
import 'package:mojgradapp/functions/toUsersThatReacted.dart';
import 'package:mojgradapp/main.dart';
import 'package:mojgradapp/models/comment.dart';
import 'package:mojgradapp/models/commentReaction.dart';
import 'package:mojgradapp/models/post.dart';
import 'package:mojgradapp/models/postReport.dart';
import 'package:mojgradapp/models/savedPost.dart';
import 'package:mojgradapp/screens/institutePage.dart';
import 'package:mojgradapp/screens/posts/changePost.dart';
import 'package:mojgradapp/screens/posts/postReview.dart';
import 'package:mojgradapp/screens/posts/solutionPage.dart';
import 'package:mojgradapp/screens/posts/usersThatReacted.dart';
import 'package:mojgradapp/screens/profilePage.dart';
import 'package:mojgradapp/services/APIChallengeAndSolution.dart';
import 'package:mojgradapp/services/APIComments.dart';
import 'package:mojgradapp/services/APIInstitutions.dart';
import 'package:mojgradapp/services/APIPosts.dart';
import 'package:mojgradapp/services/APIUsers.dart';
import 'dart:async';
import 'package:mojgradapp/services/token.dart';

import '../../models/modelsViews/commentInfo.dart';
import '../../models/modelsViews/postInfo.dart';
import '../homePage.dart';
import 'package:mojgradapp/main.dart';

class ViewPost extends StatefulWidget {
  static int postId;
  static Post solution;
  static int ind;

  @override
  _ViewPostState createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();
  bool saved = false;
  bool stared = false;
  bool showStar = false;
  bool showHands = false;
  final TextEditingController textCtrl = new TextEditingController();
  bool clickedLike = false;
  bool clickedDislike = false;
  bool isLiked = false;
  bool isDislaked = false;
  bool report;

  int solution = 2;

  int get postID {
    return ViewPost.postId;
  }

  _doubleStared() {
    print(showStar);
    setState(() {
      showStar = true;
      if (showStar) {
        Timer(const Duration(milliseconds: 300), () {
          setState(() {
            showStar = false;
          });
        });
      }
    });
  }

  _checkIfSaved() async {
    saved = await APIPosts.checkIfSaved(loginUserID, postID, Token.jwt);
  }

  _doubleHands() {
    setState(() {
      showHands = true;
      if (showHands) {
        Timer(const Duration(milliseconds: 300), () {
          setState(() {
            showHands = false;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(stared.toString());
    return Scaffold(
        key: _scaffoldstate,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              //Navigator.pop(context);
              if (ViewPost.ind == 2) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              } else if (ViewPost.ind == 3) {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage.fromBase64(Token.jwt),
                  ),
                );
              }
            },
          ),
        ),
        body: Container(
            child: FutureBuilder(
                future: APIPosts.getPostByID(this.postID, Token.jwt),
                builder:
                    (BuildContext context, AsyncSnapshot<PostInfo> snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                        child: Container(
                      child: Loading(),
                    ));
                  } else {
                    _checkIfSaved();
                    stared = snapshot.data.getIsReacted;
                    report = snapshot.data.getIsReported;
                    return SingleChildScrollView(
                      child: buildBody(snapshot),
                      scrollDirection: Axis.vertical,
                    );
                  }
                })));
  }

  Widget buildBody(AsyncSnapshot<PostInfo> snapshot) {
    return Container(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            userSection(snapshot),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Flexible(
                child: Container(
                  child: Text(
                    snapshot.data.title,
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 0, right: 10),
                child: Text(
                  "pre " + snapshot.data.timePassed,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ]),
            imageSection(snapshot),
            actionSection(snapshot),
            descriptionSection(snapshot),
            Container(
                child: SingleChildScrollView(child: commentSection(snapshot))),
            Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.77,
                  child: TextField(
                    controller: textCtrl,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Dodajte komentar...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () async {
                    Comment comm = new Comment(snapshot.data.id, loginUserID,
                        textCtrl.text, DateTime.now(), false);
                    var x = await APIComments.addComment(Token.jwt, comm);
                    if (x == true)
                      setState(() {
                        // APIComments.addComment(Token.jwt, comm).then(
                        //     (value) => sendNotification(snapshot.data.userId));
                        sendNotification(snapshot.data.userId);
                      });
                    else
                      _showSnakBarMsg('Objava je verovatno obrisana.');

                    textCtrl.clear();
                  },
                ),
              ],
            ),
          ],
        ));
  }

  Widget _userPopUpMenu(PostInfo post) {
    return Padding(
        padding: EdgeInsets.only(top: 0.0, left: 20.0),
        child: PopupMenuButton<String>(
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'val_one',
              child: Text('Obriši objavu'),
            ),
            PopupMenuItem<String>(
              value: 'val_two',
              child: Text('Izmeni objavu'),
            ),
            post.typeId != 2
                ? PopupMenuItem<String>(
                    value: 'val_three', child: Text('Rešenja izazova'))
                : null,
            post.typeId == 1
                ? PopupMenuItem<String>(
                    value: 'val_four',
                    child: Text('Zatvorite izazov'),
                  )
                : null,
          ],
          onSelected: (value) {
            //print(value);
            switch (value) {
              case 'val_one':
                {
                  print('Delete post');
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(
                            'Da li ste sigurni da želite da obrišete objavu?',
                            style: TextStyle(fontSize: 20,color: Colors.black),
                            textAlign: TextAlign.center,
                            
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(
                                "DA",
                                style: TextStyle(
                                  color: Colors.teal[800],
                                  fontSize: 20.0,
                                  //fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () async {
                                showDialog(
                                    context: context,
                                    builder: (context) => Loading());
                                await APIPosts.deletePost(Token.jwt, post.id);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HomePage.fromBase64(Token.jwt),
                                  ),
                                );
                              },
                            ),
                            FlatButton(
                                child: Text(
                                  'Odustani',
                                  style: TextStyle(
                                      color: Colors.teal[800], fontSize: 20),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                })
                          ],
                        );
                      });
                  break;
                }
              case 'val_two':
                {
                  print('Change post');
                  ChangePost.post = post;
                  Navigator.of(context).pushNamed('/changePost');
                  //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ChangePost(post)));
                  break;
                }
              case 'val_three':
                {
                  SolutionPage.post = post;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => SolutionPage()));
                  break;
                }
              case 'val_four':
                {
                  setState(() {
                    APIChallengeOrSolution.closeChallenge(Token.jwt, post.id);
                    _buildRaisedButton(post);
                  });
                  ViewPost();
                  break;
                }
            }
          },
        ));
  }

  Widget _popUpMenu(PostInfo postInfo) {
    return Padding(
        padding: EdgeInsets.only(top: 0.0, left: 20.0),
        child: PopupMenuButton<String>(
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'val_one',
              child:
                  report == true ? Text('Povucite prijavu') : Text('Prijavi'),
            ),
            postInfo.typeId != 2
                ? PopupMenuItem<String>(
                    value: 'val_two', child: Text('Rešenja izazova'))
                : null,
            PopupMenuItem<String>(
              value: 'val_three',
              child: saved == true
                  ? Text('Uklonite objavu iz sačuvanih')
                  : Text('Sačuvajte objavu'),
            ),
          ],
          onSelected: (value) async {
            print(value);
            if (value == "val_one") {
              //setState((){
              PostReport postReport = new PostReport(postInfo.id, loginUserID);
              report = await APIPosts.addPostReport(Token.jwt, postReport);
              if (report == false)
                _showSnakBarMsg('Objava je verovatno obrisana.');
              // });
            } else if (value == 'val_two') {
              SolutionPage.post = postInfo;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SolutionPage()));
            } else if (value == 'val_three') {
              SavedPost savedPost =
                  new SavedPost(postID, loginUserID, new DateTime.now());
              var s = await APIPosts.saveUnsavePost(Token.jwt, savedPost);
              _checkIfSaved();
              if (s == true)
                _checkIfSaved();
              else
                _showSnakBarMsg('Objava je verovatno obrisana.');
            }
          },
        ));
  }

  Widget _profilePicture(AsyncSnapshot<PostInfo> snapshot) {
    return Container(
      //padding: const EdgeInsets.only(top: 15.0),
      child: FloatingActionButton(
          onPressed: () async {
            var u =
                await APIUsers.getUserInfoById(snapshot.data.userId, Token.jwt);
            if (u.userTypeID == 1) {
              ProfilePage.user = u;
              // ProfilePage.user = await APIServices.getUserInfoById(
              //   snapshot.data.userId, Token.jwt);
              Navigator.of(context).pushNamed('/profile');
            } else {
              InstitutePage.institution =
                  await APIInstitutions.getInstitutionByID(
                      snapshot.data.userId, Token.jwt);
              Navigator.of(context).pushNamed('/institutePage');
            }
          },
          elevation: 0.0,
          child: Container(
            //padding: EdgeInsets.only(top: 20.0),
            width: 55.0,
            height: 55.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    wwwrootURL + snapshot.data.userProfilePhoto,
                  ),
                  fit: BoxFit.cover,
                ),
                //borderRadius: BorderRadius.circular(30.0),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black87, width: 1.0)),
          )),
    );
  }

  Widget userSection(AsyncSnapshot<PostInfo> snapshot) {
    return Container(
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(child: _profilePicture(snapshot), flex: 1),
          SizedBox(
            width: 12.0,
          ),
          Expanded(
            flex: 4,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () async {
                    var u = await APIUsers.getUserInfoById(
                        snapshot.data.userId, Token.jwt);
                    if (u.userTypeID == 1) {
                      ProfilePage.user = u;
                      // ProfilePage.user = await APIServices.getUserInfoById(
                      //   snapshot.data.userId, Token.jwt);
                      Navigator.of(context).pushNamed('/profile');
                    } else {
                      InstitutePage.institution =
                          await APIInstitutions.getInstitutionByID(
                              snapshot.data.userId, Token.jwt);
                      Navigator.of(context).pushNamed('/institutePage');
                    }
                  },
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        snapshot.data.username,
                        style: TextStyle(fontSize: 22.0),
                      )),
                  // color: Colors.amber,
                ),
                Container(
                  padding: EdgeInsets.only(top: 0.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/mapPage');
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => MapPage(
                      //         snapshot.data.latitude, snapshot.data.longitude),
                      //   ),
                      // );
                    },
                    child: Text(snapshot.data.location,
                        style: TextStyle(color: Colors.teal[700])),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              flex: 1,

              //user has different possibilities
              child: snapshot.data.userId == loginUser.id
                  ? _userPopUpMenu(snapshot.data)
                  : _popUpMenu(snapshot.data)),
        ],
      ),
    );
  }

  Widget imageSection(AsyncSnapshot<PostInfo> snapshot) {
    return Container(
      //padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0),
          SizedBox(
            height: 5.0,
          ),
          GestureDetector(
            onDoubleTap: () async {
              var x = await APIPosts.postReaction(
                  Token.jwt, snapshot.data.id, loginUserID);
              if (x == true)
                setState(() {
                  // APIPosts.postReaction(Token.jwt, snapshot.data.id, loginUserID)
                  //     .then((value) => sendNotification(snapshot.data.userId));
                  sendNotification(snapshot.data.userId);
                });
              else {
                _showSnakBarMsg('Objava je verovatno obrisana.');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage.fromBase64(Token.jwt),
                  ),
                );
              }
              snapshot.data.typeId != solution
                  ? _doubleStared()
                  : _doubleHands();
            },
            child: Container(
              height: 250,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.network(
                    wwwrootURL + snapshot.data.imagePath,
                    loadingBuilder: (context, child, progress) {
                      return progress == null
                          ? child
                          : CircularProgressIndicator();
                    },
                    fit: BoxFit.contain,
                  ),
                  showStar
                      ? Opacity(
                          opacity: 0.5,
                          child: Icon(Icons.star,
                              color: Colors.orange[50], size: 80.0))
                      : Container(),
                  showHands
                      ? Opacity(
                          opacity: 0.5,
                          child: FaIcon(FontAwesomeIcons.signLanguage,
                              color: Colors.orange[50], size: 80.0))
                      : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget actionSection(AsyncSnapshot<PostInfo> snapshot) {
    return Container(
        child: // snapshot.data.typeId != solution?
            Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: [
            IconButton(
              icon: snapshot.data.typeId != solution
                  ? Icon(
                      stared ? Icons.star : Icons.star_border,
                      color: stared ? Colors.yellow[600] : Colors.black87,
                      size: 40.0,
                    )
                  : FaIcon(FontAwesomeIcons.signLanguage,
                      color: stared ? Colors.yellow[600] : Colors.grey[500],
                      size: 40.0),
              onPressed: () async {
                var x = await APIPosts.postReaction(
                    Token.jwt, snapshot.data.id, loginUserID);
                if (x == true)
                  setState(() {
                    // APIPosts.postReaction(Token.jwt, snapshot.data.id, loginUserID)
                    //     .then((value) => sendNotification(snapshot.data.userId));
                    sendNotification(snapshot.data.userId);
                  });
                else {
                  _showSnakBarMsg('Objava je verovatno obrisana.');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage.fromBase64(Token.jwt),
                    ),
                  );
                }
                snapshot.data.typeId != solution
                    ? _doubleStared()
                    : _doubleHands();
              },
            ),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: InkWell(
                onTap: () {
                  UsersThatReacted.filterIndex = 0;
                  ToUsersThatReacted.solve(context);
                },
                child: Row(
                  children: <Widget>[
                    Text(
                      snapshot.data.reactionsNumber.toString(),
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Text(
                      snapshot.data.typeId != solution
                          ? _returnCorrectly(snapshot.data.reactionsNumber) ==
                                  true
                              ? ' reakcija'
                              : ' reakcije'
                          : _returnCorrectly(snapshot.data.reactionsNumber) ==
                                  true
                              ? ' pohvala'
                              : ' pohvale',
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 7.0,
          ), //right: 15),
          child: _buildRaisedButton(snapshot.data),
        ),
      ],
    ));
  }

  Widget descriptionSection(AsyncSnapshot<PostInfo> snapshot) {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Text(
          snapshot.data.description,
          style: TextStyle(fontSize: 18),
        ));
  }

  Widget _buildCommentList(AsyncSnapshot<List<CommentInfo>> snapshot) {
    return SizedBox(
        //height: 150.0,
        child: ListView.separated(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return _cardComment(snapshot.data[index], snapshot);
            },
            separatorBuilder: (context, index) {
              return Divider(
                thickness: 2,
              );
            }));
  }

  Widget _cardComment(
      CommentInfo comment, AsyncSnapshot<List<CommentInfo>> snapshot) {
    isLiked = comment.isLike;
    isDislaked = comment.isDislike;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ListTile(
            trailing: comment.userId == loginUserID
                ? IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      APIComments.deleteCommentById(comment.id, Token.jwt);

                      setState(() {
                        //////////////////////////////////////
                        snapshot.data.removeAt(index - 1);
                        /////////////////////////////////////
                      });

                      _showSnakBarMsg("Uspešno se obrisali komentar");
                    },
                  )
                : null,
            onTap: () {},
            leading: InkWell(
              onTap: () async {
                ProfilePage.user =
                    await APIUsers.getUserInfoById(comment.userId, Token.jwt);
                Navigator.of(context).pushNamed('/profile');
              },
              child: CircleAvatar(
                //backgroundColor: Colors.black38,
                backgroundImage:
                    NetworkImage(wwwrootURL + comment.profilePhoto),
              ),
            ),
            title: Text(
              comment.username,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              //textAlign: TextAlign,
            ),
            subtitle: Text(comment.content)),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.thumb_up),
                onPressed: () async {
                  CommentReaction commReaction = new CommentReaction(
                      comment.id, loginUserID, 1, DateTime.now(), false);
                  var x = await APIComments.addCommentReaction(
                      Token.jwt, commReaction);
                  if (x == true)
                    setState(() {
                      // APIComments.addCommentReaction(Token.jwt, commReaction)
                      //     .then((value) => sendNotification(comment.userId));
                      sendNotification(comment.userId);
                    });
                  else
                    _showSnakBarMsg("Komentar je verovatno obrisan.");
                },
                color: isLiked == true ? Colors.blue[500] : Colors.grey[500],
                iconSize: 20.0,
              ),
              InkWell(
                  onTap: () {
                    UsersThatReacted.filterIndex = 1;
                    UsersThatReacted.commentID = comment.id;
                    ToUsersThatReacted.solve(context);
                  },
                  child: Text(comment.commentLikes.toString())),
              IconButton(
                icon: Icon(Icons.thumb_down),
                onPressed: () async {
                  CommentReaction commReaction = new CommentReaction(
                      comment.id, loginUserID, -1, DateTime.now(), false);
                  var x = await APIComments.addCommentReaction(
                      Token.jwt, commReaction);
                  if (x == true)
                    setState(() {
                      // APIComments.addCommentReaction(Token.jwt, commReaction)
                      //     .then((value) => sendNotification(comment.userId));
                      sendNotification(comment.userId);
                    });
                  else
                    _showSnakBarMsg("Komentar je verovatno obrisan.");
                },
                color: isDislaked == true ? Colors.red[500] : Colors.grey[500],
                iconSize: 20.0,
              ),
              InkWell(
                  onTap: () {
                    UsersThatReacted.filterIndex = 2;
                    UsersThatReacted.commentID = comment.id;
                    ToUsersThatReacted.solve(context);
                  },
                  child: Text(comment.commentDislikes.toString()))
            ],
          ),
        ),
      ],
    );
  }

  Widget commentSection(AsyncSnapshot<PostInfo> snapshot) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.comments,
                    color: Colors.teal[700],
                    size: 25.0,
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    snapshot.data.commentsNumber.toString() +
                        (snapshot.data.commentsNumber % 10 == 1
                            ? " komentar"
                            : " komentara"),
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  snapshot.data.categoryName,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {},
                color: Colors.teal[900],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          FutureBuilder(
            future: APIComments.getComments(Token.jwt, postID),
            builder: (BuildContext context,
                AsyncSnapshot<List<CommentInfo>> snapshotCom) {
              if (snapshotCom.data == null) {
                return Container();
              } else {
                return snapshotCom.data.length == 0
                    ? Container()
                    : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.teal[900])),
                        height: snapshotCom.data.length == 1 ? 150 : 260,
                        child: _buildCommentList(snapshotCom));
              }
            },
          ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }

  Widget _buildRaisedButton(PostInfo snapshot) {
    Widget raisedButton;
    if (snapshot.typeId == 2)
      raisedButton = raisedButton = RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Text(
          'Prikaži izazov',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          int isApproved = 0;
          if (await (APIChallengeOrSolution.isSolutionApproved(
                  Token.jwt, snapshot.id)) ==
              true) isApproved = 1;
          if ((await APIChallengeOrSolution.getChallengeOrSolution(
                      Token.jwt, snapshot.id, isApproved))
                  .length !=
              0) {
            PostInfo postInfo =
                (await APIChallengeOrSolution.getChallengeOrSolution(
                    Token.jwt, snapshot.id, isApproved))[0];
            setState(() {
              //ViewPost.postId = postInfo.id;
              var dialog = PostReview(post: postInfo);
              showDialog(context: context, builder: (context) => dialog);
            });
          } else
            _showSnakBarMsg("Izazov je obrisan.");
        },
        color: Colors.amber[900],
      );
    else {
      if (snapshot.typeId == 1)
        raisedButton = RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Text(
            'Reši izazov',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            //Navigator.of(context).pushNamed('/newPost');
            SolutionDialog.post = snapshot;
            DialogHelper.solve(context);
          },
          color: Colors.red[900],
        );
      else if (snapshot.typeId == 3)
        raisedButton = raisedButton = RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Text(
            'Izazov je završen',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.teal[900],
          onPressed: () {},
        );
      else
        raisedButton = null;
    }
    return raisedButton;
  }

  void _showSnakBarMsg(String msg) {
    _scaffoldstate.currentState
        .showSnackBar(new SnackBar(content: new Text(msg)));
  }

  bool _returnCorrectly(int numOfReactions) {
    if (numOfReactions % 100 >= 10 && numOfReactions % 100 <= 20)
      return true;
    else if (numOfReactions % 10 == 0 ||
        numOfReactions % 10 == 1 ||
        numOfReactions % 10 == 5 ||
        numOfReactions % 10 == 6 ||
        numOfReactions % 10 == 7 ||
        numOfReactions % 10 == 8 ||
        numOfReactions % 10 == 9)
      return true;
    else
      return false;
  }
}
