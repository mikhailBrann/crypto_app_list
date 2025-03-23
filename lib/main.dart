import 'package:crypto_app_list/crypto_coins_list_app.dart';
import 'package:crypto_app_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


void main() {
  // регистратор объектов глобальной видимости
  // регистрируем через синглтон для того что бы на все приложение отрабатывал только один экземпляр объекта
  // lazySinglton - будет создан только при первом обращении к нему
  GetIt.I.registerLazySingleton<AbstractCoinsRepository>(() => CryptoCoinsRepository(dio: Dio()));

  runApp(const CryptoCoinsListApp());
}

