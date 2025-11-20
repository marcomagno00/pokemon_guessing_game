import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon_guessing_v2/utility/constants.dart';

// ---------- HIVE FUNCTIONS (DATABASE) ---------- //

// WRITE DATA

/// Put the given id pokemon into the box in the corresponing key, using HIVE.
void putIdPokemon(int id) {
  final box = Hive.box("GuessedPokemon");
  final generation = giveGenFromId(id);
  final key = "Gen$generation";
  final raw = box.get(key);

  // If the value is a list, converts contained value into int, otherwise set the value to []
  List<int> currentList;
  if (raw is List) {
    currentList = raw.whereType<int>().toList();
  } else {
    currentList = [];
  }

  currentList.add(id);
  currentList = currentList.toSet().toList();
  box.put(key, currentList);
}

// LOAD DATA

/// Returns the int list (of the IDs) of the specified generation, using HIVE.
List<int> giveGuessedPokemon(int gen) {
  return Hive.box('GuessedPokemon')
      .get('Gen$gen', defaultValue: [])!.cast<int>();
}

/// Returns the map of the pokemon guessed - example: {1: 3, 2: 6, 3: 0, 4: 0, 5: 0. 6: 0}.
Map<int, int> giveGuessedPerGen() {
  Map<int, int> map = {};
  for (var i = 1; i <= 6; i++) {
    map[i] = giveGuessedPokemon(i).length;
  }
  return map;
}

/// Returns the int list (of the IDs) of all Pokemons, using HIVE.
List<int> giveAllGuessedPokemon() {
  List<int> allPokemon = [];
  for (var list in Hive.box("GuessedPokemon").values) {
    for (var pokemon in list) {
      allPokemon.add(pokemon);
    }
  }
  return allPokemon;
}

// DELETE DATA
/// Delete the pair Key-Value of the specified generation, if it's null the function clear the box.
void deleteGuessedPokemon({int? gen}) {
  if (gen == null) {
    Hive.box("GuessedPokemon").clear();
  } else {
    Hive.box("GuessedPokemon").delete("Gen$gen");
  }
}

// -------------- COMMON FUNCTIONS ---------------- //

// LOAD JSON ASSET (MAY BE USELESS)
Future<dynamic> loadJsonFromAssets(String filePath) async {
  final String jsonString = await rootBundle.loadString(filePath);
  return jsonDecode(jsonString);
}

// ---------- LIST AND MAP OPERATIONS ------------ //

/// Returns the String list of pokemon in specified generation.
List<String> giveListOfPokemon(int gen) {
  return mapOfAllPokemon
      .getRange(generationData[gen]!["start"] - 1, generationData[gen]!["end"])
      .map((p) => (p["name"] as Map<String, dynamic>)["english"]! as String)
      .toList();
}

/// Returns the map of pokemon in given generation - example {1: "Bulbasaur", 2: "Ivysaur", ..., 151: "Mew"}.
Map<int, String> giveMapOfPokemon(int gen) {
  return {
    for (final p in mapOfAllPokemon.getRange(
        generationData[gen]!["start"] - 1, generationData[gen]!["end"]))
      p['id'] as int: (p['name'] as Map<String, dynamic>)['english'] as String
  };
}

/// Returns the number of the pokemon in given generation.
int giveNumberOfPokemon(int gen) {
  return (generationData[gen]!["end"]) - (generationData[gen]!["start"]) + 1;
}

/// Returns the number of generation from specified id.
int giveGenFromId(int id) {
  if (id <= generationData[1]!["end"]) {
    return 1;
  } else if (id <= generationData[2]!["end"]) {
    return 2;
  } else if (id <= generationData[3]!["end"]) {
    return 3;
  } else if (id <= generationData[4]!["end"]) {
    return 4;
  } else if (id <= generationData[5]!["end"]) {
    return 5;
  } else {
    return 6;
  }
}

/// Returns the id of the given pokemon (no case sensitive!).
int giveIdFromPokemon(String name, Map<int, String> mapOfPokemon) {
  return mapOfPokemon.keys
      .firstWhere((k) => mapOfPokemon[k]!.toLowerCase() == name.toLowerCase());
}

/// Returns true if the given list contains the given string (no case sensitive!).
bool isContained(List<String> list, String value) {
  if (value.trim().isEmpty) return false;
  for (var pokemon in list) {
    if (pokemon.toLowerCase() == value.trim().toLowerCase()) {
      return true;
    }
  }
  return false;
}
