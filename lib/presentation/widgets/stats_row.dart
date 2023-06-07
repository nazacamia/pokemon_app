import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatsRow extends StatelessWidget {
  Color color;
  int stats;
  String nameStats;
  StatsRow({super.key, required this.color, required this.stats, required this.nameStats});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: context.width - 150,
              height: 10,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius:  BorderRadius.all(Radius.circular(10))),
            ),
            Container(
              width: stats.toDouble()*1.4,
              height: 10,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius:  const BorderRadius.all(Radius.circular(10))),
            ),
            Positioned(
              top: -5,
              right: -33,
              child: Text(stats.toString()),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0.0, bottom: 13),
          child: Text(nameStats, style: const TextStyle(fontWeight: FontWeight.bold),),
        ),
      ],
    );
  }
}

