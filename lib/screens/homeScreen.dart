import 'package:flutter/material.dart';
import 'package:my_crypto_app/widgets/topGainers.dart';
import 'package:my_crypto_app/widgets/topLosersTab.dart';
import 'package:provider/provider.dart';
import '../theme/themeHelper.dart';
import '../widgets/favoriteTab.dart';
import '../widgets/marketTab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.username});
  final String username;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeHelper themeProvider = Provider.of<ThemeHelper>(context, listen: true);
    final indiColor = themeProvider.themeMode == ThemeMode.light
        ? Colors.blue[400]
        : Colors.blue[100];
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: themeProvider.themeMode == ThemeMode.light
                ? Colors.blue[400]
                : Colors.blue[100],
          ),
          height: 40,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.person,
                color: themeProvider.themeMode == ThemeMode.light
                    ? Colors.white
                    : Colors.black,
              ),
              const SizedBox(width: 10),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6),
                child: Text(
                  widget.username,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                    overflow: TextOverflow.ellipsis,
                    color: themeProvider.themeMode == ThemeMode.light
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              themeProvider.changeTheme();
            },
            padding:
                const EdgeInsets.only(left: 0, bottom: 0, right: 25, top: 5),
            iconSize: 30,
            icon: (themeProvider.themeMode == ThemeMode.light)
                ? const Icon(Icons.dark_mode)
                : const Icon(Icons.light_mode),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "CryptoNow",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                    color: themeProvider.themeMode == ThemeMode.light
                        ? Colors.blue[400]
                        : Colors.blue[100]),
              ),
              const SizedBox(height: 10),
              TabBar(
                isScrollable: true,
                indicator: CicleIndi(color: indiColor!, radius: 4),
                controller: tabController,
                labelColor: themeProvider.themeMode == ThemeMode.light
                    ? Colors.black
                    : Colors.white,
                unselectedLabelColor: Colors.grey[600],
                tabs: const [
                  Tab(
                      child: Text(
                    "Markets",
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Tab(
                    child: Text("Favorites",
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                  Tab(
                    child: Text("Top Gainers",
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                  Tab(
                    child: Text("Top Losers",
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    controller: tabController,
                    children: const [
                      MarketsPage(),
                      FavoritesPage(),
                      TopGainersPage(),
                      TopLosersPage()
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CicleIndi extends Decoration {
  final Color color;
  double radius;
  CicleIndi({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return CirclePainter(color: color, radius: radius);
  }
}

class CirclePainter extends BoxPainter {
  final double radius;
  late Color color;
  CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    late Paint paint;
    paint = Paint()..color = color;
    paint = paint..isAntiAlias = true;
    final Offset circle = offset +
        Offset(
            configuration.size!.width / 2, configuration.size!.height - radius);
    canvas.drawCircle(circle, radius, paint);
  }
}
