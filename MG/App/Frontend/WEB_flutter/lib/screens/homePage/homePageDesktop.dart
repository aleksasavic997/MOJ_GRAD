import 'package:flutter/material.dart';
import 'package:WEB_flutter/screens/homePage/bodyOfPage/pageBodyDesktop.dart';
import 'package:WEB_flutter/screens/homePage/centeredView.dart';
import 'package:WEB_flutter/screens/homePage/navigatinBar.dart';

void main() => runApp(new HomePageDesktop());

class HomePageDesktop extends StatelessWidget {
  //provide the same scrollController for list and draggableScrollbar
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: CenteredView(
          child: Column(
            children: <Widget>[
              NavigationBar(),
              SizedBox(height: 20,),
              PageBodyDesktop()
            ],
          ),
        ),
      ),
    );
  }
}