import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

extension hoverExtensions on Widget{
  static final appContainer = html.window.document.getElementById('app-container');

  Widget get showPointerOnHover{
    return MouseRegion(
      child: this, //refers to the widget that we are currently using the extension on
      onHover: (event) => appContainer.style.cursor = 'pointer',
      onExit: (event) => appContainer.style.cursor = 'default',
    );
  }  
}