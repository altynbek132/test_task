import 'package:flutter/material.dart';

// https://stackoverflow.com/a/16348977/11807786
class ColorToSymbolConverter {
  Color getColorForSymbol(String str) {
    var hash = 0;

    // Calculate hash
    for (var code in str.runes) {
      hash = code + ((hash << 5) - hash);
    }

    // Create color string
    var colour = 'FF';
    for (var i = 0; i < 3; i++) {
      var value = (hash >> (i * 8)) & 0xff;
      colour += value.toRadixString(16).padLeft(2, '0');
    }

    return Color(int.parse(colour, radix: 16));
  }
}
