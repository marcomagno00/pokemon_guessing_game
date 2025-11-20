import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_guessing_v2/utility/constants.dart';
import 'package:pokemon_guessing_v2/utility/functions.dart';
import 'package:pokemon_guessing_v2/components/Provider/statusmodel.dart';

class GuessingPage extends StatefulWidget {
  GuessingPage({super.key, required this.gen}) {
    numberOfPokemon = giveNumberOfPokemon(gen);
    offsetPokemon = generationData[gen]!['start'];
    listOfPokemon = giveListOfPokemon(gen);
    mapOfPokemon = giveMapOfPokemon(gen);
  }

  final int gen;
  late final int numberOfPokemon;
  late final int offsetPokemon;
  late final Map<int, String> mapOfPokemon;
  late final List<String> listOfPokemon;

  @override
  State<GuessingPage> createState() => _GuessingPageState();
}

class _GuessingPageState extends State<GuessingPage> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  late bool togglePercentage;
  late List<int> guessedIdPokemon;

  @override
  void initState() {
    super.initState();
    guessedIdPokemon = giveGuessedPokemon(widget.gen);
    togglePercentage = false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Status>(
        builder: (context, value, child) => Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                backgroundColor: blue,
                title: Text(
                  "G E N E R A T I O N    ${widget.gen}",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: "Write here a Pokémon",
                          ),
                          controller: _textController,
                          autocorrect: false,
                          focusNode: _focusNode,
                          onSubmitted: (possibleName) {
                            if (possibleName.toLowerCase().trim() ==
                                "nidoran") {
                              // nidoran female
                              Provider.of<Status>(context, listen: false).addId(
                                  giveIdFromPokemon(
                                      "Nidoran♀", widget.mapOfPokemon));
                              _textController.clear();

                              guessedIdPokemon = giveGuessedPokemon(widget.gen);
                              _textController.clear();
                              // nidoran male
                              Provider.of<Status>(context, listen: false).addId(
                                  giveIdFromPokemon(
                                      "Nidoran♂", widget.mapOfPokemon));
                              _textController.clear();

                              guessedIdPokemon = giveGuessedPokemon(widget.gen);
                              _textController.clear();
                            } else if (isContained(
                                widget.listOfPokemon, possibleName)) {
                              Provider.of<Status>(context, listen: false).addId(
                                  giveIdFromPokemon(
                                      possibleName, widget.mapOfPokemon));
                              _textController.clear();

                              guessedIdPokemon = giveGuessedPokemon(widget.gen);
                              _textController.clear();
                            } else {
                              _textController.clear();
                            }

                            setState(() {
                              _focusNode.requestFocus();
                            });
                          },
                        ),
                      )),
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: MaterialButton(
                          onPressed: () {
                            if (togglePercentage) {
                              togglePercentage = false;
                            } else {
                              togglePercentage = true;
                            }
                            setState(() {});
                          },
                          child: Text(
                            !togglePercentage
                                ? "${value.guessedPerGen[widget.gen]} / ${widget.numberOfPokemon}"
                                : "${(value.guessedPerGen[widget.gen]! / widget.numberOfPokemon * 100).floor()} %",
                            style: const TextStyle(color: blue),
                          ),
                        ),
                      )
                    ]),
                    Expanded(
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.numberOfPokemon,
                        itemBuilder: (BuildContext context, int index) {
                          var id = widget.offsetPokemon + index;
                          return guessedIdPokemon.contains(id)
                              ? Padding(
                                  padding: const EdgeInsets.all(1),
                                  child: Image.asset(
                                    "assets/pokemonSprites/$id.png",
                                  ))
                              : Padding(
                                  padding: const EdgeInsets.all(1),
                                  child: Image.asset(
                                      "assets/images/emptypokeball.png",
                                      color:
                                          const Color.fromARGB(100, 0, 0, 0)),
                                );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
