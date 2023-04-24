// отвечает за отрисовку карточки элемента на главной странице
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_flutter/models/pokemon.dart';
import 'package:pokemon_flutter/widgets/pokemon_types.dart';

class PokemonCardWidget extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCardWidget({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              const Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
              BlendMode.srcATop,
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('#${pokemon.id}'),
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: pokemon.imageUrl,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              pokemon.name.toUpperCase(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                shadows: [
                  Shadow(
                    blurRadius: 5,
                    color: Colors.grey,
                    offset: Offset(1, 2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Wrap(
                  spacing: 8.0,
                  children: pokemon.types
                      .map((type) => PokemonTypesWidget(type: type))
                      .toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
