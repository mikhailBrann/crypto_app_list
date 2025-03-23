part of 'crypto_list_block.dart';

//Equatable - позволяет сравнивать объекты между собой

abstract class CryptoListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CryptoListStateInitial extends CryptoListState {}

class CryptoListStateLoading extends CryptoListState {}

class CryptoListStateLoaded extends CryptoListState {
  CryptoListStateLoaded({
    required this.coinsList
  });

  final List<CryptoCoin> coinsList;

  @override
  List<Object?> get props => [coinsList];
}

class CryptoListStateFailure extends CryptoListState {
  CryptoListStateFailure({
    this.exception
  });

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}