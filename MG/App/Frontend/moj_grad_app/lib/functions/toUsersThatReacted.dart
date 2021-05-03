import 'package:flutter/material.dart';
import 'package:mojgradapp/screens/posts/usersThatReacted.dart';

class ToUsersThatReacted {
  static solve(context) =>
      showDialog(context: context, builder: (context) => UsersThatReacted());
}
