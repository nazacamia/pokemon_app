
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_app/logic/pokemon_list_controller.dart';
import 'package:pokemon_app/model/pokemon.dart';
import 'package:palette_generator/palette_generator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 1;
  List<dynamic> rawPokemonList = [];
  List<Pokemon> pokemonList = [];
  int offset= 0;
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
                return const CircularProgressIndicator();
              }
              else {
                print('notloading');
                print(pokemonList);
          return ListView.builder(
              itemCount: PokemonListController.to.pokemonList.length,
              itemBuilder: (context, index) {
                return PokemonTile(pokemon: PokemonListController.to.pokemonList[index], index: index + offset + 1,);
              });
        }
      }
        )
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              onPressed:  (_pageIndex<=1)? null: () {
                setState(() {
                  _pageIndex--;
                  offset=offset-50;
                });
                PokemonListController.to.fetchPokemon(_pageIndex);
                },
              child: const Icon(Icons.arrow_back_ios_sharp),
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _pageIndex++;
                  offset=offset+50;
                });
                PokemonListController.to.fetchPokemon(_pageIndex);
              },
              child: const Icon(Icons.arrow_forward_ios_sharp),

            ),
          ],
        ),
      ),
    );
  }
}

class PokemonTile extends StatefulWidget {
  const PokemonTile({Key? key, required this.pokemon, required this.index}) : super(key: key);
  final Pokemon pokemon;
  final int index;
  @override
  State<PokemonTile> createState() => _PokemonTileState();
}

class _PokemonTileState extends State<PokemonTile> {
  late final Color color = widget.pokemon.color;
  @override
  void initState()  {
    super.initState();
    //getCardColour();
  }



  @override
  Widget build(BuildContext context) {
    if (widget.pokemon.name == 'ledian' || widget.pokemon.name=='spinarak'|| widget.pokemon.name=='ariados') {
      print('widget.pokemon.color');
      print(widget.pokemon.color);
      //0xff181818
    }
    if (widget.pokemon.color == Color(0xff181818)) {
      print('nero');
    }

    return Card(
      color: color == Color(0xff181818) || color == Color(0xff101010)? Colors.blueGrey:color,
      child: MaterialButton(
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        onPressed: () {},
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle
                  ),
                ),
                Container(
                  height: 8,
                  width: 100,
                  color: widget.pokemon.color,
                ),
                Image.network(widget.pokemon.url)
              ],
            ),
            const SizedBox(height: 10,),
            Text('#${widget.index} ', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            Text(widget.pokemon.name[0].toUpperCase() + widget.pokemon.name.substring(1), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
      ),
    );
  }


}
