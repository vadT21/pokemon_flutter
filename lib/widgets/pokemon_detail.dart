// отвечает за отрисовку детальной информации
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_flutter/models/pokemon.dart';
import 'package:pokemon_flutter/widgets/pokemon_anthropometry.dart';
import 'package:pokemon_flutter/widgets/pokemon_slider.dart';
import 'package:pokemon_flutter/widgets/pokemon_types.dart';

class PokemonDetailWidget extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailWidget({Key? key, required this.pokemon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#${pokemon.id}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      pokemon.name.toUpperCase(),
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      spacing: 8.0,
                      children: pokemon.types
                          .map(
                            (type) => PokemonTypesWidget(type: type),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    PokemonSliderWidget(
                        title: 'hp',
                        color: Colors.green,
                        stats: pokemon.stats[0]),
                    const SizedBox(height: 10),
                    PokemonSliderWidget(
                        title: 'attack',
                        color: Colors.red,
                        stats: pokemon.stats[1]),
                    const SizedBox(height: 10),
                    PokemonSliderWidget(
                        title: 'defense',
                        color: Colors.yellow,
                        stats: pokemon.stats[2]),
                    const SizedBox(height: 10),
                    PokemonSliderWidget(
                        title: 'speed',
                        color: Colors.orange,
                        stats: pokemon.stats[5]),
                  ],
                ),
              ),
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: pokemon.imageUrl,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        PokemonAnthropometryWidget(
                            title: 'weight', value: '${pokemon.weight} g'),
                        const SizedBox(height: 8),
                        PokemonAnthropometryWidget(
                            title: 'height', value: '${pokemon.height} cm'),
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
