import 'package:flutter/material.dart';
import 'package:pokemon_guessing_v2/utility/functions.dart';

class Status extends ChangeNotifier {
  List<int> _guessedList = giveAllGuessedPokemon();
  List<int> get guessed => _guessedList;
  bool _isEasyMode = false;

  //final int _numberOfGuessed = giveAllGuessedPokemon().length;
  //int get numberOfGuessed => _numberOfGuessed;

  Map<int, int> _guessedPerGen = giveGuessedPerGen();
  Map<int, int> get guessedPerGen => _guessedPerGen;
  bool get isEasyMode => _isEasyMode;

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
      _guessedPerGen = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0};
    } else {
      deleteGuessedPokemon(gen: gen);
      _guessedList = giveAllGuessedPokemon();
      _guessedPerGen[gen] = 0;
    }
    notifyListeners();
  }

  void changeMode() {
    if (isEasyMode) {
      _isEasyMode = false;
    } else {
      _isEasyMode = true;
    }
    notifyListeners();
  }
}
