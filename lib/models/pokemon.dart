class Pokemon {
  final String name;
  final int id;
  final String imageUrl;

  Pokemon({required this.name, required this.id, required this.imageUrl});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      id: json['id'],
      imageUrl: json['sprites']['front_default'],
    );
  }
}
