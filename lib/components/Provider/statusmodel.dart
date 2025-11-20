import 'package:flutter/material.dart';
import 'package:pokemon_guessing_v2/utility/functions.dart';

class Status extends ChangeNotifier {
  List<int> _guessedList = giveAllGuessedPokemon();
  List<int> get guessed => _guessedList;

  //final int _numberOfGuessed = giveAllGuessedPokemon().length;
  //int get numberOfGuessed => _numberOfGuessed;

  Map<int, int> _guessedPerGen = giveGuessedPerGen();
  Map<int, int> get guessedPerGen => _guessedPerGen;

  /// It adds the given id into the box on HIVE, update the status and notify
  void addId(int id) {
    putIdPokemon(id);
    _guessedList = giveAllGuessedPokemon();
    _guessedList.sort();
    _guessedPerGen = giveGuessedPerGen();
    notifyListeners();
  }

  /// It clears the box on HIVE of the given gen or it clears the entire box if missing.
  void clearIds({int? gen}) {
    if (gen == null) {
      deleteGuessedPokemon();
      _guessedList = [];
      _guessedPerGen = {};
    } else {
      deleteGuessedPokemon(gen: gen);
      _guessedList = giveAllGuessedPokemon();
      _guessedPerGen[gen] = 0;
    }
    notifyListeners();
  }
}
