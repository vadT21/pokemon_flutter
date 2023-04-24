// отвечает за отрисовку статистистки в виде слайдера
import 'package:flutter/material.dart';

class PokemonSliderWidget extends StatelessWidget {
  final String title;
  final String stats;
  final Color color;
  const PokemonSliderWidget({
    Key? key,
    required this.title,
    required this.color,
    required this.stats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        const SizedBox(height: 5),
        Container(
          width: 100,
          color: color,
          child: SliderTheme(
            data: const SliderThemeData(
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
              trackHeight: 5,
            ),
            child: Slider(
              value: double.parse(stats) > 150 ? 150 : double.parse(stats),
              min: 0,
              max: 150,
              onChanged: null,
            ),
          ),
        )
      ],
    );
  }
}
