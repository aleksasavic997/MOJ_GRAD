import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mojgradapp/functions/local_notification_helper.dart';
import 'package:mojgradapp/functions/themes.dart';
import 'package:mojgradapp/screens/buildBodyUnread.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:mojgradapp/models/userData.dart';
import 'package:mojgradapp/screens/filterPage.dart';
import 'package:mojgradapp/screens/homePage.dart';
import 'package:mojgradapp/screens/notificationPage.dart';
import 'package:mojgradapp/screens/posts/newPostPage.dart';
import 'package:mojgradapp/screens/profilePage.dart';
import 'package:mojgradapp/screens/posts/viewPostPage.dart';
import 'package:mojgradapp/services/APIUsers.dart';
//import 'package:mojgradapp/services/APIServices.dart';
import 'package:mojgradapp/services/token.dart';
import 'package:mojgradapp/screens/posts/changePost.dart';
import 'package:provider/provider.dart';
import 'package:signalr_client/hub_connection.dart';
import 'package:signalr_client/hub_connection_builder.dart';
import 'config/config.dart';
import 'models/modelsViews/notificationInfo.dart';
import 'models/modelsViews/userInfo.dart';
import 'screens/institutePage.dart';
import 'screens/loginPage.dart';
import 'screens/signupPage.dart';
import 'functions/allActiveChallengeMap.dart';

void main() => runApp(MyApp());

int loginUserID;
UserInfo loginUser;
int idUserFilter =
    0; //za flitriranje, 0 za sve korisnike, u suprotnom id korisnika

HubConnection hubConnection;
bool connectionIsOpen = false;

Future<void> openNotificationConnection() async {
  if (hubConnection == null) {
    hubConnection = HubConnectionBuilder().withUrl(notificationLiveURL).build();
    hubConnection.onclose((error) => connectionIsOpen = false);
    hubConnection.on("OnNotification", handleIncommingNotification);
  }

  if (hubConnection.state != HubConnectionState.Connected) {
    await hubConnection.start();
    connectionIsOpen = true;
  }
}

void handleIncommingNotification(List<Object> args) {
  BuildBodyUnread.notificationList = List<NotificationInfo>();
  print('ARGSSSSSSSS');
  print(args[0]);
  for (var notification in args[0]) {
    BuildBodyUnread.notificationList
        .add(NotificationInfo.fromObject(notification));
    // print('alalalallalalalalalal');
    // print(notification);
  }

   var not = BuildBodyUnread.notificationList;

  print('LOCAL PUSH NOTIFICATION');
  for (var notification in not) {
    print(notification.content);
  }
 

  if(not.length != 0)
  showOngoingNotification(_MaterialAppThemeState.notifications,
      title: 'Moj grad - novo obaveštenje', body: not[0].content);
}

Future<void> sendNotification(int id) async {
  await openNotificationConnection();
  hubConnection.invoke("Send", args: <Object>[id]);
}

class MyApp extends StatelessWidget {
  static int ind =
      0; //za switch tamna tema, ako se ukljuci tamna tema da switch ostane ukljucen i posle menjanja prozora

  @override
  Widget build(BuildContext context) {
    openNotificationConnection();
    return ChangeNotifierProvider<ThemeChanger>(
        create: (_) => ThemeChanger(basicThameLight()),
        child: MaterialAppTheme());
  }

  static basicThameLight() {
    TextTheme _basicTextTheme(TextTheme base) {
      return base.copyWith(
        title: base.title.copyWith(
          //appBar
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          color: Colors.white,
        ),
      );
    }

    final ThemeData base = ThemeData.light();
    return base.copyWith(
      textTheme: _basicTextTheme(base.textTheme),
      primaryColor: Colors.teal[900],
      //indicatorColor: Colors.green,
      //scaffoldBackgroundColor: Colors.red,
      accentColor: Colors.black,
     // canvasColor: Colors.red,
      unselectedWidgetColor: Colors.brown[300],
      iconTheme: IconThemeData(
        color: Colors.teal[800],
        size: 25.0,
      ),
      buttonTheme: ButtonThemeData(),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.brown[600],
      ),
      buttonColor: Colors.red,
      backgroundColor: Colors.amber[50],
    );
  }

  static basicThameDark() {
    TextTheme _basicTextTheme(TextTheme base) {
      return base.copyWith(
        title: base.title.copyWith(
          //appBar
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          color: Colors.white,
        ),
      );
    }

    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      textTheme: _basicTextTheme(base.textTheme),
      primaryColor: Colors.blueGrey[900],
      //canvasColor: Colors.blueGrey[900],
      unselectedWidgetColor: Colors.blueGrey[800],
      //indicatorColor: Colors.green,
      //scaffoldBackgroundColor: Colors.red,
    //  dialogTheme: DialogTheme(
    //    backgroundColor: Colors.grey
    //  ),
    //  dialogBackgroundColor: Colors.grey,
      accentColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 25.0,
      ),
      buttonTheme: ButtonThemeData(),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.blueGrey[900],
      ),
      buttonColor: Colors.red,
      backgroundColor: Colors.grey[900],
    );
  }
}

class MaterialAppTheme extends StatefulWidget {
  const MaterialAppTheme({
    Key key,
  }) : super(key: key);

  @override
  _MaterialAppThemeState createState() => _MaterialAppThemeState();
}

class _MaterialAppThemeState extends State<MaterialAppTheme> {
  static var notifications = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    final settingsAndroid = AndroidInitializationSettings('logoapp');

    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    var not = BuildBodyUnread.notificationList;
    var postID = not[0].postId;
    var userID = not[0].userId;
    if(not[0].type == 7 || not[0].type == 8){
      ProfilePage.user = await APIUsers.getUserInfoById(userID, Token.jwt);
       Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()));
    }
    else
    {
        ViewPost.postId = postID;
         Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ViewPost()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      /* theme: ThemeData(
      primaryColor: Colors.teal[50], // backGroundColor
      accentColor: Colors.teal[100],  // bar-ovi
      //canvasColor: Colors.red,
      // textTheme: TextTheme(body1: TextStyle(color: Colors.white)),
    ),*/
      // theme: snapshot.data
      //     ? BasicThameDark() /*ThemeData.dark()*/ : BasicThameLight(),
      theme: theme.getTheme(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (BuildContext context) => new HomePage.fromBase64(Token.jwt),
        '/notification': (BuildContext context) => new NotificationPage(),
        '/filter': (BuildContext context) => new FilterPage(),
        '/profile': (BuildContext context) => new ProfilePage(),
        '/newPost': (BuildContext context) => new NewPost(),
        '/viewPost': (BuildContext context) => new ViewPost(),
        '/signup': (BuildContext context) => new SignupPage(),
        '/changePost': (BuildContext context) => new ChangePost(),
        '/mapPage': (BuildContext context) => new MapPageAll(),
        '/institutePage': (BuildContext context) => new InstitutePage(),
        '/loginPage' : (BuildContext context) => new LoginPage(),
      },
      home:
          FutureBuilder(
      future: Token.jwtOrEmpty,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        if (snapshot.data != "") {
          var str = snapshot.data;
          var jwt = str.split(".");

          if (jwt.length != 3) {
            return LoginPage();
          } else {
            var payload = json.decode(
                ascii.decode(base64.decode(base64.normalize(jwt[1]))));
            if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
                .isAfter(DateTime.now())) {
              return HomePage(str, payload);
            } else {
              return LoginPage();
            }
          }
        } else {
          return LoginPage();
        }
      }),
          //LoginPage(),
    );
  }
}

class Bloc {
  final _themeController = StreamController<bool>();
  get changeTheme => _themeController.sink.add;
  get darkThemeEnabled => _themeController.stream;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

final bloc = Bloc();
