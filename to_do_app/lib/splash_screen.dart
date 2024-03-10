import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:gap/gap.dart';
import 'package:to_do_app/ticktick.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void changeScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => TickTickScreen()));
  }
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 2600), changeScreen);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF070A0F),
                Color.fromARGB(255, 14, 47, 47),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Dhyana',
                      textStyle: const TextStyle(
                        fontSize: 65,
                        fontFamily: 'Pacifico-Regular',
                        color: Colors.white70,
                      ),
                      speed: const Duration(milliseconds: 150),
                    ),
                  ],
                  totalRepeatCount: 1,
                  pause: const Duration(milliseconds: 1000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
                const Gap(8),
                const Center(
                    child: Text(
                  "Let's Note Down Everything",
                  style:
                      TextStyle(fontFamily: 'Pacifico-Regular', color: Colors.white70,fontSize: 18),
                )),
              ],
            ),
          )),
    );
  }
}
