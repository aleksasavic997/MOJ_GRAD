import 'package:WEB_flutter/models/category.dart';
import 'package:WEB_flutter/models/city.dart';
import 'package:WEB_flutter/models/modelsViews/institutionInfo.dart';
import 'package:WEB_flutter/screens/institutions/changeData.dart';
import 'package:WEB_flutter/screens/login/loginPage.dart';
import 'package:WEB_flutter/services/APIInstitutions.dart';
import 'package:WEB_flutter/services/APIPosts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:WEB_flutter/config/config.dart';
import 'package:WEB_flutter/models/modelsViews/postInfo.dart';
import 'package:WEB_flutter/services/APIServices.dart';
import 'package:WEB_flutter/services/token.dart';
import 'package:WEB_flutter/main.dart';
import 'package:WEB_flutter/hover_extensions.dart';
import '../showPost/showPost.dart';
import 'profilePage/instProfile.dart';

class HomePageInstitutions extends StatefulWidget {
  @override
  _HomePageInstitutionsState createState() => _HomePageInstitutionsState();
}

class _HomePageInstitutionsState extends State<HomePageInstitutions> {
  final ScrollController controller = ScrollController();
  int crossAxisCount = 4;
  int idInst = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
          child: Column(
            children: <Widget>[navBar(), buildPageBody()],
          ),
        ),
      ),
    );
  }

  Widget _profileMenu() {
    return Padding(
      padding: EdgeInsets.only(right: 30.0),
      child: CircleAvatar(
          radius: 26,
          backgroundColor: Colors.teal[900],
          child: Center(
            child: PopupMenuButton(
                tooltip: "Opcije",
                //color: Colors.teal[900],
                icon: Icon(Icons.menu, color: Colors.white),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'val_one',
                        child: Text('Izmenite svoje informacije')
                            .showPointerOnHover,
                      ),
                      PopupMenuItem<String>(
                        value: 'val_two',
                        child: Text('Odjava').showPointerOnHover,
                      ),
                    ],
                onSelected: (value) async {
                  InstitutionProfile.showNotifications = false;
                  //print(value);
                  switch (value) {
                    case 'val_one':
                      //ChangeData.institution = institution;
                      InstitutionInfo pomInst =
                          await APIInstitutions.getInstitutionInfoByID(
                              loginInstitutionID, Token.jwt);
                      showDialog(
                          context: context,
                          builder: (context) => ChangeData(
                                institution: pomInst,
                              ));
                      break;
                    case 'val_two':
                      loginInstitution = null;
                      loginInstitutionID = null;
                      //Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);
                      Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                              builder: (context) => LoginPage()));
                      break;
                  }
                }),
          )),
    );
  }

  Widget navBar() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/webLogo.png',
                width: 150,
                height: 80,
              ),
              Text(
                'Moj Grad ', //ostavi razmak posle d
                style: TextStyle(fontSize: 30.0, fontFamily: 'Pacifico'),
              )
            ],
          ),
          _profileMenu(),
        ],
      ),
    );
  }

  Widget buildPageBody() {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(24, 74, 69, 1),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black26))),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth > 470) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              institutionProfile(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  categoryDropdown(),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  cityDropdown(),
                                  refresh(),
                                ],
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  institutionProfile(),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  categoryDropdown(),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  cityDropdown(),
                                  refresh(),
                                ],
                              ),
                            ],
                          );
                        }
                      },
                    )),
              ),
            ],
          ),
          showPosts()
        ],
      ),
    );
  }

  Widget refresh() {
    return IconButton(
      onPressed: () {
        setState(() {
          dropdownValueCity = null;
          dropdownValueCategory = null;
        });
      },
      icon: Icon(
        Icons.refresh,
        color: Colors.white,
      ),
    ).showPointerOnHover;
  }

  Widget showPosts() {
    return FutureBuilder(
      future: _makeFuture(),
      builder: (BuildContext context, AsyncSnapshot<List<PostInfo>> snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: Container(
              child: SpinKitFadingCircle(
                color: Colors.white,
                size: 50,
              ),
            ),
          );
        } else if (snapshot.data.length == 0) {
          return Container(
            height: 400,
            child: Center(
              child: Text('Trenutno nema objava za prikaz.', style: TextStyle(color: Colors.white),),
            ),
          );
        } else {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: MediaQuery.of(context).size.height,
            child: LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth > 550) {
                return GridView.count(
                  crossAxisCount: constraints.maxWidth > 1100
                      ? 4
                      : constraints.maxWidth > 850 ? 3 : 2,
                  childAspectRatio: constraints.maxWidth > 1100
                      ? (MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height * 2.5))
                      : constraints.maxWidth > 850
                          ? (MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height * 1.9))
                          : (MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height * 1.38)),
                  children: <Widget>[
                    for (var i = 0; i < snapshot.data.length; i++)
                      _Tile(
                        post: snapshot.data[i],
                      )
                  ],
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _Tile(post: snapshot.data[index]);
                    });
              }
            }),
          );
        }
      },
    );
  }

  Widget institutionProfile() {
    return Container(
      padding: EdgeInsets.only(left: 30),
      child: FlatButton(
        shape: CircleBorder(),
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InstitutionProfile(
                        institution: loginInstitution,
                      )));
        },
        child: Container(
          padding: EdgeInsets.all(8),
          child: Icon(
            Icons.account_balance,
            color: Colors.grey[200],
            size: 40,
          ),
        ),
      ).showPointerOnHover,
    );
  }

  Future<List<PostInfo>> _makeFuture() {
    if (dropdownValueCategory == null && dropdownValueCity == null)
      return APIPosts.getPostsForInstitution(Token.jwt, loginInstitutionID);
    else if (dropdownValueCity == null)
      return APIPosts.getPostsByCategory(Token.jwt, dropdownValueCategory.id);
    else if (dropdownValueCategory == null)
      return APIPosts.getPostsByCity(Token.jwt, dropdownValueCity.id);
    else
      return APIPosts.getPostsByCityAndCategory(
          Token.jwt, dropdownValueCity.id, dropdownValueCategory.id);
  }

  Category dropdownValueCategory;
  Widget categoryDropdown() {
    return FutureBuilder(
        future: APIServices.getCategory(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
          if (!snapshot.hasData) {
            print('nemaaaa');
            return Center(
              child: Container(
                child: SpinKitFadingCircle(
                  color: Color.fromRGBO(24, 74, 69, 1),
                  size: 30,
                ),
              ),
            );
          } else {
            List<Category> categoryList = new List<Category>();
            categoryList.add(new Category.id(0, 'Sve kategorije'));
            for (var item in snapshot.data) {
              categoryList.add(item);
            }
            print('imaaaaa');
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromRGBO(24, 74, 69, 1)),
              child: Theme(
                data: ThemeData(canvasColor: Color.fromRGBO(24, 74, 69, 1)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Category>(
                    iconEnabledColor: Colors.grey[200],
                    items: categoryList //snapshot.data
                        .map((Category category) => DropdownMenuItem<Category>(
                              value: category,
                              child: Text(
                                category.name,
                                style: TextStyle(color: Colors.grey[200]),
                              ).showPointerOnHover,
                            ))
                        .toList(),
                    onChanged: (Category newValue) {
                      setState(() {
                        dropdownValueCategory = newValue;
                        //categoryID = dropdownValueCategory.id;
                        refresh();
                      });
                    },
                    value: dropdownValueCategory == null
                        ? dropdownValueCategory
                        : categoryList //snapshot.data
                            .where((i) => i.name == dropdownValueCategory.name)
                            .first,
                    hint: Text(
                      'Kategorija',
                      style: TextStyle(color: Colors.grey[200]),
                    ),
                  ),
                ),
              ).showPointerOnHover,
            );
          }
        });
  }

  City dropdownValueCity;
  Widget cityDropdown() {
    return FutureBuilder(
      future: APIServices.getCity(),
      builder: (BuildContext context, AsyncSnapshot<List<City>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Container(
              child: SpinKitFadingCircle(
                color: Color.fromRGBO(24, 74, 69, 1),
                size: 30,
              ),
            ),
          );
        } else {
          List<City> cityList = new List<City>();
          cityList.add(new City.id(0, 'Svi gradovi'));
          for (var item in snapshot.data) {
            cityList.add(item);
          }
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromRGBO(24, 74, 69, 1)),
              child: Theme(
                data: ThemeData(canvasColor: Color.fromRGBO(24, 74, 69, 1)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    iconEnabledColor: Colors.grey[200],
                    items: cityList //snapshot.data
                        .map((City city) => DropdownMenuItem<City>(
                              value: city,
                              child: Text(
                                city.name,
                                style: TextStyle(color: Colors.grey[200]),
                              ).showPointerOnHover,
                            ))
                        .toList(),
                    onChanged: (City newValue) {
                      setState(() {
                        dropdownValueCity = newValue;
                        //cityID = dropdownValueCity.id;
                        refresh();
                      });
                    },
                    value: dropdownValueCity == null
                        ? dropdownValueCity
                        : cityList //snapshot.data
                            .where((i) => i.name == dropdownValueCity.name)
                            .first,
                    hint: Text(
                      'Grad',
                      style: TextStyle(color: Colors.grey[200]),
                    ),
                  ),
                ).showPointerOnHover,
              ));
        }
      },
    );
  }
}

class _Tile extends StatelessWidget {
  final PostInfo post;

  const _Tile({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: RaisedButton(
        onPressed: () {
          ShowPost.post = post;
          Navigator.push(context,
              MaterialPageRoute<void>(builder: (context) => ShowPost()));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 300,
                      padding: EdgeInsets.only(top: 15),
                      child: ClipRect(
                        child: Image.network(
                          wwwrootURL + post.imagePath,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(post.title),
                    subtitle: LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth > 220) {
                          return Text(post.description.length > 30
                              ? post.description.substring(0, 30) + '...'
                              : post.description);
                        } else {
                          return Text(post.description.length > 20
                              ? post.description.substring(0, 20) + '...'
                              : post.description);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ).showPointerOnHover,
    );
  }
}
