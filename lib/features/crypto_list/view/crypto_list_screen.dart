import 'dart:async';

import 'package:crypto_app_list/features/crypto_list/bloc/crypto_list_block.dart';
import 'package:crypto_app_list/features/crypto_list/widgets/widgets.dart';
import 'package:crypto_app_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:crypto_app_list/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

// тут наследуемся от виджета, который отвечает за состояния
class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key, required this.title});
  final String title;

  // инициализируем обработчик состояний (чем то похоже на useState в react)
  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  // создаем список, в котором будут храниться данные по крипте
  List<CryptoCoin>? _cryptoCoinsList;

  final _cryptoListBloc = CryptoListBlock(GetIt.I<AbstractCoinsRepository>());

  @override
  void initState() {
    super.initState();
    // вызываем функцию, которая будет загружать данные по крипте
    _cryptoListBloc.add(LoadCryptoList());
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold - по сути это отображение экрана приложения с кучей кастомных полей
    return Scaffold(
      appBar: AppBar(
        title: const Text('CryptoCurrenciesList'),
      ),
      // тело экрана приложения
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _cryptoListBloc.add(LoadCryptoList(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<CryptoListBlock, CryptoListState>(
          bloc: _cryptoListBloc,
          builder: (context, state) {
            //если пришел ответ через state
            if (state is CryptoListStateLoaded) {
              return ListView.separated(
                padding: const EdgeInsets.only(top: 16),
                itemCount: state.coinsList.length,
                separatorBuilder: (context, i) => const Divider(),
                itemBuilder: (context, i) { 
                  final coin = state.coinsList[i];
        
                  return CryotoCoinTile(coin: coin);
                }
              );
            }
        
            // если прилетела ошибка из запроса
            if(state is CryptoListStateFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Error: request failed',
                      style: darkTheme.textTheme.bodyMedium,
                    ),
                    Text(
                      'Please, try again later',
                      style: darkTheme.textTheme.labelSmall?.copyWith(fontSize: 16),
                    ),
                    SizedBox(height: 30),
                    TextButton(
                      onPressed: () {
                        _cryptoListBloc.add(LoadCryptoList());
                      }, 
                      child: Text('Try again')
                    )
                  ]
                ),
              );
            }
        
            return const Center(child: CircularProgressIndicator());
          }
        ),
      )
    );
  }
}