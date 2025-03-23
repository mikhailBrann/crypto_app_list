
import 'package:crypto_app_list/router/router.dart';
import 'package:crypto_app_list/theme/theme.dart';
import 'package:flutter/material.dart';

class CryptoCoinsListApp extends StatelessWidget {
  const CryptoCoinsListApp({super.key});

  @override
  Widget build(BuildContext context) {
    // тут выставляем основной шаблон для приложения
    // чаше всего используется MaterialApp, но в зависимости от задач используется и WidgetsApp
    return MaterialApp(
      title: 'CryptoCurrenciesList',
      theme: darkTheme,
      // Роут основной страницы приложения
      routes: routes,
    );
  }
}