import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon_guessing_v2/app.dart';
import 'package:pokemon_guessing_v2/components/Provider/statusmodel.dart';
import 'package:provider/provider.dart';

void main() async {
// Ensure Flutter bindings are initialized before calling platform plugins
  WidgetsFlutterBinding.ensureInitialized();
  // init Hive (Hive.initFlutter uses platform channels under the hood)
  await Hive.initFlutter();
  // Open boxes before running the app so they're ready when widgets need them
  await Hive.openBox('GuessedPokemon');

  runApp(ChangeNotifierProvider(
    create: (context) => Status(),
    child: const MainApp(),
  ));
}
