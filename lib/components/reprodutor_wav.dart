import 'dart:io' as io;
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity/connectivity.dart' as connection;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:modelo_app/components/diretorio.dart';
import 'package:modelo_app/components/erro_internet.dart';
import 'package:modelo_app/contador/realtime.dart';
import 'package:modelo_app/models/vogais_map.dart';
import 'package:modelo_app/screens/final_sreen.dart';
import 'package:provider/provider.dart';

class ReprodutorWav extends StatefulWidget {
  final BuildContext context;
  final String folderName;
  final String path;
  final File informacoesPessoais;
  final String vogal;
  final AudioPlayer audioPlayer = AudioPlayer();
  ReprodutorWav({
    Key? key,
    required this.context,
    required this.folderName,
    required this.path,
    required this.informacoesPessoais,
    required this.vogal,
  }) : super(key: key);

  @override
  _ReprodutorWavState createState() => _ReprodutorWavState();
}

class _ReprodutorWavState extends State<ReprodutorWav> {
  final firebaseStorage = FirebaseStorage.instance;
  bool _sending = false;

  ouvirAudio() async {
    widget.audioPlayer.play(widget.path, isLocal: true);
    //io.sleep(Duration(seconds: ));
    //showAlertDialog(context);
  }

  _apagarArquivo() {
    File file = File(widget.path);
    file.delete();
  }

  Future<void> _saveData() async {
    setState(() {
      _sending = true;
    });
    await checkConnection().then((internet) async {
      if (internet) {
        int numWav = await database.incrementNumero('num_arquivo');
        String nameWav = 'APX-$numWav';

        String nameTranscricaoWav =
            await Diretorio('/GravacaoApp').getNomeDoArquivo('/$nameWav.txt');
        io.File transcricao = io.File(nameTranscricaoWav);
        transcricao.writeAsString(widget.vogal);

        Reference uploadWav = firebaseStorage
            .ref()
            .child('folders')
            .child(widget.folderName)
            .child(nameWav + '.wav');

        await uploadWav.putFile(File(widget.path));

        Reference uploadTranscricao = firebaseStorage
            .ref()
            .child('folders')
            .child(widget.folderName)
            .child(nameWav + '.txt');

        await uploadTranscricao.putFile(File(nameTranscricaoWav));

        Reference uploadTxt = firebaseStorage
            .ref()
            .child('voluntarios')
            .child(widget.folderName + '.txt');

        await uploadTxt.putFile(widget.informacoesPessoais);

        _apagarArquivo();

        setState(() {
          _sending = false;
        });

        Provider.of<Vogais>(context, listen: false)
            .updateStatusVogal(widget.vogal);

        String ultimaVogal =
            Provider.of<Vogais>(context, listen: false).getUltimaVogal();

        if (widget.vogal != ultimaVogal) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const FinalScreen()));
        }
      } else {
        Navigator.of(context).pop();
        showGeneralDialog(
            context: context,
            barrierColor: Colors.black54,
            pageBuilder: (_, __, ___) => const ErroConection());
      }
    });
  }

  Future<bool> checkConnection() async {
    var connectivityResult =
        await (connection.Connectivity().checkConnectivity());
    if (connectivityResult == connection.ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == connection.ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text(
        "O ÁUDIO FOI GRAVADO SEM INTERFERÊNCIAS?",
        style: TextStyle(color: Colors.white, fontFamily: 'MochiyPopOne'),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      elevation: 5.0,
      actions: [
        TextButton(
          onPressed: () {
            // _apagarArquivo();
            widget.audioPlayer.stop();
            Navigator.of(context).pop();
          },
          child: const Text(
            "Não",
            style: TextStyle(color: Colors.white, fontFamily: 'MochiyPopOne'),
          ),
        ),
        _sending
            ? const SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  color: Color(0xFF0f0882),
                ),
              )
            : TextButton(
                onPressed: () {
                  _saveData();
                },
                child: const Text(
                  "Sim",
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'MochiyPopOne'),
                ),
              ),
      ],
    );
  }
}

//------------------------------------------------------------------------------

// class ReprodutorWav {
//   BuildContext context;
//   String email;
//   String path;
//   File informacoesPessoais;
//   String vogal;
//   AudioPlayer audioPlayer = AudioPlayer();
//   final firebaseStorage = FirebaseStorage.instance;

//   ReprodutorWav({
//     required this.context,
//     required this.email,
//     required this.path,
//     required this.informacoesPessoais,
//     required this.vogal,
//   });

//   ouvirAudio() async {
//     audioPlayer.play(path, isLocal: true);
//     //io.sleep(Duration(seconds: ));
//     showAlertDialog(context);
//   }

//   _apagarArquivo() {
//     var file = File(path);
//     file.delete();
//   }

//   Future<void> _saveData() async {
//     await checkConnection().then((internet) async {
//       if (internet) {
//         // CircularProgressIndicator :true
//         var uploadWav = firebaseStorage
//             .ref()
//             .child('audios')
//             .child(email)
//             .child(vogal + '.wav');

//         await uploadWav.putFile(File(path));

//         var uploadTxt =
//             firebaseStorage.ref().child('voluntarios').child(email + '.txt');

//         await uploadTxt.putFile(informacoesPessoais);

//         _apagarArquivo();

//         // CircularProgressIndicator :false

//         Navigator.of(context).pop();
//         Navigator.of(context).pop();
//       } else {
//         Navigator.of(context).pop();
//         showGeneralDialog(
//             context: context,
//             barrierColor: Colors.black54,
//             pageBuilder: (_, __, ___) => const ErroConection());
//       }
//     });
//   }

//   Future<bool> checkConnection() async {
//     var connectivityResult =
//         await (connection.Connectivity().checkConnectivity());
//     if (connectivityResult == connection.ConnectivityResult.mobile) {
//       return true;
//     } else if (connectivityResult == connection.ConnectivityResult.wifi) {
//       return true;
//     }
//     return false;
//   }

//   showAlertDialog(BuildContext context) {
//     Widget apagarButton = TextButton(
//       onPressed: () {
//         // _apagarArquivo();
//         audioPlayer.stop();
//         Navigator.of(context).pop();
//       },
//       child: const Text(
//         "Não",
//         style: TextStyle(color: Colors.white, fontFamily: 'MochiyPopOne'),
//       ),
//     );

//     Widget salvarButton = TextButton(
//         onPressed: () {
//           _saveData();
//         },
//         child: const Text("Sim",
//             style: TextStyle(color: Colors.white, fontFamily: 'MochiyPopOne')));

//     AlertDialog alert = AlertDialog(
//         content: const Text(
//           "O ÁUDIO FOI GRAVADO SEM INTERFERÊNCIAS?",
//           style: TextStyle(color: Colors.white, fontFamily: 'MochiyPopOne'),
//         ),
//         backgroundColor: Theme.of(context).colorScheme.secondary,
//         elevation: 5.0,
//         actions: [
//           apagarButton,
//           salvarButton,
//         ]);
//     showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (_) {
//           return alert;
//         });
//   }
// }
