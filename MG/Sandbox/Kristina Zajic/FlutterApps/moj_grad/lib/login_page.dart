//import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:mojgrad/main.dart';
import 'package:mojgrad/Models/Korisnik.dart' as user;

class LoginPage extends StatefulWidget
{
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
{
  TextEditingController _email = new TextEditingController();
  TextEditingController _pass = new TextEditingController();

  String get email => _email.text;
  String get password => _pass.text;

  bool _remember= false;

  @override
  Widget build(BuildContext context)
  {
    return Container(
      child: ListView(
        children: <Widget>[
          headerSection(),
          textSection(),
          buttonSection(),
          footerSection(),
        ],
      ),
    );
  }

  Container headerSection()
  {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
      margin: EdgeInsets.only(top: 30.0),
      child: Text("Cars", style: TextStyle(color: Colors.white,fontSize: 38.0),
          textAlign: TextAlign.center),
    );
  }

  Widget _forgotButton()
  {
    return Container(
        alignment: Alignment.centerRight,
        child: FlatButton(
          onPressed: () => print('Forgot Password Button Pressed'),
          padding: EdgeInsets.only(right: 0.0),
          child: Text('Forgot Password?'),
        )
    );
  }

  Widget _rememberButton()
  {
    return Container(
      margin: EdgeInsets.only(top: 0.0),
        child:Row(
          children: <Widget>[
            Theme(
                data: ThemeData(unselectedWidgetColor: Colors.white),
                child: Checkbox(
                  value: _remember,
                  checkColor: Colors.green,
                  activeColor: Colors.black45,
                  onChanged:(value){
                    setState(() {
                      _remember=value;
                    });
                  },
                )
            ),
            Text('Remember me'),
          ],
        )
    );
  }
  Container textSection()
  {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(top: 40.0),
      child: Column(
        children: <Widget>[
          //IconButton(icon: new Icon(Icons.brightness_2),onPressed: (){_darkTheme();}),
          new TextField(
              controller: _email,
              decoration: InputDecoration(
                  hintText: 'Enter a email',
                  icon: new Icon(Icons.email)
              )
          ),
          SizedBox(height: 30.0),
          new TextField(
              controller: _pass,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Enter a password',
                  icon: new Icon(Icons.lock)
              )
          ),
          _forgotButton(),
          _rememberButton(),
        ],
      ),
    );
  }

  Container buttonSection()
  {
    return Container(
      margin: EdgeInsets.only(top: 40.0,left: 115.0,right: 115.0),
      //width: 70.0 ,
      height: 55.0,
      padding: EdgeInsets.symmetric(horizontal: 0.0),
      child: RaisedButton(
          child: Text("Sign In",style: TextStyle(fontSize: 18.0),),
          onPressed: () async{
            var rez = await user.Korisnik.checkUser(email, password);
            
            
            if(rez == "true")
            //if(email=="kzajic@gmail.com" && password=="katarina")
              Navigator.of(context).pushNamed('/homeScreen');
            else
              print('Doslo je do greske!!!');
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          )
      ),
    );
  }

  Container footerSection()
  {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 62.0),
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Text("Don't have an account?"),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/signup');
            },
            padding: EdgeInsets.only(right: 0.0),
            child: Text('Sign up'),
          )
        ],
      ),
    );
  }
}


/*
class LoginPage extends StatelessWidget {
   LoginPage({
    Key key,
    @required this.onSubmit
  }) : super(key: key);

  final VoidCallback onSubmit; //pozvacemo onSubmit u nekom drugom delu
  static final TextEditingController _email = new TextEditingController();
  static final TextEditingController _pass = new TextEditingController();

  String get email => _email.text;
  String get password => _pass.text;

  bool _remember=false;
  */
/*
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          headerSection(),
          textSection(),
          buttonSection(),
        ],
      ),
    );
  }*/
/*
  Container headerSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
      margin: EdgeInsets.only(top: 30.0),
      child: Text("Moj Grad", style: TextStyle(color: Colors.white,fontSize: 34.0),
          textAlign: TextAlign.center),
    );
  }
*/
 /* Widget _emailField(){
    return TextField(

    );
  }
  */
/*
 Widget _forgotButton() {
   return Container(
       alignment: Alignment.centerRight,
       child: FlatButton(
         onPressed: () => print('Forgot Password Button Pressed'),
         padding: EdgeInsets.only(right: 0.0),
         child: Text('Forgot Password?'),
       )
   );
 }

 Widget _rememberButton(){
   return Container(
     child:Row(
       children: <Widget>[
         Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white),
           child: Checkbox(
             value: _remember,
             checkColor: Colors.green,
             activeColor: Colors.white,
             //onChanged:( bool value){State},
           )
         ),
         Text('Remember me'),
        ],
     )
   );
 }
  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(top: 40.0),
      child: Column(
        children: <Widget>[
          //IconButton(icon: new Icon(Icons.brightness_2),onPressed: (){_darkTheme();}),
          new TextField(
              controller: _email,
              decoration: InputDecoration(
                  hintText: 'Enter a email',
                  icon: new Icon(Icons.email)
              )
          ),
          SizedBox(height: 30.0),
          new TextField(
              controller: _pass,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Enter a password',
                  icon: new Icon(Icons.lock)
              )
          ),
          _forgotButton(),
          _rememberButton(),
        ],
      ),
    );
  }

  Container buttonSection() {
    return Container(
      margin: EdgeInsets.only(top: 60.0,left: 115.0,right: 115.0),
      //width: 70.0 ,
      height: 55.0,
      padding: EdgeInsets.symmetric(horizontal: 0.0),
      child: RaisedButton(
        child: Text("Sign In",style: TextStyle(fontSize: 18.0),),
        onPressed: onSubmit,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        )
      ),
    );
  }
}*/