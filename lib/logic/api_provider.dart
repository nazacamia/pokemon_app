import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokemon_app/model/pokemon_stats.dart';

class ApiProvider {

  Future<Map> fetchPokemonList({required int offset}) async{
    String api = 'https://pokeapi.co/api/v2/pokemon?limit=50&offset=${offset.toString()}';
    http.Response request = await http.get(Uri.parse(api));
    Map body = json.decode(request.body);
    return body;
  }

  Future<PokemonStats> fetchPokemonStats(String pokemonName) async {
    String api = 'https://pokeapi.co/api/v2/pokemon/$pokemonName';
    http.Response request = await http.get(Uri.parse(api));
    Map body = json.decode(request.body);

    List list = body['stats'];
    Map map = {};
    for (var element in list) {
      map[element['stat']['name']]=element['base_stat'];
    }

    List rawAbilitiesList = body['abilities'];
    List abilities = [];
    for (var ability in rawAbilitiesList) {
      abilities.add(ability['ability']['name']);
    }

    List rawTypesList = body['types'];
    List types = [];
    for (var type in rawTypesList) {
      types.add(type['type']['name']);
    }

    map['abilities'] = abilities;
    map['types'] = types;
    PokemonStats pokemonStats = PokemonStats.fromJson(map);
    return pokemonStats;
  }
  const ApiProvider();
}