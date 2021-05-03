import 'package:WEB_flutter/config/config.dart';
import 'package:WEB_flutter/models/category.dart';
import 'package:WEB_flutter/models/institution.dart';
import 'package:WEB_flutter/screens/institutions/profilePage/instProfile.dart';
import 'package:WEB_flutter/services/APIInstitutions.dart';
import 'package:WEB_flutter/services/token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:WEB_flutter/models/city.dart';
import 'package:WEB_flutter/services/APIServices.dart';
import 'package:WEB_flutter/hover_extensions.dart';
import 'navigatinBar.dart';

class ShowInstitutions extends StatefulWidget {
  @override
  _ShowInstitutionsState createState() => _ShowInstitutionsState();
}

class _ShowInstitutionsState extends State<ShowInstitutions> {
  //final ScrollController controller = ScrollController();
  int categoryID = 0;
  int cityID = 0;
  Future<List<Institution>> _fun;

  @override
  void initState() {
    this._fun = APIInstitutions.getInstitutionsByCityAndCategoryNEW(
        Token.jwt, categoryID, cityID);
    super.initState();
  }

  void refresh() {
    this._fun = APIInstitutions.getInstitutionsByCityAndCategoryNEW(
        Token.jwt, categoryID, cityID);
    setState(() {});
  }

  static GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldstate,
      body: SingleChildScrollView(
        //controller: controller,
        child: LayoutBuilder(builder: (context, constraints) {
          return Padding(
            padding: constraints.maxWidth > 1400
                ? EdgeInsets.symmetric(horizontal: 70, vertical: 40)
                : EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: <Widget>[SmallNavigationBar(), buildPageBody()],
            ),
          );
        }),
      ),
    );
  }

  static void _showSnakBarMsg(String msg) {
    _scaffoldstate.currentState
        .showSnackBar(new SnackBar(content: new Text(msg)));
  }

  Widget buildPageBody() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        cityDropdown(),
                        SizedBox(
                          width: 20,
                        ),
                        categoryDropdown(),
                        refreshDropDown()
                      ],
                    )),
              ),
            ],
          ),
          institutions()
        ],
      ),
    );
  }

  Widget refreshDropDown() {
    return RawMaterialButton(
      onPressed: () {
        setState(() {
          dropdownValueCity = null;
          dropdownValueCategory = null;
          categoryID = 0;
          cityID = 0;
          refresh();
        });
      },
      child: Icon(
        Icons.refresh,
        size: 20.0,
        color: Colors.grey[200],
      ),
      shape: CircleBorder(),
      elevation: 2.0,
      fillColor: Color.fromRGBO(24, 74, 69, 1),
    ).showPointerOnHover;
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
            categoryList.add(new Category.id(0,'Sve kategorije'));
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
                    items: categoryList//snapshot.data
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
                        categoryID = dropdownValueCategory.id;
                        refresh();
                      });
                    },
                    value: dropdownValueCategory == null
                        ? dropdownValueCategory
                        : categoryList//snapshot.data
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
          cityList.add(new City.id(0,'Svi gradovi'));
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
                        cityID = dropdownValueCity.id;
                        refresh();
                      });
                    },
                    value: dropdownValueCity == null
                        ? dropdownValueCity
                        : cityList//snapshot.data
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

  Widget institutions() {
    // int categoryID =
    //     dropdownValueCategory != null ? dropdownValueCategory.id : 0;
    // int cityID = dropdownValueCity != null ? dropdownValueCity.id : 0;
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future:
              _fun, //APIServices.getInstitutionsByCityAndCategory(Token.jwt, categoryID, cityID),
          initialData: [],
          builder: (context, snapshot) {
            //(BuildContext context, AsyncSnapshot<List<Institution>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: Container(
                      child: SpinKitFadingCircle(
                color: Colors.white,
                size: 50.0,
              )));
            } else if (snapshot.data.length == 0) {
              return Center(
                child: Text('Nema institucija za odabrane parametre.'),
              );
            } else {
              return LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth > 550) {
                  return GridView.count(                    
                    crossAxisCount: constraints.maxWidth > 1100
                        ? 4
                        : constraints.maxWidth > 850 ? 3 : 2,
                    childAspectRatio: constraints.maxWidth > 1100
                        ? (MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height * 2.3))
                        : constraints.maxWidth > 850
                            ? (MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height * 1.7))
                            : (MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height * 1.2)),
                    children: <Widget>[
                      for (var i = 0; i < snapshot.data.length; i++)
                        _Tile(institutionID: snapshot.data[i].id)
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _Tile(institutionID: snapshot.data[index].id);
                      });
                }
              });
            }
          },
        ),
      ),
    );
  }
}

class _Tile extends StatefulWidget {
  final int institutionID;
  const _Tile({Key key, this.institutionID}) : super(key: key);

  @override
  __TileState createState() => __TileState();
}

class __TileState extends State<_Tile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 400,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(24, 74, 69, 1),
      ),
      child: FutureBuilder(
        future:
            APIInstitutions.getInstitutionByID(widget.institutionID, Token.jwt),
        builder: (BuildContext context, AsyncSnapshot<Institution> snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: Text('Ucitavanje'),
            );
          else
            return Column(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            //image: AssetImage('assets/jkp.jpg'),
                            image: NetworkImage(
                                wwwrootURL + snapshot.data.profilePhoto),
                          ),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                        ),
                      ),
                      Container(
                        width: 70,
                        height: snapshot.data.isVerified ? 45 : 90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                topLeft: Radius.circular(20)),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.transparent,
                                  Colors.transparent
                                ])),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: FlatButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    InstitutionProfile(
                                                      institution:
                                                          snapshot.data,
                                                    )));
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: snapshot.data.isVerified 
                                          ? BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20)) 
                                          : BorderRadius.only(topLeft: Radius.circular(20))
                                      ),
                                      child: Icon(Icons.home))
                                  .showPointerOnHover,
                            ),
                            _makeVarification(snapshot.data),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        color: Color.fromRGBO(255, 255, 255, 0.2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              snapshot.data.name,
                              style: TextStyle(
                                  color: Colors.grey[200], fontSize: 20),
                            )),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.person,
                                      color: Colors.grey[200],
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        snapshot.data.username,
                                        style: TextStyle(
                                            color: Colors.grey[200],
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.email,
                                        color: Colors.grey[200],
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          snapshot.data.email,
                                          style: TextStyle(
                                              color: Colors.grey[200],
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.phone,
                                      color: Colors.grey[200],
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        snapshot.data.phone,
                                        style: TextStyle(
                                            color: Colors.grey[200],
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
        },
      ),
    );
  }

  Widget _makeVarification(Institution institution) {
    bool verification = institution.isVerified;
    if (verification == false) {
      return Expanded(
        flex: 1,
        child: FlatButton(
                onPressed: () async {
                  var v = await APIInstitutions.verifyInstitution(
                      Token.jwt, institution.id);
                  setState(() {
                    verification = v;
                  });
                  if (v == true)
                    _ShowInstitutionsState._showSnakBarMsg(
                        'Uspesno ste verifikovali instituciju.');
                  else
                    _ShowInstitutionsState._showSnakBarMsg(
                        'Doslo je do greske.');
                },
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(20))),
                child: Icon(Icons.check_circle_outline))
            .showPointerOnHover,
      );
    } else
      return Container();
  }
}
