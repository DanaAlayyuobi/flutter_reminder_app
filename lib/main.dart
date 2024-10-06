import 'package:flutter/material.dart';
import 'package:flutter_reminder_app/widgets/expenses.dart';
var kColorScheme=ColorScheme.fromSeed(seedColor:Colors.amberAccent );
var kDarkColorScheme=ColorScheme.fromSeed(
  brightness: Brightness.dark,
    seedColor: Colors.brown);
void main() {

  runApp(
      MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
          cardTheme: const CardTheme().copyWith(
            color: kDarkColorScheme.secondaryContainer,
            margin:const EdgeInsets.symmetric(horizontal: 16 ,vertical: 8)),
          colorScheme: kDarkColorScheme,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                foregroundColor: kDarkColorScheme.onPrimaryContainer,
                backgroundColor: kDarkColorScheme.primaryContainer,
              )
          ),
        ),
        theme:ThemeData().copyWith(
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin:const EdgeInsets.symmetric(horizontal: 16 ,vertical: 8),

          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer,
            )
          ),
            textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 30,

              )
            )
        ),
        themeMode:ThemeMode.system ,
        home:const Expenses(),
  )
  );
}



