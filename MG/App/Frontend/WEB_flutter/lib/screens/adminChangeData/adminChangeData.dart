import 'package:WEB_flutter/screens/adminChangeData/adminChangeDataPageBody.dart';
import 'package:WEB_flutter/screens/homePage/navigatinBar.dart';
import 'package:flutter/material.dart';

class AdminChangeData extends StatefulWidget {
  @override
  _AdminChangeDataState createState() => _AdminChangeDataState();
}

class _AdminChangeDataState extends State<AdminChangeData> {

  String username;
  String password;
  bool isHidden=true;
  bool isAdmin=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: SmallNavigationBar(),
            ),
            AdminChangeDataPageBody()
            //SizedBox(height: 20,),
            //isAdmin == false? confirmAdmin() :
            // ScreenTypeLayout(
            //   desktop: AdminChangeDataDesktop(),
            //   tablet: AdminChangeDataTabletMobile(),
            //   mobile: AdminChangeDataTabletMobile(),
            // ),
          ],
        ),
      ),
    );
  }
/*
  Widget confirmAdmin(){
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromRGBO(24, 74, 69, 1),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 50.0),
              buildTextField('Korisničko ime'),
              SizedBox(height: 20.0),
              buildTextField('Lozinka'),
              SizedBox(height: 20.0),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                color: Color.fromRGBO(24, 74, 69, 1),
                onPressed: () async {
                  var shaPass1 = utf8.encode(password);
                  var shaPass = sha1.convert(shaPass1);
                  var jwt = await admin.Admin.checkAdmin(
                      username, shaPass.toString());
                  if (jwt != "false") {
                    Token.setSecureStorage("jwt", jwt);
                    print(jwt);
                    var token = json.decode(ascii.decode(base64.decode(base64.normalize(jwt.split('.')[1]))));
                    loginAdmin =token['sub'];
                    print('ID ADMINA $loginAdmin');
                    Token.jwt = jwt;
                    print('ok');
                    setState(() {
                      isAdmin=!isAdmin;
                    });
                  } else
                    print(
                        'Pogresna kombinacija username - password');
                },
                child: Text(
                  'Potvrdite',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Colors.white
                  ),
                ),
              ).showPointerOnHover
            ],
          ),
        ),
      ),
    );
  }

  void toggleVisibility() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  Widget buildTextField(String hintText) {
    return Container(
      width: 300,
      child: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Color.fromRGBO(24, 74, 69, 1),
          cursorColor: Color.fromRGBO(24, 74, 69, 1),
        ),
        child: TextField(
          onChanged: (val) async {
            setState(() {
              hintText == 'Korisničko ime' ? username = val : password = val;
            });
          },
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey[800],
              fontSize: 16.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            prefixIcon: hintText == 'Korisničko ime'
                ? Icon(Icons.person)
                : Icon(Icons.lock),
            suffixIcon: hintText == 'Lozinka'
                ? IconButton(
                    onPressed: toggleVisibility,
                    icon: isHidden == true
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                  ).showPointerOnHover
                : null,
          ),
          obscureText: hintText == 'Lozinka' ? isHidden : false,
        ).showPointerOnHover,
      ),
    );
  }
*/

}