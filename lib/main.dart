import 'package:flutter/material.dart';
import 'package:flutter_news_app/View/HeadlinesView.dart';
import 'package:flutter_news_app/View/SplashScreenView.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      routes: {
        'SplashScreen': (context) => const SplashScreenView(),
        'Home': (context) => const HeadlinesView(),
      },
      debugShowCheckedModeBanner: false,
      home: const SplashScreenView(),
    );
  }
}
