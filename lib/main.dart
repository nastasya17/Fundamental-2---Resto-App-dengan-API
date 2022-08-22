import 'package:flutter/material.dart';
import 'package:resto_app_submission/common/style.dart';
import 'splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find My Resto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: myTextTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
      },
    );
  }
}

