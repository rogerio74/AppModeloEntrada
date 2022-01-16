import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:modelo_app/contador/realtime.dart';
import 'package:modelo_app/components/diretorio.dart';
import 'package:modelo_app/screens/audios_screens.dart';

class Formulario extends StatefulWidget {
  const Formulario({Key? key}) : super(key: key);

  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  bool _processing = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _sexoController = TextEditingController();

  String? _validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Preencha com um e-mail válido';
    } else {
      return null;
    }
  }

  String _getContent(
      String nomePasta, String email, String nome, String idade, String sexo) {
    String content =
        'PASTA: $nomePasta\nEMAIL: $email\nNOME: $nome\nIDADE:$idade\nSEXO: $sexo';
    return content;
  }

  String _getFolderName(sexo, numPasta) {
    String name = 'APX-$sexo$numPasta';
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF0f0882), Color(0xFF00d4ff)],
                  begin: Alignment.topCenter,
                  end: AlignmentDirectional.bottomCenter)),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'CADASTRE-SE',
                            style: TextStyle(
                                fontFamily: 'MochiyPopOne',
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0f0882)),
                          ),
                          Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _emailController,
                                    validator: (email) => _validateEmail(email),
                                    onSaved: (email) {
                                      setState(() {
                                        _nomeController.text = email!;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                        labelText: 'E-mail',
                                        labelStyle: TextStyle(
                                            fontFamily: 'MochiyPopOne',
                                            fontSize: 16,
                                            color: Color(0xFF0f0882))),
                                  ),
                                  TextFormField(
                                    controller: _nomeController,
                                    validator: (nome) {
                                      if (nome!.isEmpty) {
                                        return "Preencha o nome";
                                      } else if (nome.isNotEmpty) {
                                        return null;
                                      }
                                    },
                                    onSaved: (nome) {
                                      setState(() {
                                        _nomeController.text = nome!;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                        labelText: 'Nome',
                                        labelStyle: TextStyle(
                                            fontFamily: 'MochiyPopOne',
                                            fontSize: 16,
                                            color: Color(0xFF0f0882))),
                                  ),
                                  TextFormField(
                                    controller: _idadeController,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    decoration: const InputDecoration(
                                        labelText: 'Idade',
                                        labelStyle: TextStyle(
                                            fontFamily: 'MochiyPopOne',
                                            fontSize: 16,
                                            color: Color(0xFF0f0882))),
                                    validator: (idade) {
                                      if (idade!.isEmpty ||
                                          idade.contains(' ')) {
                                        return "Preencha com uma idade válida";
                                      } else if (idade.isNotEmpty) {
                                        return null;
                                      }
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text(
                                        'Sexo:',
                                        style: TextStyle(
                                            fontFamily: 'MochiyPopOne',
                                            fontSize: 16,
                                            color: Color(0xFF0f0882)),
                                      ),
                                      DropdownButton(
                                        hint: Text(
                                          _sexoController.text,
                                          style: const TextStyle(
                                              color: Color(0xFF0f0882)),
                                        ),
                                        items: ['F', 'M'].map((String sexo) {
                                          return DropdownMenuItem<String>(
                                            value: sexo,
                                            child: Text(sexo),
                                          );
                                        }).toList(),
                                        onChanged: (sexo) {
                                          setState(() {
                                            _sexoController.text =
                                                sexo.toString();
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  _processing
                                      ? const SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: CircularProgressIndicator(
                                            color: Color(0xFF0f0882),
                                          ),
                                        )
                                      : Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          width: 140,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              setState(() {
                                                _processing = true;
                                              });
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                int _numeroPasta =
                                                    await database
                                                        .incrementNumero(
                                                            'num_pasta');
                                                String _nomeDaPasta =
                                                    _getFolderName(
                                                        _sexoController.text,
                                                        _numeroPasta);
                                                String pathInformacoes =
                                                    await Diretorio(
                                                            '/GravacaoApp')
                                                        .getNomeDoArquivo(
                                                            '/$_nomeDaPasta.txt');
                                                String content = _getContent(
                                                    _nomeDaPasta,
                                                    _emailController.text,
                                                    _nomeController.text,
                                                    _idadeController.text,
                                                    _sexoController.text);
                                                io.File informacoesPessoais =
                                                    io.File(pathInformacoes);
                                                informacoesPessoais
                                                    .writeAsString(content);
                                                setState(() {
                                                  _processing = false;
                                                });

                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            AudiosScreen(
                                                                informacoesPessoais:
                                                                    informacoesPessoais,
                                                                folderName:
                                                                    _nomeDaPasta)));
                                              }
                                            },
                                            child: const Text('GRAVAR ÁUDIOS'),
                                            style: ElevatedButton.styleFrom(
                                                primary:
                                                    const Color(0xFF0f0882)),
                                          ),
                                        )
                                ],
                              )),
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
