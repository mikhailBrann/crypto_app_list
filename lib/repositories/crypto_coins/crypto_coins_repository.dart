
import 'package:crypto_app_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'dart:io';
import 'package:http/http.dart' as http;

class CryptoCoinsRepository implements AbstractCoinsRepository {
  CryptoCoinsRepository({
    required this.dio
  });

  final Dio dio;

  Future<List<CryptoCoin>> getCoinsList() async {

    // void fetchData() async {
    //   try {
    //     var response = await http.get(Uri.parse('https://min-api.cryptocompare.com/data/pricemultifull&fsyms=BTC&tsyms=USD'));
    //     if (response.statusCode == 200) {
    //       debugPrint('Data fetched successfully');
    //     } else {
    //       debugPrint('Failed to load data');
    //     }
    //   } on SocketException catch (e) {
    //     debugPrint('Failed host lookup: $e');
    //   } catch (e) {
    //     debugPrint('An error occurred: $e');
    //   }
    // }

    // fetchData();

      try {
        var response = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
        if (response.statusCode == 200) {
          debugPrint('Data fetched successfully');
        } else {
          debugPrint('Failed to load data');
        }
      } on SocketException catch (e) {
        debugPrint('Failed host lookup: $e');
      } catch (e) {
        debugPrint('An error occurred: $e');
      }

      final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull',
        queryParameters: {
          'fsyms': 'BTC,ETH,BNB,SOL,AID,DOT,XRP,ADA,MATIC,LTC,TRX,AVAX,UNI,LINK,ATOM',
          'tsyms': 'USD'
        }
      );

      debugPrint('dasdsa');

      final data = response.data as Map<String, dynamic>;
      final dataRaw = data['RAW'] as Map<String, dynamic>;
      final dataList = dataRaw.entries
        .map((elem) { 
          
          final usdData = (elem.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
      
           try{
            debugPrint('Error!!!: ${usdData.toString()}');
            CryptoCoinDetail.fromJson(usdData);
           }catch(e){
             debugPrint('Error!!: ${e.toString()}');
           }
          
          final details = CryptoCoinDetail.fromJson(usdData);
          debugPrint('Error!!: ${usdData.toString()}');
          // final priceInUSD = usdData['PRICE'] as double;
          // final imageUrl = usdData['IMAGEURL'] as String;

          return CryptoCoin(
            name: elem.key, 
            details: details,
          );
        })
        .toList();
      return dataList;
  }

  Future<CryptoCoin> getCoinDetails(String currencyCode) async {
    final response = await dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currencyCode&tsyms=USD'
    );

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinData = dataRaw[currencyCode] as Map<String, dynamic>;
    final usdData = coinData['USD'] as Map<String, dynamic>;
    final details = CryptoCoinDetail.fromJson(usdData);
    // final price = usdData['PRICE'];
    // final imageUrl = usdData['IMAGEURL'];
    // final toSymbol = usdData['TOSYMBOL'];
    // final lastUpdate = usdData['LASTUPDATE'];
    // final hight24Hours = usdData['HIGH24HOUR'];
    // final low24Hours = usdData['LOW24HOUR'];

    return CryptoCoin(
      name: currencyCode,
      details: details,
    );
  }
}