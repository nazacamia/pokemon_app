import 'package:flutter/material.dart';
import 'package:pokemon_app/logic/api_provider.dart';
import 'package:pokemon_app/model/pokemon.dart';
import 'package:pokemon_app/model/pokemon_stats.dart';
import 'package:pokemon_app/presentation/widgets/stats_row.dart';
import 'package:pokemon_app/presentation/widgets/type_container.dart';

class PokemonScreen extends StatefulWidget {
  final Pokemon pokemon;
  const PokemonScreen({Key? key, required this.pokemon}) : super(key: key);

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {

  ApiProvider apiProvider = ApiProvider();
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,

            alignment: Alignment.center,
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  color: widget.pokemon.color,
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))
                ),
              ),
              Positioned(
                top:20,
                left: 0,
                child: IconButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios_sharp)),
              ),
              Positioned(
                bottom: -20,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration:  BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                    image: DecorationImage(
                        image: NetworkImage(widget.pokemon.url),
                      scale: 0.8
                    )
                  ),
                ),
              ),
              Text(widget.pokemon.name[0].toUpperCase() + widget.pokemon.name.substring(1), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.white),),
            ],
          ),
          const SizedBox(height: 30,),
          FutureBuilder(
              future: apiProvider.fetchPokemonStats(widget.pokemon.name),
              builder: (context, snap){
                if (!snap.hasData) {
                  return const Center(child: CircularProgressIndicator(),);
                } else {
                  PokemonStats? stats = snap.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          for (var stat in stats!.abilities)
                            TypeContainer(txt: stat),
                        ],
                      ),
                      const SizedBox(height: 25,),
                      StatsRow(stats: stats!.hp, color: widget.pokemon.color, nameStats: 'hp',),
                      StatsRow(stats: stats!.attack, color: widget.pokemon.color, nameStats: 'attack',),
                      StatsRow(stats: stats!.defense, color: widget.pokemon.color, nameStats: 'defense',),
                      StatsRow(stats: stats!.speed, color: widget.pokemon.color, nameStats: 'speed',),
                      StatsRow(stats: stats!.specialAttack, color: widget.pokemon.color, nameStats: 'special-attack',),
                      StatsRow(stats: stats!.specialDefense, color: widget.pokemon.color, nameStats: 'special-defense',),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          for (var stat in stats!.types)
                            TypeContainer(txt: stat),
                        ],
                      ),
                    ],

                  );
                }
          }),
        ],
      ),
    );
  }
}



