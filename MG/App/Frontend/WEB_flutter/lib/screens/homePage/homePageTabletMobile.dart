import 'package:flutter/material.dart';
import 'package:WEB_flutter/screens/homePage/navigatinBar.dart';
import 'package:WEB_flutter/screens/homePage/bodyOfPage/pagBodyTablet.dart';

void main() => runApp(new HomePageTabletMobile());

class HomePageTabletMobile extends StatelessWidget {
  //provide the same scrollController for list and draggableScrollbar
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: <Widget>[
              NavigationBar(),
              SizedBox(height: 20,),
              PageBodyTablet()
            ],
          ),
        ),
      ),
    );
  }
}