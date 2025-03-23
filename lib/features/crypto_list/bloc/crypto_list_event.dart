part of 'crypto_list_block.dart';

abstract class CryptoListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCryptoList extends CryptoListEvent {
  LoadCryptoList({
    this.completer
  });

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}
