import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../backend/cryptoData.dart';
import '../backend/marketHelper.dart';
import '../theme/themeHelper.dart';
import 'cryptoTile.dart';

class TopLosersPage extends StatefulWidget {
  const TopLosersPage({super.key});

  @override
  State<TopLosersPage> createState() => _TopLosersPageState();
}

class _TopLosersPageState extends State<TopLosersPage> {
  @override
  Widget build(BuildContext context) {
    ThemeHelper themeHelper = Provider.of<ThemeHelper>(context, listen: true);
    return Consumer<MarketHelper>(
      builder: (context, marketInstance, child) {
        List<CryptoData> topLosersList = marketInstance.markets.toList()
          ..sort((a, b) => a.priceChangePercentage24h!
              .compareTo(b.priceChangePercentage24h!));
        if (topLosersList.isNotEmpty) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            itemCount: topLosersList.length,
            itemBuilder: ((context, index) {
              CryptoData favCrypto = topLosersList[index];
              return CryptoTile(
                crypto: favCrypto,
              );
            }),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  "assets/images/market.gif",
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText(
                      'No data found',
                      textStyle: TextStyle(
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 3,
                          color: themeHelper.themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                          fontSize: 25),
                      speed: const Duration(milliseconds: 200),
                    ),
                    TypewriterAnimatedText('Market is sleeping',
                        textStyle: TextStyle(
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 3,
                            color: themeHelper.themeMode == ThemeMode.light
                                ? Colors.black
                                : Colors.white,
                            fontSize: 25),
                        speed: const Duration(milliseconds: 150)),
                  ],
                  isRepeatingAnimation: true,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
