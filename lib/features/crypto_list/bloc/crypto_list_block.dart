import 'dart:async';

import 'package:crypto_app_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'crypto_list_event.dart';
part 'crypto_list_state.dart';

class CryptoListBlock extends Bloc<CryptoListEvent, CryptoListState> {
  CryptoListBlock(this.coinsRepository) : super(CryptoListStateInitial()) {
    on<LoadCryptoList>((event, emit) async {
      try {
        // TODO: implement event handler
        if(state is! CryptoListStateLoaded) {
          emit(CryptoListStateLoading());
        }
        
        final coinsList = await coinsRepository.getCoinsList();
        emit(CryptoListStateLoaded(coinsList: coinsList));
      }catch (e) {
        emit(CryptoListStateFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }


  final AbstractCoinsRepository coinsRepository;
}