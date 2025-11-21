import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:pokemon_guessing_v2/utility/cardgeneration.dart';
import 'package:pokemon_guessing_v2/utility/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "P O K E M O N   G U E S S I N G",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                //physics: const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return CardGeneration(gen: index + 1);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
