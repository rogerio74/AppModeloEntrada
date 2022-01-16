import 'package:flutter/material.dart';

class Vogais extends ChangeNotifier {
  Map<String, bool> map;
  Vogais({
    required this.map,
  });

  void updateStatusVogal(String vogal) {
    debugPrint(map.toString());
    map.update(vogal, (value) => true);
    List vogaisLista = [];
    map.forEach((key, value) {
      vogaisLista.add(key);
    });
    int indexProximaVogal = vogaisLista.indexOf(vogal) + 1;
    String proximaVogal = vogaisLista[indexProximaVogal];
    map.update(proximaVogal, (value) => false);
    debugPrint(map.toString());
    notifyListeners();
  }
}
