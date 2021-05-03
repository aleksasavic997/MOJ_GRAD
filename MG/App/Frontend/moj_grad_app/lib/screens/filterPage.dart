import 'package:flutter/material.dart';
import 'package:mojgradapp/config/config.dart';
import 'package:mojgradapp/functions/bottomNavigationBar.dart';
import 'package:mojgradapp/models/institution.dart';
import 'package:mojgradapp/screens/institutePage.dart';
import 'package:mojgradapp/services/APIInstitutions.dart';
import "dart:math";
import '../main.dart';
import '../models/category.dart';
import '../models/city.dart';
import '../services/APIServices.dart';
import '../services/token.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<StoryInfo> _storyInfoList = [];
  PageController pageController = PageController(initialPage: 0);
  double currentPage = 0.0;
  int cityID = loginUser.cityId;
  //int _cityId = loginUser.cityId;
  String _category = "Kategorija";
  int categoryID = 0;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page;
      });
    });

    makeInstitutions();
  }

  void makeInstitutions() async {
    _storyInfoList = [];
    List<Institution> institutions =
        await APIInstitutions.getInstitutionsByCityAndCategory(
            Token.jwt, categoryID, cityID);
    setState(() {
      for (var institution in institutions) {
        _storyInfoList.add(StoryInfo(
            id: institution.id,
            image: wwwrootURL + institution.profilePhoto,
            title: institution.name));
      }
    });
  }

  var _currentCategory;
  var _currentCity;
  @override
  Widget build(BuildContext context) {
    // makeInstitutions();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("Institucije"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
          Container(
            color: Theme.of(context).backgroundColor,
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[buildCategory(), buildCityList()],
                  ),
                ),
                _buildStoryCards(),
              ],
            ),
          ),
        ]),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        value: 1,
      ),
    );
  }

  _buildStoryCards() {
    return _storyInfoList != null
        ? Container(
            margin: EdgeInsets.only(top: 10),
            // color: Colors.teal[800],
            height: 420,
            child: Stack(
              children: <Widget>[
                Cards(
                  currentPage: currentPage,
                  storyInfoList: _storyInfoList,
                ),
                PageView.builder(
                  controller: pageController,
                  itemCount: _storyInfoList.length,
                  itemBuilder: (context, idx) {
                    /*return Container(
                color: Color(Random().nextInt(0xffffffff)),
              );*/
                    return new GestureDetector(
                      onTap: () async {
                        //print("Action at card ${currentPage}");
                        InstitutePage.institution =
                            await APIInstitutions.getInstitutionByID(
                                _storyInfoList[idx].id, Token.jwt);
                        print(InstitutePage.institution.id);
                        Navigator.of(context).pushNamed('/institutePage');
                      },
                    );
                  }, //komentar
                )
              ],
            ),
          )
        : Center(
            child: Text(
            "Trenutno nema institucija za izabranu kategoriju i gard",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ));
  }

  Widget buildCityList() {
    return Container(
      child: FutureBuilder<List<City>>(
          future: APIServices.fetchCity(),
          builder: (BuildContext context, AsyncSnapshot<List<City>> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return DropdownButtonHideUnderline(
              child: DropdownButton<City>(
                //icon: Icon(Icons.location_city),
                items: snapshot.data
                    .map((city) => DropdownMenuItem<City>(
                          child: Text(city.name),
                          value: city,
                        ))
                    .toList(),
                onChanged: (City value) {
                  setState(() {
                    _currentCity = value;
                    cityID = _currentCity.id;
                    makeInstitutions();
                  });
                },
                isExpanded: false,
                //value: _currentUser,
                hint: Row(
                  children: <Widget>[
                    Icon(Icons.location_city),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      _currentCity == null
                          ? loginUser.cityName
                          : _currentCity.name,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.teal[900],
                      ),
                    ),
                  ],
                ),
                //underline: UnderlineInputBorder(),
              ),
            );
          }),
    );
  }

  Widget buildCategory() {
    return Container(
      child: FutureBuilder<List<Category>>(
          future: APIServices.fetchCategories(Token.jwt),
          builder:
              (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return DropdownButtonHideUnderline(
              child: DropdownButton<Category>(
                items: snapshot.data
                    .map((category) => DropdownMenuItem<Category>(
                          child: Text(category.name),
                          value: category,
                        ))
                    .toList(),
                onChanged: (Category value) {
                  setState(() {
                    _currentCategory = value;
                    categoryID = _currentCategory.id;
                    makeInstitutions();
                  });
                },
                isExpanded: false,
                //value: _currentUser,
                hint: Row(
                  children: <Widget>[
                    Icon(Icons.category),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      _currentCategory == null
                          ? _category
                          : _currentCategory.name,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.teal[900],
                      ),
                    ),
                  ],
                ),
                //underline: UnderlineInputBorder(),
              ),
            );
          }),
    );
  }
}

class Cards extends StatefulWidget {
  final List<StoryInfo> storyInfoList;
  final double currentPage;
  Cards({Key key, this.currentPage, this.storyInfoList}) : super(key: key);

  @override
  _CardsState createState() => _CardsState(storyInfoList: storyInfoList);
}

class _CardsState extends State<Cards> {
  List<StoryInfo> storyInfoList;

  _CardsState({this.storyInfoList});

  @override
  Widget build(BuildContext context) {
    if (widget.storyInfoList.length == 0) {
      return Center(
        child: Text('Trenutno nema institucija za prikaz.'),
      );
    } else
      return Container(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            List<Widget> stackWidgets = [];

            double cardAspectRatio = 3.0 / 4.0;

            double width = constraints.maxWidth;
            double height = constraints.maxHeight;
            double padding = 20.0;

            double cardsAreaWidth = width - padding * 2;
            double cardsAreaHeight = height - padding * 2;

            double cardHeight = cardsAreaHeight;
            double cardWidth = cardHeight * cardAspectRatio;

            double intervalLeft = cardWidth + padding;
            double intervalRight = (cardsAreaWidth - cardWidth) / 2.0;

            for (var i = 0; i < widget.storyInfoList.length; i++) {
              StoryInfo storyInfo = widget.storyInfoList[i];
              double end = 0;
              double currentPosition = -(widget.currentPage - i);
              //print("i=${i}, currentPosition = ${currentPosition}");
              if (currentPosition <= 0) {
                end = padding +
                    intervalRight * 2 -
                    (intervalLeft * currentPosition);
              } else {
                end = padding + intervalRight * (2 - currentPosition);
              }
              if (end < padding) {
                end = padding;
              }
              Widget card = _cardBuilder(
                  storyInfo, currentPosition, padding, end, cardAspectRatio);
              stackWidgets.add(card);
            }
            stackWidgets = stackWidgets.reversed.toList();
            return Stack(
              children: stackWidgets,
            );
          },
        ),
      );
  }

  Widget _cardBuilder(StoryInfo storyInfo, double currentPosition,
      double padding, double end, double cardAspectRatio) {
    return Positioned.directional(
      top: padding + 20 * max(currentPosition, 0),
      bottom: padding + 20 * max(currentPosition, 0),
      end: end,
      textDirection: TextDirection.ltr,
      child: AspectRatio(
        aspectRatio: cardAspectRatio,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2.0),
            color: Colors.teal[800],
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(top: 18),
                      child: Text(storyInfo.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.3,
                            //fontFamily: "SF-Pro-Text-Regular"
                          )),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: MediaQuery.of(context).size.width * 3,
                    margin: EdgeInsets.only(
                        //top: 19,
                        //bottom: 30,
                        ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(storyInfo.image),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StoryInfo {
  String image;
  String title;
  int id;
  StoryInfo({this.id, this.image, this.title});
}
