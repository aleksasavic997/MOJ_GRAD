import 'package:WEB_flutter/screens/showPost/usersThatReacted.dart';
import 'package:flutter/material.dart';

class ToUsersThatReacted {
  static solve(context) =>
      showDialog(context: context, builder: (context) => UsersThatReacted());
}
