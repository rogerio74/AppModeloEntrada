import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:modelo_app/components/erro_internet.dart';
import 'package:modelo_app/models/check_connection.dart';
import 'package:modelo_app/models/realtime.dart';
import 'package:modelo_app/components/diretorio.dart';
import 'package:modelo_app/models/vogais_map.dart';
import 'package:modelo_app/screens/audios_screens.dart';
import 'package:modelo_app/screens/final_sreen.dart';
import 'package:provider/provider.dart';

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
    String content = '$nomePasta\n$email\n$nome\n$idade\n$sexo';
    return content;
  }

  String _getFolderName(sexo, numPasta) {
    String name = 'APX-$sexo$numPasta';
    return name;
  }

  String convertNumeroPasta(int numero) {
    String numeroString = numero.toString();
    if (numeroString.length == 1) {
      return '000$numero';
    } else if (numeroString.length == 2) {
      return '00$numero';
    } else if (numeroString.length == 3) {
      return '0$numero';
    } else {
      return numeroString;
    }
  }

  Future<void> _showAlertDialogUpdate(
    String idUser,
  ) async {
    Map _userData = await database.getUserWithId(idUser);

    String _nome = _userData['nome'];
    String _idade = _userData['idade'];
    String _sexo = _userData['sexo'];
    int _numArquivos = _userData['numArquivos'];
    String _numPasta = _userData['numPasta'];
    String _email = _userData['email'];

    Map<String, dynamic> newUserData = {
      'email': _email,
      'nome': _nomeController.text,
      'idade': _idadeController.text,
      'sexo': _sexoController.text
    };
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'E-mail em uso',
              style: TextStyle(
                fontFamily: 'MochiyPopOne',
                color: Color(0xFF0f0882),
                fontSize: 16,
              ),
            ),
            backgroundColor: Colors.grey.shade200,
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Text(
                    'O e-mail inserido está em uso. \nComo deseja proseguir?',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: 'MochiyPopOne',
                      fontSize: 14,
                      color: Color(0xFF0f0882),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Dados:\n-Nome: $_nome\n-Idade: $_idade\n-Sexo: $_sexo',
                    style: const TextStyle(
                      fontFamily: 'MochiyPopOne',
                      fontSize: 14,
                      color: Color(0xFF0f0882),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'OBS: ao prosseguir com este e-mail, os áudios já gravados serão sobrescritos por novos áudios.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: 'MochiyPopOne',
                      fontSize: 10,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 30,
                          child: AlertDialog(
                            title: const Text(
                              'Confirmar',
                              style: TextStyle(
                                fontFamily: 'MochiyPopOne',
                                color: Color(0xFF0f0882),
                                fontSize: 16,
                              ),
                            ),
                            backgroundColor: Colors.grey.shade200,
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const [
                                  Text(
                                    'Tem certeza?',
                                    style: TextStyle(
                                      fontFamily: 'MochiyPopOne',
                                      fontSize: 14,
                                      color: Color(0xFF0f0882),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: const Color(0xFF0f0882),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text(
                                      'NÃO',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: const Color(0xFF0f0882),
                                    ),
                                    onPressed: () async {
                                      await database.updateUserData(
                                          idUser, newUserData);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  AudiosScreen(
                                                    folderName: _numPasta,
                                                    numeroArquivos:
                                                        _numArquivos,
                                                  )));
                                    },
                                    child: const Text(
                                      'SIM',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      });
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF0f0882),
                ),
                child: const Text(
                  'PROSSEGUIR COM ESTE E-MAIL',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF0f0882),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'INSERIR NOVO EMAIL',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        });
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
                                    if (idade!.isEmpty || idade.contains(' ')) {
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
                                        margin: const EdgeInsets.only(top: 10),
                                        width: 140,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                _processing = true;
                                              });
                                              await checkConnection().then(
                                                (internet) async {
                                                  if (internet) {
                                                    String? isUsedEmail =
                                                        await database
                                                            .isUsedEmail(
                                                                _emailController
                                                                    .text);
                                                    if (isUsedEmail != null) {
                                                      await _showAlertDialogUpdate(
                                                        isUsedEmail,
                                                      );

                                                      setState(() {
                                                        _processing = false;
                                                      });
                                                    } else {
                                                      int _numeroPasta =
                                                          await database
                                                              .incrementNumero(
                                                                  'num_pasta',
                                                                  1);
                                                      String
                                                          _numeroPastaConvertido =
                                                          convertNumeroPasta(
                                                              _numeroPasta);
                                                      int numArquivo =
                                                          Provider.of<Vogais>(
                                                                  context,
                                                                  listen: false)
                                                              .getNumElementos;
                                                      int _numeroArquivos =
                                                          await database
                                                              .incrementNumero(
                                                                  'num_arquivo',
                                                                  numArquivo);
                                                      String _nomeDaPasta =
                                                          _getFolderName(
                                                              _sexoController
                                                                  .text,
                                                              _numeroPastaConvertido);
                                                      await database
                                                          .sendNewUserData(
                                                              _emailController
                                                                  .text,
                                                              _nomeController
                                                                  .text,
                                                              _idadeController
                                                                  .text,
                                                              _sexoController
                                                                  .text,
                                                              _nomeDaPasta,
                                                              _numeroArquivos);

                                                      await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              AudiosScreen(
                                                            folderName:
                                                                _nomeDaPasta,
                                                            numeroArquivos:
                                                                _numeroArquivos,
                                                          ),
                                                        ),
                                                      );

                                                      setState(
                                                        () {
                                                          _processing = false;
                                                        },
                                                      );
                                                    }
                                                  } else {
                                                    setState(
                                                      () {
                                                        _processing = false;
                                                      },
                                                    );
                                                    showGeneralDialog(
                                                        context: context,
                                                        barrierColor:
                                                            Colors.black54,
                                                        pageBuilder: (_, __,
                                                                ___) =>
                                                            const ErroConection());
                                                  }
                                                },
                                              );
                                            }
                                          },
                                          child: const Text('GRAVAR ÁUDIOS'),
                                          style: ElevatedButton.styleFrom(
                                              primary: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                              ],
                            ),
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
