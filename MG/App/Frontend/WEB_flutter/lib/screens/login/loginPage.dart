import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'loginPage_desktop.dart';
import 'loginPage_mobile.dart';
import 'loginPage_tablet.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      tablet: LoginTablet(),
      mobile: LoginMobile(),
      desktop: LoginDesktopTablet(),
    );
  }
}
