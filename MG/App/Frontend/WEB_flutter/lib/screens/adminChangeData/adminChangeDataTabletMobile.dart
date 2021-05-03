import 'package:flutter/material.dart';
import 'package:WEB_flutter/hover_extensions.dart';

class AdminChangeDataTabletMobile extends StatefulWidget {
  @override
  _AdminChangeDataTabletMobileState createState() => _AdminChangeDataTabletMobileState();
}

class _AdminChangeDataTabletMobileState extends State<AdminChangeDataTabletMobile> {

  String username;
  String password;
  bool isHidden = true;
  bool usernameChange=false;
  bool passwordChange=false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: buildAdmin()
    );
  }

  Widget buildAdmin(){
    return Container(
      height: 1100,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.black12,
      ),      
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/administrator.png',
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(24, 74, 69, 1),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: changeInfo()
            ),
          )
        ],
      )
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
        data: ThemeData(
          cursorColor: Color.fromRGBO(24, 74, 69, 1),
          primaryColor: Color.fromRGBO(24, 74, 69, 1)
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

  Widget changeInfo(){
    return Container(
      margin: EdgeInsets.all(30),
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.grey[200],

      ),
      height: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Korisničko ime',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        IconButton(
                          onPressed: (){
                            setState(() {
                              usernameChange=!usernameChange;
                            });
                          },
                          icon: Icon(
                            Icons.edit,
                            size: 20,
                            color:Color.fromRGBO(24, 74, 69, 1),
                          ),
                        ).showPointerOnHover
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  usernameChange? changeUsername() : showUsername()
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Lozinka',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        IconButton(
                          onPressed: (){
                            setState(() {
                              passwordChange=!passwordChange;
                            });
                          },
                          icon: Icon(
                            Icons.edit,
                            size: 20,
                            color: Color.fromRGBO(24, 74, 69, 1),
                          )
                        ).showPointerOnHover
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  passwordChange? changePassword() : showPassword()
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          usernameChange || passwordChange ? Center(
            child: FlatButton(  
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              color: Color.fromRGBO(24, 74, 69, 1),
              onPressed: (){

              },
              child: Text(
                'Sačuvaj izmene',
                style: TextStyle(
                  color: Colors.grey[200],
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1
                ),
              ),
            ).showPointerOnHover,
          ) : Text('')
        ],
      ),
    );
  }

  Widget changeUsername(){
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black26
        ),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              'Novo korisničko ime: ', 
              style: TextStyle(
                fontSize: 16
              ),
            )
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: buildTextField('Korisničko ime')
              ),
            ],
          ),
        ],
      )
    );
  }

  Widget showUsername(){
    return Container(
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black26
        ),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              'Trenutno korisničko ime: ', 
              style: TextStyle(
                fontSize: 16
              ),
            )
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 60,
                  padding: EdgeInsets.all(19),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black45
                    )
                  ),
                  child: Text(
                    'adminUsername',
                    style: TextStyle(
                      fontSize: 16
                    ),
                  ),
                )
              ),
            ],
          ),
        ],
      )
    );
  }

  Widget changePassword(){
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black26
        ),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              'Nova lozinka: ',
              style: TextStyle(
                fontSize: 16
              ),
            )
          ),
          Row(
            children: <Widget>[
              Expanded(child: buildTextField('Lozinka')),
            ],
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              'Potvrdite novu lozinku: ',
              style: TextStyle(
                fontSize: 16
              ),
            )
          ),
          Row(
            children: <Widget>[
              Expanded(child: buildTextField('Lozinka')),
            ],
          ),
        ],
      )
    );
  }

  Widget showPassword(){
    return Container(
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black26
        ),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              'Trenutna lozinka: ', 
              style: TextStyle(
                fontSize: 16
              ),
            )
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 60,
                  padding: EdgeInsets.all(19),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black45
                    )
                  ),
                  child: Text(
                    'adminPassword',
                    style: TextStyle(
                      fontSize: 16
                    ),
                  ),
                )
              ),
            ],
          ),
        ],
      )
    );
  }

}