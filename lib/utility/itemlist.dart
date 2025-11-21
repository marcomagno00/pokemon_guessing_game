import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_guessing_v2/components/Provider/statusmodel.dart';
import 'package:pokemon_guessing_v2/utility/constants.dart';

import 'package:provider/provider.dart';

class ItemCardPokemon extends StatelessWidget {
  const ItemCardPokemon({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final int id = index + 1;

    return Consumer<Status>(
      builder: (context, value, child) {
        // variables of the card
        final List<int> guessed = value.guessed;
        final bool idIsGuessed = guessed.contains(id);
        final Color firstColor = pokemonTypeColors[
                (mapOfAllPokemon[index]["type"]! as List).first as String] ??
            Colors.grey;
        final Color lastColor = pokemonTypeColors[
                (mapOfAllPokemon[index]["type"]! as List).last as String] ??
            Colors.grey;
        final Widget sprite = idIsGuessed
            ? Image.asset("assets/pokemonSprites/$id.png")
            : (value.isEasyMode
                ? (Image.asset("assets/pokemonSprites/$id.png",
                    color: Colors.black))
                : Container());

        final Image pokeball = idIsGuessed
            ? Image.asset("assets/images/pokeballcolored.png")
            : Image.asset("assets/images/pokeballempty.png",
                color: const Color.fromARGB(100, 0, 0, 0));
        final String name = (mapOfAllPokemon[index]["name"]! as Map)["english"]
            .toString()
            .toUpperCase();

        if (idIsGuessed) {
          // GUESSED
          return Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [firstColor, lastColor]),
                  borderRadius: BorderRadiusDirectional.circular(10)),
              child: Center(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: pokeball,
                    ),
                    Text(
                      id.toString().padLeft(3, '0'),
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: sprite,
                    ),
                    Text(name,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15))
                  ],
                ),
              ),
            ),
          );
        } else {
          // NOT GUESSED YET
          return Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadiusDirectional.circular(10)),
              child: Center(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/images/pokeballempty.png",
                          height: 20, color: Colors.white),
                    ),
                    Text(
                      id.toString().padLeft(3, '0'),
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: sprite,
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
