import 'package:flutter/material.dart';
import 'package:pokemon_app/model/pokemon.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color == const Color(0xff181818) || color == const Color(0xff101010) || color == const Color(0xff282828)? Colors.blueGrey:color,
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
