import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseDao extends ChangeNotifier {
  final Reference _firebaseStorageRef = FirebaseStorage.instance.ref();

  final DatabaseReference _realtimeDatabaseRef =
      FirebaseDatabase.instance.ref('app_modelo');

  Future<void> _saveNumero(String child, int numeroPasta) async {
    await _realtimeDatabaseRef.update({
      child: numeroPasta,
    });
  }

  Future<int> _getNumero(String child) async {
    DatabaseEvent event = await _realtimeDatabaseRef.child(child).once();
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

  Future<void> sendNewUserData({
    required String email,
    required String nome,
    required String idade,
    required String sexo,
    required String numPasta,
    required int numArquivos,
    required bool apraxico,
  }) async {
    Map userData = {
      'email': email,
      'nome': nome,
      'idade': idade,
      'sexo': sexo,
      'numPasta': numPasta,
      'numArquivos': numArquivos,
      'apraxico': apraxico,
    };
    await _realtimeDatabaseRef.child('voluntarios').push().set(userData);
  }

  Future<void> updateUserData(String id, Map<String, dynamic> newData) async {
    await _realtimeDatabaseRef.child('voluntarios').child(id).update(newData);
  }

  Future<void> uploadWavAndTranscricao({
    required String folderName,
    required String fileName,
    required String audioPath,
    required String transcricaoPath,
  }) async {
    await _firebaseStorageRef
        .child('folders')
        .child(folderName)
        .child(fileName + '.wav')
        .putFile(File(audioPath));
    await _firebaseStorageRef
        .child('folders')
        .child(folderName)
        .child(fileName + '.txt')
        .putFile(File(transcricaoPath));
  }

  Future<Map> getUserWithId(String id) async {
    DatabaseEvent event =
        await _realtimeDatabaseRef.child('voluntarios').child(id).once();
    DataSnapshot snapshot = event.snapshot;
    Map data = snapshot.value as Map;

    return data;
  }

  // Future<String> getNewFolderName(String folderName, String newSexo) async {
  //   if (folderName[4] != newSexo) {
  //     await _firebaseStorageRef.child('folders').child(folderName).delete();
  //     String newFolderName = folderName.replaceRange(4, 5, newSexo);
  //     return newFolderName;
  //   } else {
  //     return folderName;
  //   }
  // } Firebase Storage não permite apagar uma pasta

  Future<String?> isUsedEmail(String? email) async {
    DatabaseEvent? event =
        await _realtimeDatabaseRef.child('voluntarios').once();
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
}
