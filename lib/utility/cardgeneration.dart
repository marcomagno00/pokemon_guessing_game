import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_guessing_v2/components/Provider/statusmodel.dart';

import 'package:pokemon_guessing_v2/screens/home/guessingpage.dart';
import 'package:pokemon_guessing_v2/utility/constants.dart';
import 'package:pokemon_guessing_v2/utility/functions.dart';
import 'package:provider/provider.dart';

class CardGeneration extends StatelessWidget {
  CardGeneration({super.key, required this.gen}) {
    numberOfPokemon = giveNumberOfPokemon(gen);
  }

  final int gen;
  late final int numberOfPokemon;

  @override
  Widget build(BuildContext context) {
    return Consumer<Status>(
      builder: (context, value, state) => Card(
        // Valore aggiornato dal bloc
        color: light_blue,
        borderOnForeground: false,
        child: InkWell(
          onLongPress: () {
            Provider.of<Status>(context, listen: false).clearIds(gen: gen);
          },
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GuessingPage(gen: gen),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                generationData[gen]!["region"]
                    .toString()
                    .split("")
                    .join(" ")
                    .toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                      "assets/pokemonSprites/${generationData[gen]!["starter"] + 0}.png"),
                  Image.asset(
                      "assets/pokemonSprites/${generationData[gen]!["starter"] + 3}.png"),
                  Image.asset(
                      "assets/pokemonSprites/${generationData[gen]!["starter"] + 6}.png"),
                ],
              ),
              const Spacer(),
              LinearProgressIndicator(
                value: value.guessedPerGen[gen]! / numberOfPokemon,
                backgroundColor: Colors.white24,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              Text(
                "${value.guessedPerGen[gen]} / $numberOfPokemon",
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
