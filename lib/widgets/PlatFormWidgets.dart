import 'dart:io';

import 'package:flutter/material.dart';

//abstract class that stores all the functions for alert dialogs..
abstract class PlatFormWidgets extends StatelessWidget {
  Widget buildCupertinoWidgets(BuildContext context);
  Widget buildMaterialWidgets(BuildContext context);
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return buildCupertinoWidgets(context);
    } else {
      return buildMaterialWidgets(context);
    }
  }
}
