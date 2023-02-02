import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:my_crypto_app/screens/homeScreen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double? screenHeight;
  double? screenWidth;
  String userName = '';

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Container(
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(screenWidth! / 41.2),
              image: const DecorationImage(
                  image: AssetImage("assets/images/bg2.gif"),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high),
            ),
          ),
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 30, 10, 30),
                  height: screenHeight! / 2,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(screenWidth! / 41.2),
                    image: const DecorationImage(
                        image: AssetImage(
                          "assets/images/bg1.gif",
                        ),
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 60,
                      width: screenWidth! / 1.1,
                      child: TextField(
                        style: const TextStyle(
                            fontFamily: 'Quicksand',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5),
                        onChanged: (value) => setState(() => userName = value),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          prefixIconColor: Colors.white,
                          hintText: 'Enter your name',
                          hintStyle: const TextStyle(
                              fontFamily: 'Quicksand', color: Colors.white70),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 3, color: Colors.blue),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 3),
                              borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                              fontFamily: 'Quicksand',
                              letterSpacing: 2,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) =>
                                HomeScreen(username: userName),
                          ),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                AnimatedTextKit(
                  animatedTexts: [
                    RotateAnimatedText(
                      'CryptoNow',
                      textStyle: const TextStyle(
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: Colors.white,
                          fontSize: 28),
                    ),
                    RotateAnimatedText(
                      'Analyze',
                      textStyle: const TextStyle(
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 2,
                          color: Colors.white,
                          fontSize: 25),
                    ),
                    RotateAnimatedText(
                      'Trade',
                      textStyle: const TextStyle(
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          letterSpacing: 2,
                          fontSize: 25),
                    ),
                  ],
                  isRepeatingAnimation: true,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
