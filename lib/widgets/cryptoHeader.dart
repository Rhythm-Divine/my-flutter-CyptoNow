import 'package:flutter/material.dart';
import '../backend/cryptoData.dart';

class CryptoHeader extends StatefulWidget {
  const CryptoHeader({super.key, required this.cryptoData, required this.img});
  final String img;
  final CryptoData cryptoData;

  @override
  State<CryptoHeader> createState() => _CryptoHeaderState();
}

class _CryptoHeaderState extends State<CryptoHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              height: 75,
              width: 75,
              child: Image.network(widget.img),
            ),
            Text(
              widget.cryptoData.name!,
              style: const TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 22,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              "(${widget.cryptoData.symbol!})".toUpperCase(),
              style: const TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 7, top: 10, bottom: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "₹${widget.cryptoData.currentPrice!.toStringAsFixed(2)}",
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 29,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                        color: Colors.blue[400]),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 6,
                        right: 0,
                      ),
                      child: Builder(builder: ((context) {
                        double changedPrice = widget.cryptoData.priceChange24h!;

                        if (changedPrice < 0) {
                          return const Icon(Icons.arrow_downward,
                              color: Colors.red);
                        } else {
                          return const Icon(Icons.arrow_upward,
                              color: Colors.green);
                        }
                      })),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        "₹${widget.cryptoData.priceChange24h!.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 18,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                            color: widget.cryptoData.priceChange24h! < 0
                                ? Colors.red
                                : Colors.green),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 50),
                Row(
                  children: [
                    Builder(
                      builder: ((context) {
                        double changedPrice = widget.cryptoData.priceChange24h!;
                        double changedPricePercentage =
                            widget.cryptoData.priceChangePercentage24h!;
                        if (changedPrice < 0) {
                          return Text(
                            " ${changedPricePercentage.toStringAsFixed(3)}% ⬇",
                            style: const TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 18,
                                letterSpacing: 0.5,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          );
                        } else {
                          return Text(
                            '${changedPricePercentage.toStringAsFixed(3)}% ⬆',
                            style: const TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 18,
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          );
                        }
                      }),
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
