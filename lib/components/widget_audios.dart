import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modelo_app/screens/gravacao_screen.dart';

class WidgetAudio extends StatelessWidget {
  final String vogal;
  final String folderName;
  final File informacoesPessoais;
  const WidgetAudio(
      {Key? key,
      required this.vogal,
      required this.informacoesPessoais,
      required this.folderName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => GravacaoScreen(
                    vogal: vogal,
                    informacoesPessoais: informacoesPessoais,
                    folderName: folderName)));
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
            vogal,
            style: const TextStyle(
                fontFamily: 'MochiyPopOne',
                fontWeight: FontWeight.bold,
                color: Color(0xFF0f0882),
                fontSize: 25.0),
          )),
        ),
        const Positioned(
          left: 15,
          top: 15,
          child: Icon(
            Icons.lock,
            size: 30,
            color: Colors.amber,
          ),
        ),
      ]),
    );
  }
}
