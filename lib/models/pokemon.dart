class Pokemon {
  final String name;
  final int id;
  final String imageUrl;
  final int weight;
  final int height;

  Pokemon(
      {required this.name,
      required this.id,
      required this.imageUrl,
      required this.weight,
      required this.height});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      id: json['id'],
      imageUrl: json['sprites']['front_default'],
      weight: json['weight'],
      height: json['height'],
    );
  }
}
