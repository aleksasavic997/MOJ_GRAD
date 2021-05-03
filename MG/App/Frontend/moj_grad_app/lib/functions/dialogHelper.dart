import 'package:flutter/material.dart';
import 'package:mojgradapp/functions/solutionDialog.dart';

class DialogHelper {
  static solve(context) => showDialog(context: context, builder: (context) => SolutionDialog());
}