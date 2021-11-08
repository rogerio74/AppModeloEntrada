import 'package:flutter/material.dart';

class ErroConection extends StatelessWidget {
  const ErroConection({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)), color: Theme.of(context).colorScheme.secondary,),
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Não foi possível avaliar a captura do áudio dessa atividade em nossos serviços. Por favor verifique sua conexão com a internet e tente novamente', 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                   SizedBox(
                     width: 100,
                     child: ElevatedButton(onPressed: (){
                       Navigator.pop(context);
                     }, child:  Text('SAIR', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                     style: ElevatedButton.styleFrom(
                       primary: Colors.yellow
                     ),),
                   ),
                   SizedBox(
                     width: 100,
                     child: ElevatedButton(onPressed: (){}, child: Text('REPETIR', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight:FontWeight.bold)),
                     style: ElevatedButton.styleFrom(
                       primary: Colors.yellow
                     ),
                     ))
                ],),
               
              ],
            ),
          ),
        ],
      ),
    );
  }
}