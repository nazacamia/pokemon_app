import 'package:flutter/material.dart';

class TypeContainer extends StatelessWidget {
  final String txt;
  const TypeContainer({Key? key, required this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      height: 40,
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(txt, style: const TextStyle(color: Colors.white),),
      ),
    );
  }
}