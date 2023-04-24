import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokemon_flutter/models/pokemon.dart';

Future<List<Pokemon>> fetchPokemonList() async {
  final response =
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon'));

  if (response.statusCode == 200) {
    final jsonBody = jsonDecode(response.body);
    final pokemonList = <Pokemon>[];

    for (final pokemonJson in jsonBody['results']) {
      final pokemonUrl = pokemonJson['url'];
      final pokemonResponse = await http.get(Uri.parse(pokemonUrl));

      if (pokemonResponse.statusCode == 200) {
        final pokemonJsonBody = jsonDecode(pokemonResponse.body);
        final pokemon = Pokemon.fromJson(pokemonJsonBody);
        pokemonList.add(pokemon);
      } else {
        throw Exception(
            'Failed to fetch pokemon detail: ${pokemonJson['name']}');
      }
    }

    return pokemonList;
  } else {
    throw Exception('Failed to fetch pokemon list');
  }
}
