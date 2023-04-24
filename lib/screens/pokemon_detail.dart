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
      body: Padding(
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
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${pokemon.name.toUpperCase()}',
                        style: TextStyle(fontSize: 24),
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
                              (type) => Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 10.0),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '$type',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.white),
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
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Column(
                        children: [
                          Text('hp'),
                          SizedBox(height: 5),
                          Container(
                            width: 100,
                            color: Colors.green,
                            child: SliderTheme(
                              data: SliderThemeData(
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 0),
                                overlayShape:
                                    RoundSliderOverlayShape(overlayRadius: 0),
                                trackHeight: 5,
                              ),
                              child: Slider(
                                value: double.parse(pokemon.stats[1]),
                                min: 0,
                                max: 150,
                                onChanged: null,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Column(
                        children: [
                          Text('attack'),
                          SizedBox(height: 5),
                          Container(
                            color: Colors.red,
                            width: 100,
                            child: SliderTheme(
                              data: SliderThemeData(
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 0),
                                overlayShape:
                                    RoundSliderOverlayShape(overlayRadius: 0),
                                trackHeight: 5,
                              ),
                              child: Slider(
                                value: double.parse(pokemon.stats[
                                    2]), // задаем значение, которое не может быть изменено
                                min: 0,
                                max: 150,
                                onChanged:
                                    null, // указываем, что значение не может быть изменено
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Column(
                        children: [
                          Text('defense'),
                          SizedBox(height: 5),
                          Container(
                            width: 100,
                            color: Colors.yellow,
                            child: SliderTheme(
                              data: SliderThemeData(
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 0),
                                overlayShape:
                                    RoundSliderOverlayShape(overlayRadius: 0),
                                trackHeight: 5,
                              ),
                              child: Slider(
                                value: double.parse(pokemon.stats[
                                    3]), // задаем значение, которое не может быть изменено
                                min: 0,
                                max: 150,
                                onChanged:
                                    null, // указываем, что значение не может быть изменено
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Column(
                        children: [
                          Text('speed'),
                          SizedBox(height: 5),
                          Container(
                            width: 100,
                            color: Colors.orange,
                            child: SliderTheme(
                              data: SliderThemeData(
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 0),
                                overlayShape:
                                    RoundSliderOverlayShape(overlayRadius: 0),
                                trackHeight: 5,
                              ),
                              child: Slider(
                                  value: double.parse(pokemon.stats[5]),
                                  min: 0,
                                  max: 150,
                                  onChanged: null),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
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
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                'weight',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(0, 0, 0, 0.5)),
                              ),
                              SizedBox(height: 5),
                              Container(
                                width: 150,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 16.0),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 197, 197, 197),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '${pokemon.weight} kg',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Column(
                            children: [
                              Text(
                                'height',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(0, 0, 0, 0.5)),
                              ),
                              SizedBox(height: 5),
                              Container(
                                width: 150,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 16.0),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 197, 197, 197),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  '${pokemon.height} m',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
