import 'package:crypto_app_list/repositories/crypto_coins/models/crypto_coin_details.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// import 'package:auto_route/auto_route.dart';
import 'package:crypto_app_list/features/crypto_coin/widgets/base_card.dart';
import 'package:crypto_app_list/repositories/crypto_coins/abstract_coins_repository.dart';

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({
    super.key,
  });

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  String? coinName;
  Future<CryptoCoinDetail> fetchCryptoCoinDetail(coinName) async {
    return GetIt.I<AbstractCoinsRepository>().getCoinDetails(coinName!); // Пример данных
  }

  @override
  void didChangeDependencies() async {
    // тут мы достаем параметры из контекста роута
    final args = ModalRoute.of(context)?.settings.arguments;
    assert((args != null && args is String), 'аргумент должен быть строкой!');
    coinName = args as String;

    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency:'),
      ),
      body: FutureBuilder<CryptoCoinDetail>(
        future: fetchCryptoCoinDetail(coinName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}')); // Обработка ошибки
          }

          if(snapshot.hasData) {
            final coinDetails = snapshot.data!;
            return _CenerCoinInfo(coinDetails: coinDetails);
          }

          return Center(child: Text('Ошибка при загрузке данных'));
        }
      )
    );
  }
}


class _CenerCoinInfo extends StatelessWidget {
  const _CenerCoinInfo({
    required this.coinDetails,
  });
  final Object coinDetails;

  @override
  Widget build(BuildContext context) {
    final CryptoCoinDetail typedCoinDetails = coinDetails as CryptoCoinDetail;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 160,
            width: 160,
            child: Image.network(typedCoinDetails.imageUrl),
          ),
          const SizedBox(height: 24),
          Text(
            typedCoinDetails.name ?? '...',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          BaseCard(
            title: '',
            child: Center(
              child: Text(
                '${typedCoinDetails.priceInUSD}',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          BaseCard(
            title: '',
            child: Column(
              children: [
                _DataRow(
                  title: 'Hight 24 Hour',
                  value: '${typedCoinDetails.hight24Hour}',
                ),
                const SizedBox(height: 6),
                _DataRow(
                  title: 'Low 24 Hour',
                  value: '${typedCoinDetails.low24Hours}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _DataRow extends StatelessWidget {
  const _DataRow({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 140, child: Text(title)),
        const SizedBox(width: 32),
        Flexible(
          child: Text(value),
        ),
      ],
    );
  }
}