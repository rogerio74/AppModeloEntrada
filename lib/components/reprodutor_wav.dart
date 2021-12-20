import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart' as connection;
import 'package:modelo_app/components/erro_internet.dart';



class ReprodutorWav {
  BuildContext context;
  String nome;
  String path;
  File informacoesPessoais;
  String vogal;
  AudioPlayer audioPlayer = AudioPlayer();

  ReprodutorWav(
      {required this.context, required this.nome, required this.path, required this.informacoesPessoais, required this.vogal});

  ouvirAudio() async {
    audioPlayer.play(path, isLocal: true);
    //io.sleep(Duration(seconds: ));
    showAlertDialog(context);
  }

  _apagarArquivo() {
    var file = File(path);
    file.delete();
  }
  
  Future<bool> checkConnection() async{
     var connectivityResult = await (connection.Connectivity().checkConnectivity());
    if (connectivityResult == connection.ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == connection.ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  showAlertDialog(BuildContext context) {
    Widget apagarButton = TextButton(
        onPressed: () {
         // _apagarArquivo();
          audioPlayer.stop();
          Navigator.of(context).pop();
        },
        child: const Text("Não", style: TextStyle(color: Colors.white, fontFamily: 'MochiyPopOne')));

    Widget salvarButton = TextButton(
        onPressed: () async {
                checkConnection().then((internet) async {
                  //print(internet);
                  if(internet){
                                     
                       var firebaseStorange = FirebaseStorage.instance
                          .ref()
                          .child('audios')
                          .child(nome)
                          .child( vogal + '.wav');

                      firebaseStorange.putFile(File(path));

                      firebaseStorange = FirebaseStorage.instance
                          .ref()
                          .child('voluntarios')
                          .child(nome + '.txt');
                      
                      firebaseStorange.putFile(informacoesPessoais);
                     
                      _apagarArquivo();

                     

                    Navigator.of(context).pop();
                    
                  }else{
                    Navigator.of(context).pop();
                    showGeneralDialog(
                    context: context,
                    barrierColor: Colors.black54,
                    pageBuilder: (_, __, ___) => const ErroConection());
                  }
                });
                
       
        },
        child: const Text("Sim", style: TextStyle(color: Colors.white, fontFamily: 'MochiyPopOne' )));

    AlertDialog alert = AlertDialog(
        content: const Text(
          "O ÁUDIO FOI GRAVADO SEM INTERFERÊNCIAS?",
          style:  TextStyle(color: Colors.white, fontFamily: 'MochiyPopOne'),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 5.0,
        actions: [
          apagarButton,
          salvarButton,
        ]);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return alert;
        });
  }


}
