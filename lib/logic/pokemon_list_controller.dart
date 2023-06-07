import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_app/logic/color_getter.dart';
import 'dart:convert';

import 'package:pokemon_app/model/pokemon.dart';

class PokemonListController extends GetxController {
  RxList<dynamic> pokemonList= [].obs;
  RxList<dynamic> preferredList= [].obs;
  RxBool isLoading = false.obs;
  ColorGetter colorGetter = const ColorGetter();

  static PokemonListController get to => Get.find<PokemonListController>();

  void addOrRemoveToFavourite(Pokemon pokemon) {
    if (isPreferred(pokemon)){
      preferredList.remove(pokemon);
    } else {
      preferredList.add(pokemon);
    }
  }

  bool isPreferred(Pokemon pokemon) {
    for (Pokemon tmpPokemon in preferredList) {
      if (pokemon == tmpPokemon) {
        return true;
      }
    }
    return false;
  }


  fetchPokemon(int pageIndex) async {
    isLoading.value = true;
    pokemonList = [].obs;
    int offset = (pageIndex-1)*50;

    String api = 'https://pokeapi.co/api/v2/pokemon?limit=50&offset=${offset.toString()}';
    http.Response request = await http.get(Uri.parse(api));
    Map body = json.decode(request.body);

    int tmpIndex = pageIndex==1? 1 : (pageIndex-1) * 50 + 1;

    for (Map element in body['results']) {
      String url = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${tmpIndex.toString()}.png';
      Map body = json.decode(request.body);
      Color color = await colorGetter.getColor(url);
      Pokemon pokemon = Pokemon(name: element['name'], url: url, color: color);
      tmpIndex++;
      pokemonList.add(pokemon);
    }
    isLoading.value = false;
  }


}