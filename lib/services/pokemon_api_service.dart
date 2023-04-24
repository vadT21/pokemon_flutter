import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokemon_flutter/models/pokemon.dart';

Future<List<Pokemon>> fetchPokemonList(int offset) async {
  //лимит на количество элемнтов за один запрос к API
  const int limit = 10;
  // ссылка на API
  final String url =
      'https://pokeapi.co/api/v2/pokemon?limit=$limit&offset=${offset * 10}';

  //запрос к API, offset указывает с какого элемента делать запрос
  final response = await http.get(Uri.parse(url));

  // делаем запрос к API при успешном ответе обращаемся дальше к детальной
  // инофрмации и записываем ее в List
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
