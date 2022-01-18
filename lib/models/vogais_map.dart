import 'package:flutter/material.dart';

class Vogais extends ChangeNotifier {
  Map<String, Map<String, dynamic>> map;
  Vogais({
    required this.map,
  });

  void updateStatusVogal(String vogal) {
    map[vogal]!.update('lock', (value) => true);
    List vogaisLista = [];
    map.forEach((key, value) {
      vogaisLista.add(key);
    });
    int indexProximaVogal = vogaisLista.indexOf(vogal) - 1;
    String proximaVogal = vogaisLista[indexProximaVogal];
    map[proximaVogal]!.update('lock', (value) => false);
    notifyListeners();
  }

  List getVogaisList(int numero) {
    List list = [];

    map.forEach((key, value) {
      list.add([key, value['lock'], numero]);
      numero--;
    });
    List listReversed = list.reversed.toList();
    return listReversed;
  }

  String getUltimaVogal() {
    List<String> list = [];

    map.forEach((key, value) {
      list.add(key);
    });
    List listReversed = list.reversed.toList();
    return listReversed.last;
  }

  void getNewMapVogais() {
    List vogaisLista = [];
    map.forEach((key, value) {
      vogaisLista.add(key);
    });
    map[vogaisLista.last]!.update('lock', (value) => false);
    map[vogaisLista.first]!.update('lock', (value) => true);
    notifyListeners();
  }

  String convertNumero(int numero) {
    String numeroString = numero.toString();
    if (numeroString.length == 1) {
      return '000$numero';
    } else if (numeroString.length == 2) {
      return '00$numero';
    } else if (numeroString.length == 3) {
      return '0$numero';
    } else {
      return numeroString;
    }
  }
}
