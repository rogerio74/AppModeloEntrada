import 'dart:io';
import 'package:flutter/material.dart';
import 'package:modelo_app/screens/gravacao_screen.dart';

class WidgetAudio extends StatefulWidget {
  final String vogal;
  final String folderName;
  final File informacoesPessoais;
  final bool isButtonDisabled;
  final String numeroArquivo;

  const WidgetAudio({
    Key? key,
    required this.vogal,
    required this.informacoesPessoais,
    required this.folderName,
    required this.isButtonDisabled,
    required this.numeroArquivo,
  }) : super(key: key);

  @override
  State<WidgetAudio> createState() => _WidgetAudioState();
}

class _WidgetAudioState extends State<WidgetAudio> {
  Icon lockIcon = const Icon(
    Icons.lock_open_outlined,
    size: 30,
    color: Color(0xFF160bac),
  );
  Icon unlockIcon = const Icon(
    Icons.lock_outline,
    size: 30,
    color: Color(0xFF160bac),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.isButtonDisabled
            ? null
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => GravacaoScreen(
                        numeroArquivo: widget.numeroArquivo,
                        vogal: widget.vogal,
                        informacoesPessoais: widget.informacoesPessoais,
                        folderName: widget.folderName)));
      },
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          margin: const EdgeInsets.all(10),
          child: Center(
              child: Text(
            widget.vogal.toUpperCase(),
            style: const TextStyle(
                fontFamily: 'MochiyPopOne',
                fontWeight: FontWeight.bold,
                color: Color(0xFF0f0882),
                fontSize: 25.0),
          )),
        ),
        Positioned(
            left: 15,
            top: 15,
            child: widget.isButtonDisabled ? unlockIcon : lockIcon),
      ]),
    );
  }
}
