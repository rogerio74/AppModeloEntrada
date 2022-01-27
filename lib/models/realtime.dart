import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

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

  Future<int> incrementNumero(String child, int numero) async {
    int ultimoNumero = await _getNumero(child);

    if (child == 'num_pasta') {
      ultimoNumero++;
    } else {
      ultimoNumero += numero;
    }
    await _saveNumero(child, ultimoNumero);
    return ultimoNumero;
  }

  Future<void> sendNewUserData(
    String email,
    String nome,
    String idade,
    String sexo,
    String numPasta,
    int numArquivos,
  ) async {
    Map userData = {
      'email': email,
      'nome': nome,
      'idade': idade,
      'sexo': sexo,
      'numPasta': numPasta,
      'numArquivos': numArquivos,
    };
    await _databaseref.child('voluntarios').push().set(userData);
  }

  Future<String?> isUsedEmail(String? email) async {
    DatabaseEvent? event = await _databaseref.child('voluntarios').once();
    DataSnapshot snapshot = event.snapshot;
    if (email == null || snapshot.exists == false) {
      return null;
    } else {
      Map data = snapshot.value as Map;
      List emails = [];
      List keys = [];
      data.forEach((key, value) {
        keys.add(key);
        emails.add(value['email']);
      });

      if (emails.contains(email)) {
        int indexKey = emails.indexOf(email);
        String key = keys[indexKey];
        return key;
      } else {
        return null;
      }
    }
  }

  Future<Map> getUserWithId(String id) async {
    DatabaseEvent event =
        await _databaseref.child('voluntarios').child(id).once();
    DataSnapshot snapshot = event.snapshot;
    Map data = snapshot.value as Map;

    return data;
  }

  Future<void> updateUserData(String id, Map<String, dynamic> newData) async {
    await _databaseref.child('voluntarios').child(id).update(newData);
  }
}

final AppModeloDatabase database = AppModeloDatabase();
