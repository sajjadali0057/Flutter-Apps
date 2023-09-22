import 'package:flutter/material.dart';
ThemeData themeData  = ThemeData(
  primaryColor: Colors.deepOrange,
  scaffoldBackgroundColor: Colors.white,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black54

      ),
      borderRadius: BorderRadius.circular(6)
    ),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.red

        ),
        borderRadius: BorderRadius.circular(6)
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.black54

        ),
        borderRadius: BorderRadius.circular(6)
    ),
prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.deepOrange,
          disabledBackgroundColor: Colors.grey,
      textStyle: TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
      disabledForegroundColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6)
      )
    ),
  ),
  canvasColor: Colors.deepOrange,
  outlinedButtonTheme: OutlinedButtonThemeData(
    style:  OutlinedButton.styleFrom(
        side: BorderSide(
            color: Colors.deepOrange
            ,width: 1
        ),
      textStyle: TextStyle(color: Colors.deepOrange, fontSize: 16)
    ),
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    color: Colors.white,
    actionsIconTheme: IconThemeData(
      color: Colors.black
    )
  )
);
