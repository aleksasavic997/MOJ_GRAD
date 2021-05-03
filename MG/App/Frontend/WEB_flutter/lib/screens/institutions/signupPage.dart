import 'package:WEB_flutter/models/category.dart';
import 'package:WEB_flutter/screens/institutions/signupPage_mobile.dart';
import 'package:WEB_flutter/screens/institutions/signupPage_tablet.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'signupPage_desktop.dart';

class SignUpPage extends StatefulWidget {
  static var categoryList; // = new List<MyCheckbox>();
  @override
  _SignUpPageState createState() => _SignUpPageState();
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

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      tablet: SignUpTablet(),
      mobile: SignUpMobile(),
      desktop: SignUpDesktop(),
    );
  }
}
