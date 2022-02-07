import 'package:flutter/material.dart';
import 'package:modelo_app/components/widget_audios.dart';
import 'package:modelo_app/models/vogais_map.dart';
import 'package:provider/provider.dart';

class AudiosScreen extends StatelessWidget {
  final String folderName;
  final int numeroArquivos;
  final bool fluente;

  const AudiosScreen({
    Key? key,
    required this.folderName,
    required this.numeroArquivos,
    required this.fluente,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GRAVAR',
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Theme.of(context).primaryColor,
          const Color(0xFF00d4ff)
        ], begin: Alignment.topCenter, end: AlignmentDirectional.bottomCenter)),
        child: Consumer<Vogais>(
          builder: (context, vogais, child) {
            List vogaisList = vogais.getVogaisList(numeroArquivos);
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: vogaisList.length,
                itemBuilder: (BuildContext context, int index) {
                  String numeroArquivoConvertido =
                      vogais.convertNumero(vogaisList[index][2]);
                  return WidgetAudio(
                    vogal: vogaisList[index][0],
                    folderName: folderName,
                    isButtonDisabled: vogaisList[index][1],
                    numeroArquivo: numeroArquivoConvertido,
                    fluente: fluente,
                  );
                });
          },
        ),
      ),
    );
  }
}
