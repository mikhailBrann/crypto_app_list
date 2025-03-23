import 'package:crypto_app_list/features/crypto_list/crypto_list.dart';
import 'package:crypto_app_list/features/crypto_coin/crypto_coin.dart';

final routes = {
  '/': (context) => const CryptoListScreen(title: 'CryptoCurrenciesList'),
  '/coin': (context) => const CryptoCoinScreen(),
};