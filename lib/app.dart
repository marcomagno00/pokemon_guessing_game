import 'package:flutter/material.dart';
import 'package:pokemon_guessing_v2/app_view.dart';
import 'package:pokemon_guessing_v2/components/Provider/statusmodel.dart';
import 'package:provider/provider.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // REPOSITORY PROVIDERS (BLOC and HIVE)

    return ChangeNotifierProvider(
      create: (context) => Status(),
      child: const MyAppView(),
    );
  }
}
