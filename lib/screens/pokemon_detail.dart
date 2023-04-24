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
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16),
          Text(
            'Name: ${pokemon.name}',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 8),
          Text(
            'Weight: ${pokemon.weight}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            'Height: ${pokemon.height}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            'Types: ',
            style: TextStyle(fontSize: 20),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: pokemon.types.length,
            itemBuilder: (BuildContext context, int index) {
              return Text(
                '- ${pokemon.types[index]}',
                style: TextStyle(fontSize: 16),
              );
            },
          ),
          Text(
            'Stats: ',
            style: TextStyle(fontSize: 20),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: pokemon.stats.length,
            itemBuilder: (BuildContext context, int index) {
              return Text(
                '- ${pokemon.stats[index]}',
                style: TextStyle(fontSize: 16),
              );
            },
          ),
        ],
      ),
    );
  }
}
