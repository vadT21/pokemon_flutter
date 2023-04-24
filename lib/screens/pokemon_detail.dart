import 'package:flutter/material.dart';
import 'package:pokemon_flutter/models/pokemon.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailScreen({Key? key, required this.pokemon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Image.network(
            pokemon.imageUrl,
            height: 200,
            width: 200,
          ),
          SizedBox(height: 16),
          Text(
            'Name: ${pokemon.name}',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 8),
          Text(
            'ID: ${pokemon.id}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
