import 'dart:convert';
import 'dart:typed_data';
import 'package:WEB_flutter/config/config.dart';
import 'package:WEB_flutter/main.dart';
import 'package:WEB_flutter/models/category.dart';
import 'package:WEB_flutter/models/city.dart';
import 'package:WEB_flutter/models/institution.dart';
import 'package:WEB_flutter/models/modelsViews/institutionInfo.dart';
import 'package:WEB_flutter/models/userData.dart';
import 'package:WEB_flutter/screens/institutions/profilePage/instProfile.dart';
import 'package:WEB_flutter/screens/institutions/showCategoryDialogChangeData.dart';
import 'package:WEB_flutter/services/APIInstitutions.dart';
import 'package:WEB_flutter/services/APIServices.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:WEB_flutter/hover_extensions.dart';
import 'package:WEB_flutter/services/token.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:universal_html/prefer_universal/html.dart' as html;

class ChangeData extends StatefulWidget {
  final InstitutionInfo institution;
  ChangeData({this.institution});
  @override
  ChangeDataState createState() => ChangeDataState(institution: institution);
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

class ChangeDataState extends State<ChangeData> {
  ChangeDataState({this.institution});

  TextEditingController controllerEmail = new TextEditingController();
  TextEditingController controllerAddress = new TextEditingController();
  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerPhone = new TextEditingController();
  TextEditingController controller = new TextEditingController();
  TextEditingController controllerUsername = new TextEditingController();
  TextEditingController controllerCurrentPass = new TextEditingController();
  TextEditingController controllerNewPass = new TextEditingController();
  TextEditingController controllerNewPassCheck = new TextEditingController();

  ScrollController scrollController = new ScrollController();
  InstitutionInfo institution; //= ChangeData.institution;
  //bool _showField = false;

  bool _currentPassError = false;
  bool _doesMatch = true;
  bool _correctPass = true;

  bool _isVisibleCurrent = false;
  bool _isVisibleNew = false;
  bool _isVisibleCheckNew = false;

  String name = '';
  String error;
  Uint8List data;

  String password = "";

  int indForPassword = 0; //ako je nula znaci da nije menjana sifra
  int cityID = loginInstitution.cityId;
  String hintCity = "";

  static List<Category> listOfCategories = new List<Category>();
  static List<MyCheckbox> categoryListCB = new List<MyCheckbox>();

  @override
  Widget build(BuildContext context) {
    if (controllerAddress.text == "")
      controllerAddress.text = institution.address;
    if (controllerEmail.text == "") controllerEmail.text = institution.email;
    if (controllerName.text == "") controllerName.text = institution.name;
    if (controllerPhone.text == "") controllerPhone.text = institution.phone;
    if (controllerUsername.text == "")
      controllerUsername.text = institution.username;
    password = institution.password;
    if (hintCity.isEmpty) hintCity = institution.getCityName;

    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        child: _buildChild(context));
  }

  Widget _userSection() {
    return Stack(
      children: [
        SizedBox(
          height: 15,
        ),
        MediaQuery.of(context).size.width < 1000
            ? Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  iconSize: 30,
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    listOfCategories = [];
                    categoryListCB = [];
                    Navigator.pop(context);
                  },
                ).showPointerOnHover,
              )
            : Container(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundImage: name == ''
                      ? NetworkImage(wwwrootURL + institution.profilePhoto)
                      : MemoryImage(data),
                  //  child: name != '' ? new Image.memory(data,fit: BoxFit.fill) : null,
                  // child: ClipOval(
                  //   clipper: null,
                  //     child: name != ''
                  //         ? new Image.memory(data,fit: BoxFit.cover)
                  //         : null),
                ),
                SizedBox(
                  width: 10.0,
                ),
                IconButton(
                  icon: Icon(Icons.photo_library),
                  iconSize: 50.0,
                  color: Colors.white,
                  onPressed: () {
                    pickImage();
                  },
                ).showPointerOnHover,
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  changeField("", 1),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(child: _city()),
            SizedBox(
              height: 10,
            ),
            categories(),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ],
    );
  }

  Widget _fields() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            changeField("Korisničko ime", 5),
            SizedBox(
              height: 10,
            ),
            changeField("E-mail", 2),
            SizedBox(
              height: 10,
            ),
            changeField("Adresa", 3),
            SizedBox(
              height: 10,
            ),
            changeField("Broj telefona", 4),
            SizedBox(
              height: 10,
            ),
            changeField("Trenutna šifra", 6),
            _currentPassError == true
                ? Text(
                    "Trenutna lozinka nije ispravna",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  )
                : Container(),
            SizedBox(
              height: 10,
            ),
            changeField("Nova šifra", 7),
            _correctPass == false
                ? Container(
                    //width: MediaQuery.of(context).size.width < 900 ? ,
                    child: Text(
                      MediaQuery.of(context).size.width > 1000
                          ? 'Lozinka mora imati najmanje 8 karaktera, \njedno slovo i jedan broj.'
                          : 'Lozinka mora imati najmanje 8 karaktera, jedno slovo i jedan broj.',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  )
                : Container(),
            SizedBox(
              height: 10,
            ),
            changeField("Potvrdite novu sifru", 8),
            _doesMatch == false
                ? Text(
                    "Lozinke se ne poklapaju",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  )
                : Container(),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget categories() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 80.0,
            child: Text(
              'Kategorije',
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Container(child: buildCategoryList())
        ],
      ),
    );
  }

  Widget buildCategoryList() {
    return InkWell(
      child: Container(
        height: 35.0,
        width: 150.0,
        decoration: BoxDecoration(
            color: Colors.teal[600],
            border: Border.all(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(5.0)),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7),
            child: Text("Izaberite kategorije",
                style: TextStyle(
                  color: Colors.white,
                ))),
      ),
      onTap: () async {
        if (listOfCategories.length == 0) {
          listOfCategories = await APIInstitutions.getCategoriesUserFollow(
              Token.jwt, loginInstitutionID);
        }
        //ako se samo izadje da se ne sacuvaju promene
        ShowCategoryDialogChangeDataState.pomListOfCategories =
            listOfCategories;
        var pom = await APIServices.getCategory();
        int i;
        for (var cat in pom) {
          for (i = 0; i < listOfCategories.length; i++) {
            if (listOfCategories[i].id == cat.id) {
              ChangeDataState.categoryListCB.add(MyCheckbox(cat, true));
              print("Sadrzi, ubaceno");
              break;
            }
          }
          if (i == listOfCategories.length) {
            ChangeDataState.categoryListCB.add(MyCheckbox(cat, false));
            print("Ne sadrzi, nije ubaceno");
          }
        }
        showDialog(
            context: context,
            builder: (context) => ShowCategoryDialogChangeData());
      },
    ).showPointerOnHover;
  }

  Widget _city() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 80,
              child: Text(
                'Grad',
                style: TextStyle(color: Colors.white),
              )),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 150.0,
            height: 35,
            decoration: BoxDecoration(
                color: Colors.teal[600],
                border: Border.all(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.circular(5.0)),
            child: FutureBuilder<List<City>>(
                future: APIServices.getCity(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<City>> snapshot) {
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
                    return DropdownButtonHideUnderline(
                      child: DropdownButton<City>(
                        //hint: Text(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        items: snapshot.data
                            .map((city) => DropdownMenuItem<City>(
                                  child: Text(city.name).showPointerOnHover,
                                  value: city,
                                ))
                            .toList(),
                        onChanged: (City value) {
                          setState(() {
                            cityID = value.id;
                            hintCity = value.name;
                            print("BBBBBBBBB $hintCity");
                          });
                        },
                        isExpanded: false,
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            hintCity,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ).showPointerOnHover;
                  }
                }),
          ),
        ],
      ),
    );
  }

  Widget _checkButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: IconButton(
          color: Colors.teal[800],
          iconSize: 40,
          icon: Icon(Icons.check_circle),
          onPressed: () async {
            if (listOfCategories.length == 0) {
              listOfCategories = await APIInstitutions.getCategoriesUserFollow(
                  Token.jwt, loginInstitutionID);
            }

            var newInstitution;
            String base64Image;
            var profilePhoto;
            if (_currentPassError == false &&
                controllerNewPass.text.isEmpty == false &&
                controllerNewPass.text == controllerNewPassCheck.text) {
              var shaPass1 = utf8.encode(controllerNewPass.text);
              var shaPass = sha1.convert(shaPass1);
              password = shaPass.toString();
              print("Promenjena šifra $password");

              setState(() {
                indForPassword = 0; //sifra je uspesno promenjena
              });
            }

            if (indForPassword == 0) if (name != '') {
              base64Image = base64Encode(data);
              APIServices.addImageForWeb(Token.jwt, base64Image, institution: 1)
                  .then((value) async {
                profilePhoto = jsonDecode(value);
                newInstitution = new Institution.id(
                    loginInstitutionID,
                    controllerName.text,
                    controllerUsername.text,
                    password,
                    controllerEmail.text,
                    controllerPhone.text,
                    cityID,
                    profilePhoto,
                    institution.userTypeID,
                    controllerAddress.text,
                    true);
                if ((await APIInstitutions.changeInstitution(
                        Token.jwt, newInstitution)) ==
                    true) {
                  loginInstitution = await APIInstitutions.getInstitutionByID(
                      loginInstitutionID, Token.jwt);

                  if ((await APIInstitutions.followCategories(
                          loginInstitution.username, listOfCategories)) ==
                      true) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InstitutionProfile(
                                  institution: loginInstitution,
                                )));
                  } else {
                    print('Doslo je do greske.');
                  }
                } else {
                  print('Doslo je do greske.');
                }
              });
            } else {
              profilePhoto = institution.profilePhoto;
              newInstitution = new Institution.id(
                  loginInstitutionID,
                  controllerName.text,
                  controllerUsername.text,
                  password,
                  controllerEmail.text,
                  controllerPhone.text,
                  cityID,
                  profilePhoto,
                  institution.userTypeID,
                  controllerAddress.text,
                  true);
              if ((await APIInstitutions.changeInstitution(
                      Token.jwt, newInstitution)) ==
                  true) {
                loginInstitution = await APIInstitutions.getInstitutionByID(
                    loginInstitutionID, Token.jwt);
                if ((await APIInstitutions.followCategories(
                        loginInstitution.username, listOfCategories)) ==
                    true) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InstitutionProfile(
                                institution: loginInstitution,
                              )));
                } else {
                  print('Doslo je do greske.');
                }
              } else {
                print('Doslo je do greske.');
              }
            }
          }).showPointerOnHover,
    );
  }

  _buildChild(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height / 1.2,
          width: MediaQuery.of(context).size.width > 1000
              ? MediaQuery.of(context).size.width / 1.5
              : MediaQuery.of(context).size.width / 1.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white70.withOpacity(0.95),
          ),
          child: MediaQuery.of(context).size.width < 1000
              ? SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          color: Colors.teal[800],
                          height: MediaQuery.of(context).size.height / 2.2,
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(child: _userSection())),
                      _fields(),
                      _checkButton()
                    ],
                  ),
                )
              : Row(
                  children: [
                    Container(
                        color: Colors.teal[800],
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width / 3,
                        child: _userSection()),
                    SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                iconSize: 30,
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.teal[800],
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ).showPointerOnHover,
                            ),
                            _fields(),
                            _checkButton()
                          ]),
                    )
                  ],
                )),
    );
  }

  Widget changeField(String field, int ind) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            field,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
              width: MediaQuery.of(context).size.width > 1000
                  ? MediaQuery.of(context).size.width / (ind == 1 ? 3.8 : 3.5)
                  : MediaQuery.of(context).size.width / (ind == 1 ? 2.1 : 1.8),
              height: 35,
              child: Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: Color.fromRGBO(24, 74, 69, 1),
                  cursorColor: Color.fromRGBO(24, 74, 69, 1),
                ),
                child: TextField(
                    onSubmitted: (String value) {
                      if (value != "") {
                        if (ind == 6) //current password textfield
                        {
                          indForPassword = 1;
                          var pass1 = utf8.encode(value);
                          var pass2 = sha1.convert(pass1);
                          if (pass2.toString() !=
                              institution.password.toString()) {
                            print('Trenutna lozinka nije tacna.');

                            setState(() {
                              _currentPassError = true;
                            });

                            controllerNewPass.text = "";
                            controllerNewPassCheck.text = "";
                          } else {
                            print('Trenutna lozinka je tacna.');

                            setState(() {
                              _currentPassError = false;
                            });
                          }
                        } else if (ind == 7) //newPassword textfiled
                        {
                          if (UserData.isPass(controllerNewPass.text) ==
                              false) {
                            print(
                                'Lozinka mora imati najmanje 8 karaktera, jedno slovo i jedan broj.');
                            //mora ovo lepse da se kaze

                            setState(() {
                              _correctPass = false;
                            });
                          } else {
                            setState(() {
                              _correctPass = true;
                            });
                          }
                        } else if (ind == 8) //newPass again
                        {
                          if (controllerNewPass.text !=
                              controllerNewPassCheck.text) {
                            print('Lozinke se ne poklapaju');
                            setState(() {
                              _doesMatch = false;
                            });
                          } else {
                            print('Lozinke se poklapaju');
                            setState(() {
                              _doesMatch = true;
                            });
                          }
                        }
                      } else {
                        setState(() {
                          _currentPassError = false;
                          _doesMatch = true;
                          _correctPass = true;
                          indForPassword = 0;
                        });
                      }
                    },
                    style: TextStyle(
                        color: ind == 1 ? Colors.white : Colors.black),
                    obscureText: ind == 6
                        ? (_isVisibleCurrent == true ? false : true)
                        : (ind == 7
                            ? (_isVisibleNew == true ? false : true)
                            : (ind == 8
                                ? (_isVisibleCheckNew == true ? false : true)
                                : false)),
                    enableInteractiveSelection: true,
                    controller: ind == 1 //name
                        ? controllerName
                        : (ind == 2 //Email
                            ? controllerEmail
                            : (ind == 3 //Address
                                ? controllerAddress
                                : (ind == 4 //Phone
                                    ? controllerPhone
                                    : (ind == 5 //Username
                                        ? controllerUsername
                                        : (ind == 6 //Current password
                                            ? controllerCurrentPass
                                            : (ind == 7 //New password
                                                ? controllerNewPass
                                                : (ind == 8 //Check new password
                                                    ? controllerNewPassCheck
                                                    : controller))))))),
                    decoration: InputDecoration(
                      suffixIcon: ind == 6
                          ? (_isVisibleCurrent == true
                              ? visibilityOn(ind)
                              : visibilityOff(ind))
                          : (ind == 7
                              ? (_isVisibleNew == true
                                  ? visibilityOn(ind)
                                  : visibilityOff(ind))
                              : (ind == 8
                                  ? (_isVisibleCheckNew == true
                                      ? visibilityOn(ind)
                                      : visibilityOff(ind))
                                  : null)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ind == 1
                              ? Colors.white
                              : Color.fromRGBO(24, 74, 69, 1),
                          width: 2.5,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    )).showPointerOnHover,
              ))
        ],
      ),
    );
  }

  Widget visibilityOn(int ind) {
    return IconButton(
        icon: Icon(Icons.visibility),
        onPressed: () {
          setState(() {
            ind == 6
                ? _isVisibleCurrent = false
                : ind == 7 ? _isVisibleNew = false : _isVisibleCheckNew = false;
          });
        });
  }

  Widget visibilityOff(int ind) {
    return IconButton(
      icon: Icon(Icons.visibility_off),
      onPressed: () {
        setState(() {
          ind == 6
              ? _isVisibleCurrent = true
              : ind == 7 ? _isVisibleNew = true : _isVisibleCheckNew = true;
        });
      },
    );
  }

  pickImage() {
    final html.InputElement input = html.document.createElement('input');
    input
      ..type = 'file'
      ..accept = 'image/*';

    input.onChange.listen((e) {
      if (input.files.isEmpty) return;
      final reader = html.FileReader();
      reader.readAsDataUrl(input.files[0]);
      reader.onError.listen((err) => setState(() {
            error = err.toString();
          }));
      reader.onLoad.first.then((res) {
        final encoded = reader.result as String;
        final stripped =
            encoded.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');

        setState(() {
          name = input.files[0].name;
          data = base64.decode(stripped);
          error = null;
        });
      });
    });

    input.click();
  }
}
