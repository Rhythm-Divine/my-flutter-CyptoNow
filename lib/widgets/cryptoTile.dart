import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../backend/cryptoData.dart';
import '../backend/marketHelper.dart';
import '../screens/CryptoPage.dart';

class CryptoTile extends StatelessWidget {
  const CryptoTile({super.key, required this.crypto});

  final CryptoData crypto;

  @override
  Widget build(BuildContext context) {
    MarketHelper marketInstance =
        Provider.of<MarketHelper>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CryptoPage(
                id: crypto.id!,
              ),
            ),
          );
        },
        contentPadding: const EdgeInsets.all(2),
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(crypto.image!),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
                child: Text(
              crypto.name!,
              style: const TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.3),
              overflow: TextOverflow.ellipsis,
            )),
            const SizedBox(width: 15),
            (crypto.isFavorites == false)
                ? GestureDetector(
                    onTap: () {
                      marketInstance.addFavorite(crypto);
                    },
                    child: const Icon(
                      CupertinoIcons.heart,
                      size: 20,
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      marketInstance.deleteFavorite(crypto);
                    },
                    child: const Icon(
                      CupertinoIcons.heart_fill,
                      size: 20,
                      color: Colors.red,
                    ),
                  )
          ],
        ),
        subtitle: Text(
          crypto.symbol!.toUpperCase(),
          style: const TextStyle(
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
              fontSize: 15),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "₹ ${crypto.currentPrice!.toStringAsFixed(3)}",
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  color: Colors.blue[400],
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                  fontSize: 18),
            ),
            Builder(
              builder: ((context) {
                double changedPrice = crypto.priceChange24h!;
                double changedPricePercentage =
                    crypto.priceChangePercentage24h!;
                if (changedPrice < 0) {
                  return Text(
                    "${changedPricePercentage.toStringAsFixed(3)}% ⬇",
                    style: const TextStyle(
                        fontFamily: 'Quicksand',
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.3,
                        fontSize: 15),
                  );
                } else {
                  return Text(
                    '+${changedPricePercentage.toStringAsFixed(3)}% ⬆',
                    style: const TextStyle(
                        fontFamily: 'Quicksand',
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.3,
                        fontSize: 15),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
