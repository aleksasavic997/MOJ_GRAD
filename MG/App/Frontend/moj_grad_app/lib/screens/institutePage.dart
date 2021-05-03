import 'package:flutter/material.dart';
import 'package:mojgradapp/config/config.dart';
import 'package:mojgradapp/models/institution.dart';
import 'package:mojgradapp/services/APIPosts.dart';

import '../models/modelsViews/postInfo.dart';
import '../services/token.dart';
import 'posts/viewPostPage.dart';

class InstitutePage extends StatefulWidget {
  static Institution institution;
  @override
  _InstitutePageState createState() => _InstitutePageState();
}

class _InstitutePageState extends State<InstitutePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        //title
        automaticallyImplyLeading: false,
        title: Text(
          'Institucija',
          style: Theme.of(context).textTheme.title,
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(top: 30, left: 10, right: 10),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    //padding: EdgeInsets.only(left: 20),
                    child: Text(
                      InstitutePage.institution.name,
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(wwwrootURL +
                                InstitutePage.institution.profilePhoto),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            width: 1.0,
                          ),
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        width: 150,
                        height: 210,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Informacije:",
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.5),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.email),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    InstitutePage.institution.email,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.phone),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    InstitutePage.institution.phone,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.category),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  // Text(
                                  //   "Kategorija 1",
                                  //   style: TextStyle(fontSize: 13),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    //padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Icon(Icons.location_city),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          InstitutePage.institution.address,
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      //padding: EdgeInsets.all(15),
                      child: Text(
                    'Rešeni izazovi',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  _buildPosts(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPosts() {
    return Container(
      //margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          //color: Color.fromRGBO(24, 74, 69, 1),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: <Widget>[
          Container(
              /*decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black38, width: 0.5),
              ),
            ),*/
              ),
          Container(
            //padding: EdgeInsets.all(10.0),
            //margin: EdgeInsets.symmetric(vertical: 10.0),
            height: 300,
            child: FutureBuilder(
                future: APIPosts.getPostsFilteredByType(
                    InstitutePage.institution.id, 2, Token.jwt),
                builder: (BuildContext context,
                    AsyncSnapshot<List<PostInfo>> snapshot) {
                  if (!snapshot.hasData)
                    return CircularProgressIndicator();
                  else {
                    print(InstitutePage.institution.id);
                    return snapshot.data.length == 0
                        ? Center(
                            child: Container(
                                //padding: EdgeInsets.only(top: 20),
                                //height: 20,
                                child: Text("Nema rešenja")))
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return myArticles(
                                  wwwrootURL + snapshot.data[index].imagePath,
                                  snapshot.data[index].title,
                                  snapshot.data[index].title,
                                  snapshot.data[index].id);
                            });
                  }
                }),
          ),
        ],
      ),
    );
  }

  Container myArticles(
      String imageVal, String heading, String subHeading, int index) {
    return Container(
      color: Theme.of(context).backgroundColor,
      width: 200.0,
      child: InkWell(
        onTap: () {
          ViewPost.postId = index;
          Navigator.push(context,
              MaterialPageRoute<void>(builder: (context) => ViewPost()));
        },
        child: Card(
          child: Wrap(
            children: <Widget>[
              Image.network(
                imageVal,
                height: 200.0,
                width: 195.0,
                fit: BoxFit.cover,
              ),
              ListTile(
                title: Text(heading),
                subtitle: Text(subHeading),
              )
            ],
          ),
        ),
      ),
    );
  }
}
