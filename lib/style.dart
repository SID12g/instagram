import 'package:flutter/material.dart';

var theme = ThemeData(
  bottomNavigationBarTheme:
      BottomNavigationBarThemeData(selectedItemColor: Colors.black),
  iconTheme: IconThemeData(color: Colors.blue),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(backgroundColor: Colors.grey)),
  appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 1, //그림자
      actionsIconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.black)),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Colors.black),
  ),
);
