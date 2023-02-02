import 'package:my_crypto_app/screens/splashScreen.dart';
import './backend/data.dart';
import 'package:flutter/material.dart';
import 'package:my_crypto_app/backend/marketHelper.dart';
import 'package:my_crypto_app/theme/themeData.dart';
import 'package:my_crypto_app/theme/themeHelper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String initialTheme = await savedData.getTheme();
  runApp(MyApp(
    theme: initialTheme,
  ));
}

class MyApp extends StatelessWidget {
  final String theme;

  const MyApp({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MarketHelper>(
          create: (context) => MarketHelper(),
        ),
        ChangeNotifierProvider<ThemeHelper>(
          create: (context) => ThemeHelper(theme),
        ),
      ],
      child: Consumer<ThemeHelper>(builder: (contex, themeHelper, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeHelper.themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: const SplashPage(),
        );
      }),
    );
  }
}
