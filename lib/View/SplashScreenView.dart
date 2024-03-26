import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_news_app/View/HeadlinesView.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset('images/applogo.png'), // Use const for better performance
      nextScreen: const HeadlinesView(),
      splashIconSize: 230,
      backgroundColor: const Color.fromARGB(255, 61, 61, 61),
      splashTransition: SplashTransition.fadeTransition,
      duration: 3000, // Adjust duration as needed
    );
  }
}
