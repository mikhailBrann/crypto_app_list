import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  // дефолтные параметры для виджетов
  scaffoldBackgroundColor: const Color.fromARGB(255, 31, 31, 31),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
  dividerColor: Colors.white24,
  appBarTheme: AppBarTheme(
    backgroundColor: const Color.fromARGB(255, 31, 31, 31),
    elevation: 0,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 21,
      fontWeight: FontWeight.w700,
    ),
    centerTitle: true
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: Colors.white
  ),
  textTheme: TextTheme(
    bodyMedium: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    labelSmall: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 14,
    )
  )
);