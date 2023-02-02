import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_crypto_app/theme/themeHelper.dart';
import 'package:provider/provider.dart';
import '../backend/cryptoData.dart';
import '../backend/marketHelper.dart';
import 'cryptoTile.dart';

class MarketsPage extends StatefulWidget {
  const MarketsPage({super.key});

  @override
  State<MarketsPage> createState() => _MarketsPageState();
}

class _MarketsPageState extends State<MarketsPage> {
  @override
  Widget build(BuildContext context) {
    ThemeHelper themeProvider = Provider.of<ThemeHelper>(context, listen: true);
    return Consumer<MarketHelper>(builder: (context, marketInstance, child) {
      if (marketInstance.load == true) {
        return const Center(
          child: SpinKitHourGlass(
            color: Colors.blue,
          ),
        );
      } else {
        if (marketInstance.markets.isNotEmpty) {
          marketInstance.fetch = false;
          return RefreshIndicator(
            onRefresh: () => marketInstance.getData(),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: marketInstance.markets.length,
              itemBuilder: ((context, index) {
                CryptoData crypto = marketInstance.markets[index];
                return Container(
                    padding: const EdgeInsets.all(3.5),
                    child: CryptoTile(crypto: crypto));
              }),
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/server1.gif",
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    FadeAnimatedText('Unable to fetch data',
                        textStyle: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: themeProvider.themeMode == ThemeMode.light
                                ? Colors.black
                                : Colors.white)),
                    FadeAnimatedText('Servers might be busy',
                        textStyle: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: themeProvider.themeMode == ThemeMode.light
                                ? Colors.black
                                : Colors.white)),
                    FadeAnimatedText(
                      'Please try after some time...',
                      textStyle: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: themeProvider.themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      }
    });
  }
}
