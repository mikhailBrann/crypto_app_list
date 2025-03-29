import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_coin_details.g.dart';

//анотация для сериализации
@JsonSerializable()
class CryptoCoinDetail extends Equatable {
  CryptoCoinDetail({
    this.priceInUSD = 0.0, // Значение по умолчанию
    this.imageUrl = '',    // Значение по умолчанию
    this.toSymbol = '',     // Значение по умолчанию
    DateTime? lastUpdate,   // Используем DateTime? для возможности null
    this.hight24Hour = 0.0, // Значение по умолчанию
    this.low24Hours = 0.0,   // Значение по умолчанию
  }) : lastUpdate = lastUpdate ?? DateTime.now(); // Если lastUpdate не передан, используем текущее время
  @JsonKey(name: 'TOSYMBOL')
  final String toSymbol;
  
  @JsonKey(name: 'lASTUPDATE', toJson: _dateTimeToJson, fromJson: _dateTimeFromJson)
  final DateTime lastUpdate;
  
  @JsonKey(name: 'HIGH24HOUR')
  final double hight24Hour;
  
  @JsonKey(name: 'LOW24HOUR')
  final double low24Hours;
  
  @JsonKey(name: 'PRICE')
  final double priceInUSD;
  
  @JsonKey(name: 'IMAGEURL')
  final String imageUrl;
  factory CryptoCoinDetail.fromJson(Map<String, dynamic> json) => _$CryptoCoinDetailFromJson(json);
  
  Map<String, dynamic> toJson() => _$CryptoCoinDetailToJson(this);
  
  static int _dateTimeToJson(DateTime time) => time.millisecondsSinceEpoch;
  
  static DateTime _dateTimeFromJson(int time) => DateTime.fromMillisecondsSinceEpoch(time);
  
  @override
  List<Object> get props => [
    toSymbol,
    lastUpdate,
    hight24Hour,
    low24Hours,
    priceInUSD,
    imageUrl,
  ];
}