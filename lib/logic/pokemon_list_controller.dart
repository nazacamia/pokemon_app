import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokemon_app/model/pokemon.dart';

class PokemonListController extends GetxController {
  Rx<int> pageIndex=0.obs;
  RxList<dynamic> pokemonList= [].obs;
  RxBool isLoading = false.obs;

  static PokemonListController get to => Get.find<PokemonListController>();

  fetchPokemon(int pageIndex) async {
    isLoading.value = true;
    String api = 'https://pokeapi.co/api/v2/pokemon?limit=50&offset=${pageIndex.toString()}';
    http.Response request = await http.get(Uri.parse(api));
    Map body = json.decode(request.body);
    int tmpIndex = 1 + pageIndex;
    for (Map element in body['results']) {
      String url = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${tmpIndex.toString()}.png';
      Pokemon pokemon = Pokemon(name: element['name'], url: url,);
      tmpIndex++;
      pokemonList.add(pokemon);
    }
    print(pokemonList);
    isLoading.value = false;
  }
}