import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modelo_app/components/widget_audios.dart';

class AudiosScreen extends StatelessWidget {
  final File informacoesPessoais;
  final String nome;
  final List<String> audios = [
    'A',
    'Ã',
    'E',
    'Ê',
    'I',
    'Ô',
    'Ó',
    'U'

  ];
  
  AudiosScreen({ Key? key, required this.informacoesPessoais, required this.nome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GRAVAR', style: TextStyle(fontFamily: 'MochiyPopOne', fontWeight: FontWeight.bold, color: Colors.white),),
        backgroundColor: const Color(0xFF160bac),),
      body: Container(
         padding: const EdgeInsets.all(10.0),
         decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFF0f0882),
              Color(0xFF00d4ff)                            
            ],
            begin: Alignment.topCenter,
            end: AlignmentDirectional.bottomCenter
            )
          ),
        child: GridView.count(crossAxisCount: 3,
          children: List.generate(audios.length, (index){
              return WidgetAudio(vogal: audios[index], informacoesPessoais: informacoesPessoais, nome: nome);
          })
        ),
      ),
    );
  }
}