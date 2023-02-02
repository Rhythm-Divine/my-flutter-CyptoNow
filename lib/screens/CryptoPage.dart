import 'package:flutter/material.dart';
import 'package:my_crypto_app/theme/themeHelper.dart';
import 'package:provider/provider.dart';
import '../backend/cryptoData.dart';
import '../backend/marketHelper.dart';
import '../widgets/cryptoHeader.dart';
import '../widgets/myContainer.dart';
import 'graphPage.dart';

class CryptoPage extends StatefulWidget {
  final String id;
  const CryptoPage({super.key, required this.id});

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  @override
  Widget build(BuildContext context) {
    ThemeHelper themeProvider = Provider.of<ThemeHelper>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Graph Window",
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer<MarketHelper>(
          builder: (context, marketInstance, child) {
            CryptoData crypto = marketInstance.getCrypto(widget.id);

            String image = crypto.image!;
            return RefreshIndicator(
              onRefresh: () {
                return marketInstance.getGraph(widget.id);
              },
              child: ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                padding: const EdgeInsets.only(left: 20),
                children: [
                  CryptoHeader(cryptoData: crypto, img: image),
                  const SizedBox(height: 20),
                  GraphDetails(id: widget.id, crypto: crypto),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: MyContainer(
                                  title: (crypto.marketCapRank!)
                                      .toInt()
                                      .toString(),
                                  text: "Market Rank",
                                  urColor: (crypto.priceChange24h! > 0)
                                      ? Colors.green
                                      : const Color.fromARGB(255, 232, 97, 87),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: MyContainer(
                                title: "₹${crypto.currentPrice!.toString()}",
                                text: "Current Price ",
                                urColor: (crypto.priceChange24h! > 0)
                                    ? Colors.green
                                    : const Color.fromARGB(255, 232, 97, 87),
                              ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: MyContainer(
                                      urColor: (crypto.priceChange24h! > 0)
                                          ? Colors.green
                                          : const Color.fromARGB(
                                              255, 232, 97, 87),
                                      title: "₹${crypto.low24h!.toString()}",
                                      text: "Low 24h")),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: MyContainer(
                                      urColor: (crypto.priceChange24h! > 0)
                                          ? Colors.green
                                          : const Color.fromARGB(
                                              255, 232, 97, 87),
                                      title: "₹${crypto.high24h!.toString()}",
                                      text: "High 24h"))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: MyContainer(
                                      urColor: (crypto.priceChange24h! > 0)
                                          ? Colors.green
                                          : const Color.fromARGB(
                                              255, 232, 97, 87),
                                      title: "₹${crypto.allTimeLow.toString()}",
                                      text: "All time Low")),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: MyContainer(
                                      urColor: (crypto.priceChange24h! > 0)
                                          ? Colors.green
                                          : const Color.fromARGB(
                                              255, 232, 97, 87),
                                      title:
                                          "₹${crypto.allTimeHigh!.toString()}",
                                      text: "All Hime High"))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  width: MediaQuery.of(context).size.width,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0)),
                                    color: (crypto.priceChange24h! > 0)
                                        ? Colors.green
                                        : const Color.fromARGB(
                                            255, 232, 97, 87),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '₹${crypto.marketCap!.toString()}',
                                          style: const TextStyle(
                                              fontFamily: 'Quicksand',
                                              letterSpacing: 0.5,
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                      const Text(
                                        "Market Cap ",
                                        style: TextStyle(
                                            fontFamily: 'Quicksand',
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  width: MediaQuery.of(context).size.width,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0)),
                                    color: (crypto.priceChange24h! > 0)
                                        ? Colors.green
                                        : const Color.fromARGB(
                                            255, 232, 97, 87),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '₹${crypto.circulatingSupply!.toString()}',
                                          style: const TextStyle(
                                              fontFamily: 'Quicksand',
                                              letterSpacing: 0.5,
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                      const Text(
                                        "Market Cap ",
                                        style: TextStyle(
                                            fontFamily: 'Quicksand',
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
