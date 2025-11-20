import 'package:flutter/material.dart';
import 'package:pokemon_guessing_v2/components/persistent_nav_bar.dart';
import 'package:pokemon_guessing_v2/utility/constants.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: blue)),
      home: const PersistentTabScreen(),
    );
  }
}
