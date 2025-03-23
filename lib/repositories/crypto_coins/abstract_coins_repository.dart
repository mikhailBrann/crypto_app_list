import 'package:crypto_app_list/repositories/crypto_coins/models/models.dart';

abstract interface class AbstractCoinsRepository {
  Future<List<CryptoCoin>> getCoinsList();
  Future<CryptoCoinDetail> getCoinDetails(String currencyCode);
}