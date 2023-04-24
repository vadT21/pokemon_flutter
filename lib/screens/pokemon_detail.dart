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
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#${pokemon.id}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${pokemon.name}',
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ),
              // второй столбец
              Expanded(
                child: Row(
                  children: [
                    Wrap(
                      spacing: 8.0, // расстояние между элементами списка
                      children: pokemon.types
                          .map(
                            (type) => Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8.0),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                '$type',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Row(
                      children: [Text('hp'), Text('${pokemon.stats[0]}')],
                    ),
                    Row(
                      children: [Text('attack'), Text('${pokemon.stats[1]}')],
                    ),
                    Row(
                      children: [Text('defense'), Text('${pokemon.stats[2]}')],
                    ),
                    Row(
                      children: [Text('speed'), Text('${pokemon.stats[5]}')],
                    ),
                  ],
                ),
              ),
              // второй столбец
              Expanded(
                child: Image.network(
                  pokemon.imageUrl,
                  height: 196,
                  width: 196,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          // третья строка
          Row(
            children: [
              // первый столбец
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Weight: ${pokemon.weight}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Height: ${pokemon.height}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
