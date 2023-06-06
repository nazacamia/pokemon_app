import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:palette_generator/palette_generator.dart';
import 'dart:convert';

import 'package:pokemon_app/model/pokemon.dart';

class PokemonListController extends GetxController {
  Rx<int> pageIndex=0.obs;
  RxList<dynamic> pokemonList= [].obs;
  RxBool isLoading = false.obs;

  static PokemonListController get to => Get.find<PokemonListController>();
  Future<Color> getImagePalette (ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator = await PaletteGenerator
        .fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor!.color;
  }
  getColor(url) async {
    return await getImagePalette(NetworkImage(url));
  }
  fetchPokemon(int pageIndex) async {
    isLoading.value = true;
    pokemonList = [].obs;
    int offset = (pageIndex-1)*50;
    String api = 'https://pokeapi.co/api/v2/pokemon?limit=50&offset=${offset.toString()}';
    print(api);
    http.Response request = await http.get(Uri.parse(api));
    Map body = json.decode(request.body);
    int tmpIndex = pageIndex==1? 1 : (pageIndex-1) * 50 + 1;
    print('tmpIndex');
    print(tmpIndex);
    for (Map element in body['results']) {
      String url = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${tmpIndex.toString()}.png';
      Map body = json.decode(request.body);
      Color color = await getColor(url);
      Pokemon pokemon = Pokemon(name: element['name'], url: url, color: color);
      tmpIndex++;
      pokemonList.add(pokemon);
    }
    isLoading.value = false;
  }
}