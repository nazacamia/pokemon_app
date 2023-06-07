import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_app/logic/pokemon_list_controller.dart';
import 'package:pokemon_app/model/pokemon.dart';
import 'package:pokemon_app/presentation/screens/preferred_screen.dart';
import 'package:pokemon_app/presentation/widgets/pokemon_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 1;
  int offset = 0;
  @override
  void initState() {
    super.initState();
    PokemonListController.to.fetchPokemon(_pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.red,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PreferredScreen()));
              },
              icon: const Icon(CupertinoIcons.heart_fill, color: Colors.black,))
        ],
        title: Text(widget.title),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
      body: Obx(() {
        if (PokemonListController.to.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
              itemCount: PokemonListController.to.pokemonList.length,
              itemBuilder: (context, index) {
                return PokemonTile(
                  pokemon: PokemonListController.to.pokemonList[index],
                  index: index + offset + 1,
                );
              });
        }
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              heroTag: 'btn1',
              onPressed: (_pageIndex <= 1)
                  ? null
                  : () {
                      setState(() {
                        _pageIndex--;
                        offset = offset - 50;
                      });
                      PokemonListController.to.fetchPokemon(_pageIndex);
                    },
              child: const Icon(Icons.arrow_back_ios_sharp),
            ),
            FloatingActionButton(
              heroTag: 'btn2',
              onPressed: () {
                setState(() {
                  _pageIndex++;
                  offset = offset + 50;
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