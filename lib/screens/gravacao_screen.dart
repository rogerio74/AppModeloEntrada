import 'dart:io';
import 'package:flutter/material.dart';
import 'package:modelo_app/components/recorder_wav.dart';
import 'package:modelo_app/components/reprodutor_wav.dart';


class GravacaoScreen extends StatefulWidget {
  final File informacoesPessoais;
  final String vogal;
  final String nome;
  const GravacaoScreen({ Key? key, required this.informacoesPessoais, required this.vogal, required this.nome}) : super(key: key);

  @override
  _GravacaoScreenState createState() => _GravacaoScreenState();
}

class _GravacaoScreenState extends State<GravacaoScreen> {

  RecorderWav recorder = RecorderWav();

  @override
  void initState() {
    super.initState();
    recorder.init();
  }

  @override
  void dispose() {
    recorder.dispose();
    super.dispose();
  }

  Widget _construirBotaoGravacao(BuildContext context) {
    return Container(
      decoration:
           BoxDecoration(color: Theme.of(context).colorScheme.secondary, shape: BoxShape.circle),
      child: IconButton(
        onPressed: () async {
          if (recorder.isRecording) {
            await recorder.stop();
            ReprodutorWav reprodutorWav = ReprodutorWav(
                context: context,
                informacoesPessoais: widget.informacoesPessoais,
                nome: widget.nome,
                vogal: widget.vogal,
                path: recorder.path!);
            reprodutorWav.ouvirAudio();
          } else {
            await recorder.start();
          }
        },
        icon: Icon(recorder.isRecording ? Icons.stop : Icons.mic_outlined),
        color: const Color(0xFF00d4ff),
        iconSize: 100,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Record', style: TextStyle(fontFamily: 'MochiyPopOne'),), backgroundColor: const Color(0xFF160bac),),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF0f0882),
            Color(0xFF00d4ff)                            
          ],
          begin: Alignment.topCenter,
          end: AlignmentDirectional.bottomCenter
          )
        ),
          child: Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.78,
              height: MediaQuery.of(context).size.height *0.75,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.all(Radius.circular(50.0))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:  [
                  Text(widget.vogal, style: const TextStyle(fontFamily: 'MochiyPopOne',fontSize: 150, color: Color(0xFF0f0882)),),
                  Text(_status),
                  _construirBotaoGravacao(context)
              ],),
            ),
          ),
        )
      ,),
    );
  }

  
}