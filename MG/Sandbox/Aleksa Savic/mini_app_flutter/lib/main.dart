import 'package:flutter/material.dart';
import 'UI/Festivali.dart';
import 'signup.dart';
import 'package:mini_app_flutter/Models/Posetioc.dart' as posetioc;


void main()=> runApp(new MyApp());

class MyApp extends StatelessWidget{

  
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup':(BuildContext context) => new SignupPage(),
        '/homeScreen':(BuildContext context) =>new Festivali(),
      },
      home:new LoginPage(),
      theme: new ThemeData(
        primarySwatch:Colors.blue
      )
    );
  }
}

class LoginPage extends StatefulWidget{
  @override
  State createState()=>new LoginPageState();
}

class LoginPageState extends State<LoginPage>{
  
  String username;
  String password;

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: new Text(
                
                
                'Fest World',
              
                style:TextStyle(
                  fontSize: 60.0,
                  color:Colors.red[900],
                  fontWeight: FontWeight.w900,
                  
                ),
              ),
      ),
        
        
    
      backgroundColor:Colors.black,
      body:new Stack(
        fit:StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage('Assets/festival.jpg'),
            fit:BoxFit.cover,
            
          ),
          new Column(
            children: <Widget>[
              
              SizedBox(height: 15.0),
              new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'No account?',
                    style: TextStyle(color: Colors.red[900]),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap:(){
                       Navigator.of(context).pushNamed('/signup');
                    },
                    child: Text(
                      'Create one!',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              new Form(
                child: new Theme(
                    data:new ThemeData(
                      brightness: Brightness.dark,
                      inputDecorationTheme: new InputDecorationTheme(
                        labelStyle: new TextStyle(
                          color: Colors.red[900],
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,

                          )
                      )
                    
                    ),
                    child:new Container(
                      padding: const EdgeInsets.only(top:120.0,left:30.0,right: 30.0),
                    child: new Column(
                                  
                    mainAxisAlignment: MainAxisAlignment.center,
                    
                    children: <Widget>[
                      
                      new TextField(
                          
                      cursorColor: Colors.red,
                      decoration: new InputDecoration(
                        labelText:"Username", 
                        
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:Colors.red)
                        )             
                      ),
                      keyboardType: TextInputType.text,
                    
                      onChanged:(text)
                      {
                        username=text;
                      }
                    ),
                    new TextFormField(
                      cursorColor: Colors.red,
                      decoration: new InputDecoration(
                        labelText:"Password",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:Colors.red)
                        )         
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      onChanged: (text){
                        password=text;
                      },
                    ),
                    new Padding(padding: const EdgeInsets.only(top:30.0)),
                    new MaterialButton(
                      minWidth: 200.0,
                      height: 50.0,
                      color: Colors.red[900], 
                      textColor: Colors.white,
                      child:new Text(
                        "Login"

                      ),
                      onPressed: () async{
                        var rez= await posetioc.Posetioc.proveriPosetioca(username,password);
                        if(rez=='true')
                          Navigator.of(context).pushNamed('/homeScreen');
                        else
                          print("Greska!");
                      },
                      ),
                     
                      
                    ],
                  ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}