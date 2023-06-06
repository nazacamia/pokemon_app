import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_app/logic/pokemon_list_controller.dart';
import 'package:pokemon_app/presentation/widgets/pokemon_tile.dart';

class PreferredScreen extends StatelessWidget {
  const PreferredScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Pokedex - preferiti'),

      ),
      body: Obx(() {
        if (PokemonListController.to.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                childAspectRatio: 0.95
              ),
              itemCount: PokemonListController.to.preferredList.length,
              itemBuilder: (context, index) {
                return PokemonTile(
                  pokemon: PokemonListController.to.preferredList[index],
                  index: index + 1,
                );
              });
              
        }
      }),

    );
  }
}
