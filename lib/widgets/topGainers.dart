import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../backend/cryptoData.dart';
import '../backend/marketHelper.dart';
import '../theme/themeHelper.dart';
import 'cryptoTile.dart';

class TopGainersPage extends StatefulWidget {
  const TopGainersPage({super.key});

  @override
  State<TopGainersPage> createState() => _TopGainersPageState();
}

class _TopGainersPageState extends State<TopGainersPage> {
  @override
  Widget build(BuildContext context) {
    ThemeHelper themeHelper = Provider.of<ThemeHelper>(context, listen: true);
    return Consumer<MarketHelper>(builder: (context, marketInstance, child) {
      List<CryptoData> topGainersList = marketInstance.markets.toList()
        ..sort((a, b) =>
            b.priceChangePercentage24h!.compareTo(a.priceChangePercentage24h!));
      if (topGainersList.isNotEmpty) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: topGainersList.length,
          itemBuilder: ((context, index) {
            CryptoData favCrypto = topGainersList[index];
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
    });
  }
}
