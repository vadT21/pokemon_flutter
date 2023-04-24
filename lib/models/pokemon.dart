class Pokemon {
  final String name;
  final int id;
  final String imageUrl;
  final int weight;
  final int height;
  final List<dynamic> types;
  final List<dynamic> stats;

  Pokemon(
      {required this.name,
      required this.id,
      required this.imageUrl,
      required this.weight,
      required this.height,
      required this.types,
      required this.stats});

  // Фабричный метод, который позволяет создавать объект типа Pokemon
  //на основе данных, представленных в формате JSON.
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final types = json['types']
        .map<String>((type) => type['type']['name'].toString())
        .toList();
    final stats = json['stats']
        .map<String>((type) => type['base_stat'].toString())
        .toList();

    return Pokemon(
      name: json['name'],
      id: json['id'],
      imageUrl: json['sprites']['front_default'],
      weight: json['weight'],
      height: json['height'],
      types: types,
      stats: stats,
    );
  }
}
