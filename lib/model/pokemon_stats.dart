class PokemonStats {
  late final int hp;
  late final int attack;
  late final int defense;
  late final int specialAttack;
  late final int specialDefense;
  late final int speed;
  late final List<dynamic> abilities;
  late final List<dynamic> types;

  PokemonStats(
      {required this.hp,
      required this.attack,
      required this.defense,
      required this.specialAttack,
      required this.specialDefense,
      required this.speed,
      required this.abilities});

  PokemonStats.fromJson(Map json)
      : hp = json['hp'],
        attack = json['attack'],
        defense = json['defense'],
        specialAttack = json['special-attack'],
        specialDefense = json['special-defense'],
        speed = json['speed'],
        types = json['types'],
        abilities = json['abilities'];
  @override
  String toString() {
    return 'hp: $hp, attack: $attack, abilities: $abilities';
  }
}
