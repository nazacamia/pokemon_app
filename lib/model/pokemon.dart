import 'package:flutter/material.dart';

class Pokemon {
  late final String name;
  late final String url;
  late final Color color;
  Pokemon({required this.name, required this.url, required this.color});

  @override
  String toString(){
    return '$name, $url';
  }
}