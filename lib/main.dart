import 'package:flutter/material.dart';
import 'package:pokemon_flutter/models/pokemon.dart';
import 'package:pokemon_flutter/screens/pokemon_detail.dart';
import 'package:pokemon_flutter/screens/pokemon_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(PokemonApp());
}

class PokemonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokémon App',
      theme: ThemeData(
        primarySwatch: Colors.green,
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
