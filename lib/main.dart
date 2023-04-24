import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:pokemon_flutter/models/pokemon.dart';
import 'package:pokemon_flutter/screens/pokemon_detail.dart';
import 'package:pokemon_flutter/screens/pokemon_home.dart';
import 'package:pokemon_flutter/services/pokemon_api_service.dart';
import 'package:pokemon_flutter/services/pokemon_db.dart';

void main() async {
  // Инициализируем базу данных
  WidgetsFlutterBinding.ensureInitialized();
  // Загружаем данные из API

  // Проверка статуса подключения к интернету
  final connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    // нет подключения к интернету
  } else {
    // есть подключение к интернету
    final apiData = await fetchPokemonList();
    // Сохраняем данные в базу данных
    for (final pokemon in apiData) {
      await DatabaseHelper.insertPokemon(pokemon);
    }
  }
  // Запускаем приложение

  runApp(PokemonApp());
}

class PokemonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokémon App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => PokemonHomePage(),
        '/pokemon-details': (context) => PokemonDetailScreen(
            pokemon: ModalRoute.of(context)?.settings.arguments as Pokemon),
      },
    );
  }
}
