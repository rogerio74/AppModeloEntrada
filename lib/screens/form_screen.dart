import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Formulario extends StatefulWidget {
  const Formulario({ Key? key }) : super(key: key);

  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  String _nomeArquivo = '';
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
            child: Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.52,
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
                            child: ElevatedButton(onPressed: (){
                              if(_formKey.currentState!.validate()){
                                
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
        ),
      ),
    );
  }
}