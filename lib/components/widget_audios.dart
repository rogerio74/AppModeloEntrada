import 'package:flutter/material.dart';

class WidgetAudio extends StatelessWidget {
  final String audioLetra;
  const WidgetAudio({ Key? key, required this.audioLetra}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(decoration:  BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      margin: const EdgeInsets.all(10),
      child: Center(child: Text(audioLetra, style: const TextStyle(fontFamily: 'MochiyPopOne', fontWeight: FontWeight.bold, color: Color(0xFF0f0882), fontSize: 25.0),)),
      ),
    );
  }
}