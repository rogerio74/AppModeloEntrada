import 'dart:io' as io;
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:modelo_app/components/diretorio.dart';

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

  Future<void> deleteUserFiles(String folder) async {
    debugPrint('Entrou Aqui');
    List<String> listFullPaths = [];
    ListResult listResults =
        await _firebaseStorageRef.child('folders').child(folder).listAll();
    List<Reference> listReferences = listResults.items;
    for (Reference reference in listReferences) {
      listFullPaths.add(reference.fullPath);
    }

    for (String element in listFullPaths) {
      await _firebaseStorageRef.child(element).delete();
    }
    print('Apagão Finalizado');
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
    required bool fluente,
  }) async {
    Map userData = {
      'email': email,
      'nome': nome,
      'idade': idade,
      'sexo': sexo,
      'numPasta': numPasta,
      'numArquivos': numArquivos,
      'fluente': fluente,
    };
    await _realtimeDatabaseRef.child('voluntarios').push().set(userData);
  }

  Future<String> updateUserData(
      String id, Map<String, dynamic> newData, String folderName) async {
    String newSexo = newData['sexo'];

    if (folderName[4] != newSexo) {
      await deleteUserFiles(folderName);
      String newFolderName = folderName.replaceRange(4, 5, newSexo);
      newData.update('numPasta', (value) => newFolderName);
      await _realtimeDatabaseRef.child('voluntarios').child(id).update(newData);
      return newFolderName;
    } else {
      await _realtimeDatabaseRef.child('voluntarios').child(id).update(newData);
      return folderName;
    }
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

  //Código para atualizar transcrição da vogal E

  // Future<void> updateVogalEPart1() async {
  //   ListResult data = await _firebaseStorageRef.child('folders').listAll();
  //   List<Reference> subFolders = data.prefixes;
  //   List foldersAdress = [];
  //   for (Reference subFolder in subFolders) {
  //     foldersAdress.add(subFolder.fullPath);
  //   }

  //   List<String> _selectedFiles = await _updateVogalEPart2(foldersAdress);
  //   await _updateVogalEfinal(_selectedFiles);
  // }

  // Future<List<String>> _updateVogalEPart2(List foldersAdress) async {
  //   List listFilesAdress = [];
  //   for (String fileAdress in foldersAdress) {
  //     ListResult files = await _firebaseStorageRef.child(fileAdress).listAll();
  //     List<Reference> filesReference = files.items;
  //     List filesAdressInFolder = [];
  //     for (Reference file in filesReference) {
  //       filesAdressInFolder.add(file.fullPath);
  //     }
  //     listFilesAdress.add(filesAdressInFolder);
  //   }
  //   List<String> selectedFiles = _updateVogalEPart3(listFilesAdress);
  //   return selectedFiles;
  // }

  // List<String> _updateVogalEPart3(List listFilesAdress) {
  //   List<String> selectedFiles = [];
  //   for (List list in listFilesAdress) {
  //     selectedFiles.add(list[2]);
  //   }
  //   return selectedFiles;
  // }

  // Future<void> _updateVogalEfinal(List listFilesAdress) async {
  //   String pathTranscricaoWav =
  //       await Diretorio('/GravacaoApp').getNomeDoArquivo('vogalE.txt');
  //   io.File transcricao = io.File(pathTranscricaoWav);
  //   transcricao.writeAsString('é é é');
  //   for (String fileAdress in listFilesAdress) {
  //     await _firebaseStorageRef
  //         .child(fileAdress)
  //         .putFile(File(pathTranscricaoWav));
  //   }
  // }

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
