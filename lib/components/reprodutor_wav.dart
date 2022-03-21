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
  bool _sending = false;
  bool _playedAudio = false;

  Future<void> ouvirAudio() async {
    await widget.audioPlayer.play(widget.path, isLocal: true);
    setState(() {
      _playedAudio = true;
    });
  }

  Future<void> pararAudio() async {
    await widget.audioPlayer.stop();
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
        String nameWav = 'APX_${widget.numeroArquivo}';

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
      title: const Text('VERIFICAR QUALIDADE DO ÁUDIO'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Pressione o botão abaixo para avaliar seu áudio:'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                await ouvirAudio();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Reproduzir Áudio |",
                  ),
                  Icon(Icons.play_arrow_rounded),
                ],
              ),
            ),
          ),
          const Text(
            "O áudio foi gravado sem interferências?",
            textAlign: TextAlign.center,
          ),
        ],
      ),
      elevation: 5.0,
      actions: [
        _sending
            ? Row(
                // mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _playedAudio
                        ? () {
                            _saveData();
                          }
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Sim |",
                        ),
                        Icon(
                          Icons.done_rounded,
                          color: Colors.green,
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _playedAudio
                        ? () {
                            // _apagarArquivo();
                            widget.audioPlayer.stop();
                            Navigator.of(context).pop();
                          }
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Não |",
                        ),
                        Icon(
                          Icons.close_rounded,
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                ],
              )
      ],
    );
  }
}
