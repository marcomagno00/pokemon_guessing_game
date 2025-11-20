import 'package:flutter/material.dart';
import 'package:pokemon_guessing_v2/utility/constants.dart';
import 'package:pokemon_guessing_v2/utility/itemList.dart';

class DexPage extends StatefulWidget {
  const DexPage({super.key});

  @override
  State<DexPage> createState() => _DexPageState();
}

class _DexPageState extends State<DexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "P O K E D E X",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 8,
              crossAxisCount: 1,
            ),
            itemCount: 721,
            itemBuilder: (context, index) {
              return ItemCardPokemon(index: index);
            },
          ),
        ));
  }
}
