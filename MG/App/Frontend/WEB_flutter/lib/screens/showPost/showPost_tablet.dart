import 'package:WEB_flutter/config/config.dart';
import 'package:WEB_flutter/functions/toUsersThatReacted.dart';
import 'package:WEB_flutter/main.dart';
import 'package:WEB_flutter/models/comment.dart';
import 'package:WEB_flutter/models/commentReaction.dart';
import 'package:WEB_flutter/models/institution.dart';
import 'package:WEB_flutter/models/modelsViews/commentInfo.dart';
import 'package:WEB_flutter/models/modelsViews/postInfo.dart';
import 'package:WEB_flutter/models/modelsViews/userInfo.dart';
import 'package:WEB_flutter/models/savedPost.dart';
import 'package:WEB_flutter/screens/homePage/home.dart';
import 'package:WEB_flutter/screens/institutions/dialogHelper.dart';
import 'package:WEB_flutter/screens/institutions/homePageInstitutions.dart';
import 'package:WEB_flutter/screens/institutions/profilePage/instProfile.dart';
import 'package:WEB_flutter/screens/institutions/solutionDialog.dart';
import 'package:WEB_flutter/screens/showPost/showPost.dart';
import 'package:WEB_flutter/screens/showPost/usersThatReacted.dart';
import 'package:WEB_flutter/screens/solutions/solutionPage.dart';
import 'package:WEB_flutter/screens/userProfile/userProfile.dart';
import 'package:WEB_flutter/services/APIChallengdeAndSolution.dart';
import 'package:WEB_flutter/services/APIComments.dart';
import 'package:WEB_flutter/services/APIInstitutions.dart';
import 'package:WEB_flutter/services/APIPosts.dart';
import 'package:WEB_flutter/services/APIUsers.dart';
import 'package:WEB_flutter/services/token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:WEB_flutter/hover_extensions.dart';

void main() => runApp(new PostTablet());

class PostTablet extends StatefulWidget {
  //provide the same scrollController for list and draggableScrollbar
  @override
  _PostTabletState createState() => _PostTabletState();
}

class _PostTabletState extends State<PostTablet> {
  final ScrollController controller = ScrollController();
 
  PostInfo post = ShowPost.post;
  final TextEditingController textCtrl = new TextEditingController();
  bool isLiked = false;
  bool isDislaked = false;
  bool stared = false;
  bool report;
  int solution = 2;
  bool saved; //= false;

  _checkIfSaved() async {
    saved = await APIPosts.checkIfSaved(loginInstitutionID, post.id, Token.jwt);
  }

  @override
  Widget build(BuildContext context) {
    _checkIfSaved();
    return Scaffold(
        body: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: FutureBuilder(
                  future: APIPosts.getPostByID(this.post.id, Token.jwt),
                  builder:
                      (BuildContext context, AsyncSnapshot<PostInfo> snapshot) {
                    if (snapshot.data == null) {
                      return Center(
                          child: Container(
                              child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                      )));
                    } else {
                      _checkIfSaved();
                      stared = snapshot.data.getIsReacted;
                      report = snapshot.data.getIsReported;
                      return SingleChildScrollView(
                        child: buildBody(snapshot),
                        scrollDirection: Axis.vertical,
                      );
                    }
                  }),
            )));
  }

  Widget _userSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Colors.grey.shade500),
      )),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              InkWell(
                child: Wrap(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 7.0, horizontal: 10),
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(wwwrootURL + ShowPost.user.profilePhoto),
                      radius: 27,
                    ),
                  ),
                ]),
                onTap: () async {
                  UserInfo user =
                      await APIUsers.fetchUserData(post.userId, Token.jwt);
                  //////////////////////////////////////////////////////////////////////////////////////////////
                  Institution inst = user.userTypeID == 2
                      ? await APIInstitutions.getInstitutionByID(
                          user.id, Token.jwt)
                      : null;

                  user.userTypeID == 1
                      ? Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                              builder: (context) => UserProfile(user: user)))
                      : Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                              builder: (context) => InstitutionProfile(
                                    institution: inst,
                                  )));
                  //////////////////////////////////////////////////////////////////////////////////////////////
                },
              ).showPointerOnHover,
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      child: Wrap(children: [
                        Text(
                          post.username,
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                      onTap: () async {
                        UserInfo user = await APIUsers.fetchUserData(
                            post.userId, Token.jwt);
                        //////////////////////////////////////////////////////////////////////////////////////////////
                        Institution inst = user.userTypeID == 2
                            ? await APIInstitutions.getInstitutionByID(
                                user.id, Token.jwt)
                            : null;

                        user.userTypeID == 1
                            ? Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (context) =>
                                        UserProfile(user: user)))
                            : Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (context) => InstitutionProfile(
                                          institution: inst,
                                        )));
                        //////////////////////////////////////////////////////////////////////////////////////////////
                      },
                    ).showPointerOnHover,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.black54,
                          size: 17,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Tooltip(
                          message: post.location,
                          child: Container(
                            width:
                                200, //MediaQuery.of(context).size.width<580 ? MediaQuery.of(context).size.width/2.6 : MediaQuery.of(context).size.width/1.9,
                            child: Text(
                              post.location,
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          (loginAdmin.isEmpty == false ||
                  ShowPost.post.userId == loginInstitution.getId)
              ? _deleteMenu()
              : _saveMenu(),
        ],
      ),
    );
  }

  Widget _saveMenu() {
    return Container(
        child: Tooltip(
      message:
          saved == false ? "Sačuvaj objavu" : "Uklonite objavu iz sacuvanih",
      child: IconButton(
        icon: Icon(
          saved == false ? Icons.bookmark_border : Icons.bookmark,
          size: 30,
        ),
        onPressed: () async {
          SavedPost savedPost =
              new SavedPost(post.id, loginInstitutionID, new DateTime.now());
          var s = await APIPosts.saveUnsavePost(Token.jwt, savedPost);
          print("sacuvano");
          //print("pree $saved");
          setState(() {
            _checkIfSaved();
          });
          //print("posle $saved");
        },
      ),
    ));
  }

  Widget _titleSection() {
    return Container(
      height: 65.5,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  child: Text(
                    post.title,
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                ),
              ),
              Container(
                //padding: EdgeInsets.only(top: 10, right: 10),
                child: Text(
                  "pre " + post.timePassed,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          _solutionOrChalengeButton()
        ],
      ),
    );
  }

  Widget navigationBar() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              Image.asset(
                'assets/webLogo.png',
                width: MediaQuery.of(context).size.width > 600 ? 150 : 100,
                height: 80,
              ),
              Text(
                'Moj Grad ', //ostavi razmak posle d
                style: TextStyle(fontSize: 30.0, fontFamily: 'Pacifico'),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: FloatingActionButton(
                  tooltip: 'Korak nazad',
                  heroTag: 'backTag',
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Color.fromRGBO(24, 74, 69, 1),
                  ),
                ),
              ).showPointerOnHover,
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: FloatingActionButton(
                  onPressed: () {
                    InstitutionProfile.showNotifications = false;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => loginAdmin.isEmpty == true
                              ? HomePageInstitutions()
                              : HomePage.fromBase64(Token.jwt),
                        ));
                  },
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.home,
                    size: 30,
                    //size: MediaQuery.of(context).size.width > 600 ? 30 : 20,
                    color: Color.fromRGBO(24, 74, 69, 1),
                  ),
                  //mini: MediaQuery.of(context).size.width > 600 ? false : true,
                ),
              ).showPointerOnHover,
            ],
          )
        ]);
  }

  Widget buildBody(AsyncSnapshot<PostInfo> snapshot) {
    return Container(
      child: SingleChildScrollView(
        controller: controller,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: <Widget>[
              navigationBar(),
              SizedBox(
                height: 20,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.teal[800],
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 40),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Column(children: <Widget>[
                      /////////////////// USER SECTION
                      _userSection(),

                      ////////////////// TITLE SECTION
                      _titleSection(),

                      /////////////////// IMAGE SECTION
                      Image.network(
                        wwwrootURL + post.imagePath,
                        fit: BoxFit.cover,
                        height: 584.5,
                      ),

                      /////////////////// DESCRIPTION SECTION
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 20, top: 7),
                            decoration: BoxDecoration(
                                border: Border(
                              top: BorderSide(color: Colors.grey.shade500),
                            )),
                            child: Text(
                              post.description,
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 18),
                              softWrap: true,
                            ),
                          )),
                        ],
                      ),

                      /////////////////// ACTION SECTION
                      actionSection(snapshot),

                      /////////////////// COMMENT SECTION
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
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
                                )
                              ],
                            ),
                            Container(
                              child: SingleChildScrollView(
                                  child: commentSection(snapshot)),
                            ),
                            loginAdmin.isEmpty == true
                                ? SizedBox(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(left: 20),
                                            child: TextField(
                                              controller: textCtrl,
                                              decoration: InputDecoration(
                                                hintText: 'Dodajte komentar...',
                                              ),
                                            ).showPointerOnHover,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            Comment comm = new Comment(
                                                snapshot.data.id,
                                                loginInstitutionID,
                                                textCtrl.text,
                                                DateTime.now(),
                                                false);
                                            setState(() {
                                              APIComments.addComment(
                                                  Token.jwt, comm);
                                            });
                                            textCtrl.clear();
                                          },
                                        ).showPointerOnHover,
                                      ],
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),
                    ]),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _solutionOrChalengeButton() {
    RaisedButton raisedButton;
    if (post.typeId == 2) //resenje nekog izazova
    {
      raisedButton = RaisedButton(
        elevation: 3,
        child: Text(
          "Ovo je rešenje izazova",
          style: TextStyle(color: Colors.white),
        ).showPointerOnHover,
        onPressed: () async {
          int isApproved = 0;
          if (await (APIChallengeAndSolution.isSolutionApproved(
                  Token.jwt, post.id)) ==
              true) isApproved = 1;
          // PostInfo postInfo = (await APIServices.getChallengeOrSolution(
          //     Token.jwt, post.id, isApproved))[0];
          // if (postInfo != null) {
          //   ShowPost.post = postInfo;
          //   Navigator.push(context,
          //       MaterialPageRoute<void>(builder: (context) => ShowPost()));
          // } else
          //   _showSnakBarMsg("GRESKA");
          if ((await APIChallengeAndSolution.getChallengeOrSolution(
                      Token.jwt, post.id, isApproved))
                  .length !=
              0) {
            PostInfo postInfo =
                (await APIChallengeAndSolution.getChallengeOrSolution(
                    Token.jwt, post.id, isApproved))[0];
            setState(() {
              ShowPost.post = postInfo;
              Navigator.push(context,
                  MaterialPageRoute<void>(builder: (context) => ShowPost()));
            });
          } else {
            print("Neeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
            showSnackBar(context, "Izazov je obrisan.");
          }
        },
        color: Colors.teal[800],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      );
    } else //izazov
    {
      if (post.typeId == 1) //neresen, aktivan izazov
      {
        return Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Row(
            children: <Widget>[
              //ako je inst, posto admin ne moze da reaguje
              loginAdmin.isEmpty == true ? _solveSolutionButton() : Container(),
              SizedBox(
                width: 10,
              ),
              _solutionsButton()
            ],
          ),
        );
      } else if (post.typeId == 3) //resen, zavrsen izazov
      {
        raisedButton = RaisedButton(
          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
          child: Text(
            "Izazov je završen.\nPogledajte rešenja",
            style: TextStyle(color: Colors.white),
          ).showPointerOnHover,
          onPressed: () {
            SolutionPage.post = post;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => SolutionPage()));
          },
          color: Colors.teal[800],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        );
      } else {
        raisedButton = null;
        print('Greskaaaaaaa');
      }
    }
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: raisedButton,
    );
  }

  showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  Widget commentSection(AsyncSnapshot<PostInfo> snapshot) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: 20.0),
          FutureBuilder(
            future: APIComments.getComments(Token.jwt, post.id),
            builder: (BuildContext context,
                AsyncSnapshot<List<CommentInfo>> snapshotCom) {
              if (snapshotCom.data == null) {
                return Container();
              } else {
                return snapshotCom.data.length == 0
                    ? Container()
                    : Container(
                        height: 250, child: _buildCommentList(snapshotCom));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _solutionsButton() {
    return RaisedButton(
      child: Text(
        loginAdmin.isEmpty == false
            ? "Izazov jos uvek traje.\n Pogledajte rešenja"
            : "Pogledajte rešenja",
        style: TextStyle(color: Colors.white),
      ).showPointerOnHover,
      onPressed: () {
        SolutionPage.post = post;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => SolutionPage()));
      },
      color: Colors.teal[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }

  Widget _solveSolutionButton() {
    return RaisedButton(
      child: Text(
        "Reši ovaj izazov",
        style: TextStyle(color: Colors.white),
      ).showPointerOnHover,
      onPressed: () {
        SolutionDialog.post = post;
        DialogHelper.solve(context);
      },
      color: Colors.teal[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }

  Widget _buildCommentList(AsyncSnapshot<List<CommentInfo>> snapshot) {
    return SizedBox(
        child: ListView.separated(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return _cardComment(snapshot.data[index]);
            },
            separatorBuilder: (context, index) {
              return Divider(
                thickness: 1.5,
              );
            }));
  }

  UserInfo user;
  Widget _cardComment(CommentInfo comment) {
    isLiked = comment.isLike;
    isDislaked = comment.isDislike;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
            onTap: () {},
            leading: InkWell(
              onTap: () async {
                UserInfo user =
                    await APIUsers.getUserInfoById(comment.userId, Token.jwt);
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (context) => UserProfile(user: user)));
              },
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage(wwwrootURL + comment.profilePhoto),
              ),
            ).showPointerOnHover,
            title: Text(
              comment.username,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
            subtitle: Text(comment.content)),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.thumb_up),
              onPressed: () {
                setState(() {
                  CommentReaction commReaction = new CommentReaction(
                      comment.id, loginInstitutionID, 1, DateTime.now(), false);
                  APIComments.addCommentReaction(Token.jwt, commReaction);
                });
              },
              color: isLiked == true ? Colors.blue[500] : Colors.grey[500],
              iconSize: 20.0,
            ).showPointerOnHover,
            InkWell(
                    onTap: () {
                      UsersThatReacted.filterIndex = 1;
                      UsersThatReacted.commentID = comment.id;
                      ToUsersThatReacted.solve(context);
                    },
                    child: Text(comment.commentLikes.toString()))
                .showPointerOnHover,
            IconButton(
              icon: Icon(Icons.thumb_down),
              onPressed: () {
                setState(() {
                  CommentReaction commReaction = new CommentReaction(comment.id,
                      loginInstitutionID, -1, DateTime.now(), false);
                  APIComments.addCommentReaction(Token.jwt, commReaction);
                });
              },
              color: isDislaked == true ? Colors.red[500] : Colors.grey[500],
              iconSize: 20.0,
            ).showPointerOnHover,
            InkWell(
                    onTap: () {
                      UsersThatReacted.filterIndex = 2;
                      UsersThatReacted.commentID = comment.id;
                      ToUsersThatReacted.solve(context);
                    },
                    child: Text(comment.commentDislikes.toString()))
                .showPointerOnHover
          ],
        ),
      ],
    );
  }

  Widget actionSection(AsyncSnapshot<PostInfo> snapshot) {
    return Container(
        child: // snapshot.data.typeId != solution?
            Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(children: [
          //admin ne moze da reaguje
          loginAdmin.isEmpty == true
              ? IconButton(
                  icon: snapshot.data.typeId != solution
                      ? Icon(
                          stared ? Icons.star : Icons.star_border,
                          color: stared ? Colors.yellow[600] : Colors.black87,
                          size: 33.0,
                        )
                      : FaIcon(FontAwesomeIcons.signLanguage,
                          color: stared ? Colors.yellow[600] : Colors.grey[500],
                          size: 33.0),
                  onPressed: () {
                    setState(() {
                      APIPosts.postReaction(
                          Token.jwt, snapshot.data.id, loginInstitutionID);
                    });
                  },
                ).showPointerOnHover
              : Container(),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8),
            child: InkWell(
              onTap: () {
                UsersThatReacted.filterIndex = 0;
                ToUsersThatReacted.solve(context);
              },
              child: Row(
                children: <Widget>[
                  Text(
                    snapshot.data.reactionsNumber.toString(),
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    snapshot.data.typeId != solution
                        ? ' ljudi kaze da je vazno'
                        : ' ljudi je pohvalilo',
                    style: TextStyle(fontSize: 16.0),
                  )
                ],
              ),
            ).showPointerOnHover,
          ),
        ]),
      ],
    ));
    //: Rating());
  }

  Widget _deleteMenu() {
    return Container(
      alignment: Alignment.bottomRight,
      child: IconButton(
        icon: Icon(
          Icons.delete,
          size: 30,
        ),
        onPressed: () {
          print('Delete post');
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(
                    'Da li ste sigurni da zelite da obrisete objavu?',
                    style: TextStyle(fontSize: 20),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        'Da',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () async {
                        await APIPosts.deletePost(Token.jwt, post.id);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => loginAdmin.isEmpty == false
                                ? HomePage.fromBase64(Token.jwt)
                                : HomePageInstitutions(),
                          ),
                        );
                      },
                    ).showPointerOnHover,
                    FlatButton(
                        child: Text(
                          'Odustani',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }).showPointerOnHover
                  ],
                );
              });
        },
      ).showPointerOnHover,
    );
  }

  // void _showSnakBarMsg(String msg) {
  //   _scaffoldstate.currentState
  //       .showSnackBar(new SnackBar(content: new Text(msg)));
  // }
}
