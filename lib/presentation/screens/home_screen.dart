
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_app/logic/pokemon_list_controller.dart';
import 'package:pokemon_app/model/pokemon.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;
  List<dynamic> rawPokemonList = [];
  List<Pokemon> pokemonList = [];

  @override
  void initState() {
    super.initState();
    PokemonListController.to.fetchPokemon(_pageIndex);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(widget.title),
      ),
      body: Center(
        child: Obx(
            (){
              if (PokemonListController.to.isLoading.value){
                return CircularProgressIndicator();
              }
              else {
                print('notloading');
                print(pokemonList);
          return ListView.builder(
              itemCount: PokemonListController.to.pokemonList.length,
              itemBuilder: (context, index) {
                return MaterialButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Image.network(PokemonListController.to.pokemonList[index].url),
                      Text(PokemonListController.to.pokemonList[index].name),
                    ],
                  ),
                );
              });
        }
      }
        )
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(onPressed: () {  },),
          FloatingActionButton(onPressed: () {  },),
        ],
      ),
    );
  }
}