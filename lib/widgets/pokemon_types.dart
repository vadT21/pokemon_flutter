// отвечает за отрисовку типа элементов
import 'package:flutter/material.dart';

class PokemonTypesWidget extends StatelessWidget {
  final String type;
  const PokemonTypesWidget({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        type,
        style: const TextStyle(fontSize: 14, color: Colors.white),
      ),
    );
  }
}
