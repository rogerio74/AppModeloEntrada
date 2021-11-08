import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modelo_app/screens/audios_screens.dart';
import 'package:modelo_app/components/diretorio.dart';

class Formulario extends StatefulWidget {
  const Formulario({ Key? key }) : super(key: key);

  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _sexoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
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
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                       // border: Border.all(color: Colors.white, width: 2),
                        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                      ),
                    
                      child: Column(
                        children: [
                          const Text('CADASTRE-SE', style: TextStyle(fontFamily: 'MochiyPopOne', fontWeight: FontWeight.bold, color: Color(0xFF0f0882)),),
                          Form(
                            key: _formKey,
                            child:
                              Column(
                                children: [
                                  TextFormField(
                                    controller: _nomeController,
                                    validator: (nome){
                                      if(nome!.isEmpty){
                                        return "Preencha o nome";
                                      }else if(nome.isNotEmpty){
                                        return null;
                                      }
                                    },
                                    onSaved: (nome){
                                      setState(() {
                                        _nomeController.text = nome!;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'Nome',
                                      labelStyle: TextStyle(fontFamily: 'MochiyPopOne', fontSize: 16, color: Color(0xFF0f0882))
                                    ),
                                  ),
                    
                                  TextFormField(
                                    controller: _idadeController,
                                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                    decoration: const InputDecoration(
                                      labelText: 'Idade',
                                      labelStyle: TextStyle(fontFamily: 'MochiyPopOne', fontSize: 16, color: Color(0xFF0f0882))
                                    ),
                                     validator: (idade){
                                      if(idade!.isEmpty){
                                        return "Preencha a idade";
                                      }else if(idade.isNotEmpty){
                                        return null;
                                      }
                                    },
                                  ),
                    
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text('Sexo:', style: TextStyle(fontFamily: 'MochiyPopOne', fontSize: 16, color: Color(0xFF0f0882)),),                       
                                       DropdownButton(
                                        hint: Text(_sexoController.text, style: const TextStyle(color: Color(0xFF0f0882)),),
                                        items: ['F', 'M'].map((String sexo){
                                          return DropdownMenuItem<String>(
                                            value: sexo,
                                            child: Text(sexo),
                                          );
                                        }).toList(),
                                        onChanged: (sexo){
                                          setState(() {
                                            _sexoController.text = sexo.toString();
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    width: 180,
                                    child: ElevatedButton(onPressed: () async{
                                      if(_formKey.currentState!.validate()){
                                        String pathInformacoes = await Diretorio('/GravacaoApp').getNomeDoArquivo('/${_nomeController.text}.txt');
                                        io.File informacoesPessoais = io.File(pathInformacoes);
                                        informacoesPessoais.writeAsString('NOME: ${_nomeController.text}\nIDADE:${_idadeController.text}\nSEXO: ${_sexoController.text}');
                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AudiosScreen(informacoesPessoais: informacoesPessoais,)));
                                      }
                                    }, child: const Text('GRAVAR ÁUDIOS'),
                                    style: ElevatedButton.styleFrom(
                                      primary: const Color(0xFF0f0882)
                                    ),
                                    ),
                                  )
                                ],
                              )
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}