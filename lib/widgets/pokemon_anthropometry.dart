// отвечает за отрисовку антропометрических параметров
import 'package:flutter/material.dart';

class PokemonAnthropometryWidget extends StatelessWidget {
  final String title;
  final String value;
  const PokemonAnthropometryWidget(
      {Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(0, 0, 0, 0.5)),
        ),
        const SizedBox(height: 5),
        Container(
          width: 150,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 197, 197, 197),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
