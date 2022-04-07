import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:modelo_app/database/firebase_dao.dart';

import '../models/check_connection.dart';

class DadosBD extends ChangeNotifier {
  final Reference _firebaseStorageRef = FirebaseStorage.instance.ref();
  final DatabaseReference _realtimeDatabaseRef =
      FirebaseDatabase.instance.ref('app_modelo');

  // Recebendo banco de dados

  Future<Map> getDatabaseData() async {
    DatabaseEvent event =
        await _realtimeDatabaseRef.child('voluntarios').once();
    DataSnapshot snapshot = event.snapshot;
    Map data = snapshot.value as Map;
    return data;
  }

  Future<void> getFluencia() async {
    Map voluntarios = await getDatabaseData();
    List fluencyTrue = [];
    List fluencyFalse = [];
    voluntarios.forEach((key, value) {
      if (value['fluente'] == true) {
        fluencyTrue.add(value['fluente']);
      } else if (value['fluente'] == false) {
        fluencyFalse.add(value['fluente']);
      } else {
        print('a Pasta de chave ${key} está com "fluente" nula');
      }
    });
    print('${fluencyTrue.length} São fluentes');
    print('${fluencyFalse.length} Não são fluentes');
    getSexo();
  }

  Future<void> getSexo() async {
    Map voluntarios = await getDatabaseData();

    List sexoM = [];
    List sexoF = [];
    voluntarios.forEach((key, value) {
      if (value['sexo'] == 'M') {
        sexoM.add(value['sexo']);
      } else if (value['sexo'] == 'F') {
        sexoF.add(value['sexo']);
      } else {
        print('${value['numPasta']} não tem sexo');
      }
    });
    print('${sexoM.length} São Masculinos');
    print('${sexoF.length} São Femininos');
  }

  // Verificar pastas completas e incompletas

  Future<void> getEmptyFolders() async {
    ListResult data = await _firebaseStorageRef.child('folders').listAll();
    List<Reference> subFolders = data.prefixes;
    List foldersAdress = [];
    for (Reference subFolder in subFolders) {
      foldersAdress.add(subFolder.fullPath);
    }

    await _getFiles(foldersAdress);
  }

  Future<void> _getFiles(List foldersAdress) async {
    List listFilesAdress = [];
    for (String fileAdress in foldersAdress) {
      ListResult files = await _firebaseStorageRef.child(fileAdress).listAll();
      if (files.items.length < 14) {
        listFilesAdress.add([fileAdress, files.items.length / 2]);
      }
    }
    print(listFilesAdress);
  }
}
