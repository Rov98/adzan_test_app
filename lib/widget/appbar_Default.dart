import '../constant/constant.dart';
import '../theme/app_theme.dart';
import 'package:flutter/material.dart';

AppBar Appbar_default() {
  return AppBar(
    title: Text(AppName, style: Apptheme().dataTheme.textTheme.bodyLarge,),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
