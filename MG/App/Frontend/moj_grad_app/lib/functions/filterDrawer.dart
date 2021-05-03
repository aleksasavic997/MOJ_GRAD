import 'package:flutter/material.dart';
import 'package:mojgradapp/models/category.dart';
import 'package:mojgradapp/models/city.dart';
import 'package:mojgradapp/screens/homePage.dart';
import 'package:mojgradapp/screens/posts/showPosts.dart';
import 'package:mojgradapp/services/APIServices.dart';
import 'package:mojgradapp/services/token.dart';

import '../main.dart';

class FilterDrawer extends StatefulWidget {
  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class MyCheckbox {
  // String title = "";
  Category category;
  bool value;

  MyCheckbox(Category category, bool value) {
    //this.title = title;
    this.value = value;
    this.category = category;
  }
}

class _FilterDrawerState extends State<FilterDrawer> {
  City _currentCity;
  int _selectedRadio;
  bool _cbObjave = HomePage.activeChallenge;
  String _dropdownValue = HomePage.sortByReactions;

  List<MyCheckbox> _categoryList = new List<MyCheckbox>();

  setSelectedRadio(int value) {
    setState(() {
      _selectedRadio = value;
    });
  }

  @override
  void initState() {
    super.initState();

    _selectedRadio = HomePage.fromFollowers;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Grad",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            _cities(),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.grey[500],
              thickness: 1.2,
            ),
            Text(
              "Kategorije",
              style: TextStyle(fontSize: 20),
            ),
            _categories(),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.grey[500],
              thickness: 1.2,
            ),
            Text(
              "Objave",
              style: TextStyle(fontSize: 20),
            ),
            _posts(),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.grey[500],
              thickness: 1.2,
            ),
            Text(
              "Sortiranje",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            _sorting(),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.grey[500],
              thickness: 1.2,
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      HomePage.city = null;
                      HomePage.categories.clear();
                      HomePage.fromFollowers = 0;
                      HomePage.activeChallenge = false;
                      HomePage.sortByReactions = 'Po vremenu';

                      ShowPosts.cityID = loginUser.cityId;
                      ShowPosts.fromFollowers = 0;
                      ShowPosts.activeChallenge = 0;
                      ShowPosts.sortByReactions = 0;
                      ShowPosts.categories.clear();
                      Navigator.of(context).pushNamed('/home');
                    });
                  },
                  child: Text(
                    "Resetuj filtere",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.teal[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                RaisedButton(
                  child: Text(
                    "Primeni filtere",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    var cityID = (_currentCity == null && HomePage.city==null)
                        ? loginUser.cityId
                        : (_currentCity==null ? HomePage.city.id : _currentCity.id);
                    var fromFollowers = _selectedRadio;
                    var activeChallenge = _cbObjave == false ? 0 : 1;
                    var sortByReactions =
                        _dropdownValue == 'Po vremenu' ? 0 : 1;
                    List<Category> categories = List<Category>();
                    for (var cat in _categoryList) {
                      if (cat.value == true) {
                        print(cat);
                        categories.add(cat.category);
                      }
                    }
                    setState(() {
                      if(_currentCity!=null)
                      {
                        HomePage.city = _currentCity;
                      }
                      HomePage.categories = List.from(categories);
                      HomePage.fromFollowers = _selectedRadio;
                      HomePage.activeChallenge = _cbObjave;
                      HomePage.sortByReactions = _dropdownValue;

                      ShowPosts.cityID =cityID;
                      ShowPosts.fromFollowers = fromFollowers;
                      ShowPosts.activeChallenge = activeChallenge;
                      ShowPosts.sortByReactions = sortByReactions;
                      ShowPosts.categories = categories;
                    });
                   
                    Navigator.of(context).pushNamed('/home');
                  },
                  color: Colors.teal[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }

  Widget _sorting() {
    return Container(
      height: 40,
      decoration: BoxDecoration(border: Border.all(color: Colors.teal[900])),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _dropdownValue,
            items: <String>['Po vremenu', 'Po broju reakcija']
                .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.teal[900],
                            ),
                          ),
                        ))
                .toList(),
            onChanged: (String value) {
              setState(() {
                _dropdownValue = value;
              });
            },
            isExpanded: false,
          ),
        ),
      ),
    );
  }

  Widget _posts() {
    return Container(
        child: Column(children: [
      Row(
        children: <Widget>[
          Radio(
              value: 0,
              groupValue: _selectedRadio,
              activeColor: Colors.teal[900],
              onChanged: (value) {
                setSelectedRadio(value);
              }),
          Text("Objave svih korisnika"),
        ],
      ),
      Row(
        children: <Widget>[
          Radio(
              value: 1,
              groupValue: _selectedRadio,
              activeColor: Colors.teal[900],
              onChanged: (value) {
                setSelectedRadio(value);
              }),
          Text("Objave korisnika koje pratim"),
        ],
      ),
      Row(
        children: <Widget>[
          Checkbox(
            activeColor: Colors.teal[900],
            value: _cbObjave,
            onChanged: (value) {
              setState(() {
                _cbObjave = value;
              });
            },
          ),
          Text("Prikaži samo aktivne izazove"),
        ],
      )
    ]));
  }

  Widget _categories() {
    return Container(
      child: FutureBuilder<List<Category>>(
        future: APIServices.fetchCategories(Token.jwt),
        builder:
            (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
          if (!snapshot.hasData)
            return CircularProgressIndicator(
              backgroundColor: Colors.teal[900],
            );
          else {
            if (_categoryList.length == 0) {
              if (HomePage.categories == null) {
                for (int i = 0; i < snapshot.data.length; i++) {
                  _categoryList.add(MyCheckbox(snapshot.data[i], false));
                }
              } else {
                for (int i = 0; i < snapshot.data.length; i++) {
                  int j = 0;
                  for (j = 0; j < HomePage.categories.length; j++) {
                    if (HomePage.categories[j].id == snapshot.data[i].id) {
                      _categoryList.add(MyCheckbox(snapshot.data[i], true));
                      break;
                    }
                  }
                  if (j == HomePage.categories.length) {
                    _categoryList.add(MyCheckbox(snapshot.data[i], false));
                  }
                }
              }
            }
            return Column(
                children: List.generate(
                    snapshot.data.length, (index) => checkbox(index)));
          }
        },
      ),
    );
  }

  Widget checkbox(int index) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Checkbox(
          value: _categoryList[index].value,
          onChanged: (bool value) {
            setState(() {
              _categoryList[index].value = value;
            });
          },
          activeColor: Colors.teal[900],
        ),
        Text(_categoryList[index].category.name),
      ],
    );
  }

  Widget _cities() {
    return Container(
      height: 35,
      decoration: BoxDecoration(border: Border.all(color: Colors.teal[900])),
      child: FutureBuilder<List<City>>(
          future: APIServices.fetchCity(),
          builder: (BuildContext context, AsyncSnapshot<List<City>> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<City>(
                  items: snapshot.data
                      .map((city) => DropdownMenuItem<City>(
                            child: Text(city.name),
                            value: city,
                          ))
                      .toList(),
                  onChanged: (City value) {
                    setState(() {
                      _currentCity = value;
                      print(_currentCity);
                    });
                  },
                  isExpanded: false,
                  hint: Text(
                    HomePage.city == null && _currentCity == null
                        ? loginUser.cityName
                        : (HomePage.city == null && _currentCity != null
                            ? _currentCity.name
                            : HomePage.city.name != null && _currentCity == null
                                ? HomePage.city.name
                                : _currentCity.name),

                    // _currentCity == null
                    //     ? loginUser.cityName
                    //     : _currentCity.name,
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.teal[900],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
