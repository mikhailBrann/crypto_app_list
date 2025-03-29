// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_coin_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoCoinDetail _$CryptoCoinDetailFromJson(Map<String, dynamic> json) =>
    CryptoCoinDetail(
      priceInUSD: (json['PRICE'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['IMAGEURL'] as String? ?? '',
      toSymbol: json['TOSYMBOL'] as String? ?? '',
      lastUpdate: CryptoCoinDetail._dateTimeFromJson(
          (json['lASTUPDATE'] as num).toInt()),
      hight24Hour: (json['HIGH24HOUR'] as num?)?.toDouble() ?? 0.0,
      low24Hours: (json['LOW24HOUR'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$CryptoCoinDetailToJson(CryptoCoinDetail instance) =>
    <String, dynamic>{
      'TOSYMBOL': instance.toSymbol,
      'lASTUPDATE': CryptoCoinDetail._dateTimeToJson(instance.lastUpdate),
      'HIGH24HOUR': instance.hight24Hour,
      'LOW24HOUR': instance.low24Hours,
      'PRICE': instance.priceInUSD,
      'IMAGEURL': instance.imageUrl,
    };
