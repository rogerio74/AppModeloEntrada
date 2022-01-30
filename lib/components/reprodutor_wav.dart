import 'dart:io' as io;
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:modelo_app/components/diretorio.dart';
import 'package:modelo_app/components/erro_internet.dart';
import 'package:modelo_app/models/check_connection.dart';
import 'package:modelo_app/database/firebase_dao.dart';
import 'package:modelo_app/models/vogais_map.dart';
import 'package:modelo_app/screens/final_sreen.dart';
import 'package:provider/provider.dart';

class ReprodutorWav extends StatefulWidget {
  final BuildContext context;
  final String folderName;
  final String path;
  final String vogal;
  final String numeroArquivo;
  final AudioPlayer audioPlayer = AudioPlayer();
  ReprodutorWav({
    Key? key,
    required this.context,
    required this.folderName,
    required this.path,
    required this.vogal,
    required this.numeroArquivo,
  }) : super(key: key);

  @override
  _ReprodutorWavState createState() => _ReprodutorWavState();
}

class _ReprodutorWavState extends State<ReprodutorWav> {
  final firebaseStorage = FirebaseStorage.instance;
  bool _sending = false;

  ouvirAudio() async {
    widget.audioPlayer.play(widget.path, isLocal: true);
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
        String nameWav = 'APX-${widget.numeroArquivo}';

        String pathTranscricaoWav =
            await Diretorio('/GravacaoApp').getNomeDoArquivo('/$nameWav.txt');
        io.File transcricao = io.File(pathTranscricaoWav);
        transcricao
            .writeAsString('${widget.vogal} ${widget.vogal} ${widget.vogal}');

        await Provider.of<FirebaseDao>(
          context,
          listen: false,
        ).uploadWavAndTranscricao(
          folderName: widget.folderName,
          fileName: nameWav,
          audioPath: widget.path,
          transcricaoPath: pathTranscricaoWav,
        );

        _apagarArquivo();

        setState(() {
          _sending = false;
        });

        String ultimaVogal =
            Provider.of<Vogais>(context, listen: false).getUltimaVogal();

        if (widget.vogal == ultimaVogal) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const FinalScreen()));
        } else {
          Provider.of<Vogais>(context, listen: false)
              .updateStatusVogal(widget.vogal);

          Navigator.of(context).pop();
          Navigator.of(context).pop();
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
        _sending
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // _apagarArquivo();
                      widget.audioPlayer.stop();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Não",
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'MochiyPopOne'),
                    ),
                  ),
                  TextButton(
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
              )
      ],
    );
  }
}
