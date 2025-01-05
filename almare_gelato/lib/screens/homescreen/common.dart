import 'package:flutter/material.dart';

class Common {
  static TableBorder border() {
    return TableBorder(
        verticalInside: const BorderSide(style: BorderStyle.solid, width: 2),
        borderRadius: BorderRadius.circular(10));
  }

  static TableRow row(String left, String right) {
    return TableRow(children: [
      Center(
        child: Text(left,
            style:
                const TextStyle(fontSize: 20, decoration: TextDecoration.none)),
      ),
      Center(
        child: Text(right,
            style:
                const TextStyle(fontSize: 20, decoration: TextDecoration.none)),
      )
    ]);
  }
}
