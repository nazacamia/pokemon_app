class Pokemon {
  late final String name;
  late final String url;

  Pokemon({required this.name, required this.url});

  @override
  String toString(){
    return '$name, $url';
  }
}