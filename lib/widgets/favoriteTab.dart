import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../backend/cryptoData.dart';
import '../backend/marketHelper.dart';
import '../theme/themeHelper.dart';
import 'cryptoTile.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    ThemeHelper themeHelper = Provider.of<ThemeHelper>(context, listen: true);
    return Consumer<MarketHelper>(builder: (context, marketInstance, child) {
      List<CryptoData> favoriteList =
          marketInstance.markets.where((e) => e.isFavorites == true).toList();
      if (favoriteList.isNotEmpty) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: favoriteList.length,
          itemBuilder: ((context, index) {
            CryptoData favCrypto = favoriteList[index];
            return CryptoTile(
              crypto: favCrypto,
            );
          }),
        );
      } else {
        return Center(
          child: Column(
            children: [
              Image.asset("assets/images/heart.gif"),
              AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(
                    'No favorites added',
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
                  TypewriterAnimatedText('Make that heart red',
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
