import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

//const String pasta = 'num_pasta';
//const String arquivo = 'num_arquivo';

class AppModeloDatabase {
  final DatabaseReference _databaseref =
      FirebaseDatabase.instance.ref('app_modelo');

  Future<void> _saveNumero(String child, int numeroPasta) async {
    await _databaseref.update({
      child: numeroPasta,
    });
  }

  Future<int> _getNumero(String child) async {
    DatabaseEvent event = await _databaseref.child(child).once();
    DataSnapshot snapshot = event.snapshot;
    String value = snapshot.value!.toString();
    int valorPasta = int.tryParse(value)!;
    return valorPasta;
  }

  Future<int> incrementNumero(child) async {
    int numDaPasta = await _getNumero(child);
    debugPrint(numDaPasta.toString());
    numDaPasta++;
    await _saveNumero(child, numDaPasta);
    return numDaPasta;
  }
}
