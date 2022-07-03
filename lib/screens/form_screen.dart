import 'package:flutter/material.dart';
import 'package:modelo_app/components/alert_dialog_update.dart';
import 'package:modelo_app/components/erro_internet.dart';
import 'package:modelo_app/models/check_connection.dart';
import 'package:modelo_app/database/firebase_dao.dart';
import 'package:modelo_app/models/vogais_map.dart';
import 'package:modelo_app/screens/audios_screens.dart';
import 'package:provider/provider.dart';

const List<String> estados = [
  'AC',
  'AL',
  'AP',
  'AM',
  'BA',
  'CE',
  'ES',
  'GO',
  'MA',
  'MT',
  'MS',
  'MG',
  'PA',
  'PB',
  'PR',
  'PE',
  'PI',
  'RJ',
  'RN',
  'RS',
  'RO',
  'RR',
  'SC',
  'SP',
  'SE',
  'TO',
  'DF'
];

class Formulario extends StatefulWidget {
  const Formulario({Key? key}) : super(key: key);

  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  bool _processing = false;
  bool _fluente = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _sexoController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();

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
    Map _userData = await Provider.of<FirebaseDao>(context, listen: false)
        .getUserWithId(idUser);

    String _nome = _userData['nome'];
    String _idade = _userData['idade'];
    String _sexo = _userData['sexo'];
    int _numArquivos = _userData['numArquivos'];
    String _numPasta = _userData['numPasta'];
    String _email = _userData['email'];
    bool _fluenteOld = _userData['fluente'];
    String _estado = _userData['estado'];

    Map<String, dynamic> newData = {
      'nome': _nomeController.text,
      'idade': _idadeController.text,
      'sexo': _sexoController.text,
      'fluente': _fluente,
      'numArquivos': _numArquivos,
      'numPasta': _numPasta,
      'email': _email,
      'estado': _estadoController.text,
    };
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        print('Estado: ${_estadoController.text}');
        return UpdateAlertDialog(
          nome: _nome,
          idade: _idade,
          sexo: _sexo,
          fluente: _fluenteOld,
          estado: _estado,
        );
      },
    ).then((result) async {
      if (result == true) {
        Provider.of<Vogais>(context, listen: false).getNewMapVogais();
        String _folderName =
            await Provider.of<FirebaseDao>(context, listen: false)
                .updateUserData(idUser, newData, _numPasta);
        setState(() {
          _processing = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => AudiosScreen(
              folderName: _folderName,
              numeroArquivos: _numArquivos,
              fluente: _fluente,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Theme.of(context).primaryColor,
          const Color(0xFF00d4ff)
        ], begin: Alignment.topCenter, end: AlignmentDirectional.bottomCenter)),
        child: Center(
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.55,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  ),
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          Text('CADASTRE-SE',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                SwitchListTile(
                                  subtitle: Text(
                                    '(${_fluente ? "Sou falante fluente" : "Preciso treinar minha fala"})',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        ?.copyWith(
                                            fontSize: 10, color: Colors.red),
                                  ),
                                  title: Text(
                                    _fluente
                                        ? "Falante fluente"
                                        : "Falante não fluente",
                                  ),
                                  activeColor: Theme.of(context).primaryColor,
                                  value: _fluente,
                                  onChanged: (isfluente) {
                                    setState(() {
                                      _fluente = isfluente;
                                    });
                                  },
                                ),
                                TextFormField(
                                  style: Theme.of(context).textTheme.subtitle2,
                                  controller: _emailController,
                                  validator: (email) => _validateEmail(email),
                                  onSaved: (email) {
                                    setState(() {
                                      _nomeController.text = email!;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'E-mail'),
                                ),
                                TextFormField(
                                  style: Theme.of(context).textTheme.subtitle2,
                                  controller: _nomeController,
                                  validator: (nome) {
                                    if (nome!.isEmpty) {
                                      return "Preencha o nome";
                                    } else if (nome.isNotEmpty) {
                                      return null;
                                    }
                                    return null;
                                  },
                                  onSaved: (nome) {
                                    setState(() {
                                      _nomeController.text = nome!;
                                    });
                                  },
                                  decoration:
                                      const InputDecoration(labelText: 'Nome'),
                                ),
                                TextFormField(
                                  style: Theme.of(context).textTheme.subtitle2,
                                  controller: _idadeController,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  decoration:
                                      const InputDecoration(labelText: 'Idade'),
                                  validator: (idade) {
                                    if (idade!.isEmpty || idade.contains(' ')) {
                                      return "Preencha com uma idade válida";
                                    } else if (idade.isNotEmpty) {
                                      return null;
                                    }
                                    return null;
                                  },
                                ),
                                DropdownButtonFormField(
                                  iconSize: 32,
                                  hint: Text(
                                    _sexoController.text,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  items: ['Feminino', 'Masculino']
                                      .map((String sexo) {
                                    return DropdownMenuItem<String>(
                                      value: sexo,
                                      child: Text(
                                        sexo,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                    );
                                  }).toList(),
                                  decoration:
                                      const InputDecoration(labelText: 'Sexo'),
                                  onChanged: (sexo) {
                                    setState(() {
                                      String _strSexo = sexo.toString();
                                      _sexoController.text = _strSexo[0];
                                    });
                                  },
                                  onSaved: (sexo) {
                                    setState(() {
                                      String _strSexo = sexo.toString();
                                      _sexoController.text = _strSexo[0];
                                    });
                                  },
                                  validator: (sexo) {
                                    if (sexo == null) {
                                      return "Preencha com o sexo";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                DropdownButtonFormField(
                                  iconSize: 32,
                                  hint: Text(
                                    _estadoController.text,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  items: estados.map((String estado) {
                                    return DropdownMenuItem<String>(
                                      value: estado,
                                      child: Text(
                                        estado,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                    );
                                  }).toList(),
                                  decoration: const InputDecoration(
                                      labelText: 'Estado'),
                                  onChanged: (estado) {
                                    setState(() {
                                      _estadoController.text =
                                          estado.toString();
                                      print(_estadoController.text);
                                    });
                                  },
                                  onSaved: (estado) {
                                    setState(() {
                                      _estadoController.text =
                                          estado.toString();
                                      print(_estadoController.text);
                                    });
                                  },
                                  validator: (estado) {
                                    if (estado == null) {
                                      return "Preencha com o estado onde você reside";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                _processing
                    ? const SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(),
                      )
                    : Flexible(
                        child: Container(
                          margin: const EdgeInsets.only(top: 15),
                          width: 140,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(50, 20)),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _processing = true;
                                });
                                await checkConnection().then(
                                  (internet) async {
                                    if (internet) {
                                      String? isUsedEmail =
                                          await Provider.of<FirebaseDao>(
                                        context,
                                        listen: false,
                                      ).isUsedEmail(_emailController.text);
                                      if (isUsedEmail != null) {
                                        await _showAlertDialogUpdate(
                                          isUsedEmail,
                                        );

                                        setState(() {
                                          _processing = false;
                                        });
                                      } else {
                                        int _numeroPasta =
                                            await Provider.of<FirebaseDao>(
                                          context,
                                          listen: false,
                                        ).incrementNumero('num_pasta', 1);
                                        String _numeroPastaConvertido =
                                            convertNumeroPasta(_numeroPasta);
                                        int numArquivo = Provider.of<Vogais>(
                                                context,
                                                listen: false)
                                            .getNumElementos;
                                        int _numeroArquivos =
                                            await Provider.of<FirebaseDao>(
                                          context,
                                          listen: false,
                                        ).incrementNumero(
                                                'num_arquivo', numArquivo);
                                        String _nomeDaPasta = _getFolderName(
                                            _sexoController.text,
                                            _numeroPastaConvertido);
                                        await Provider.of<FirebaseDao>(
                                          context,
                                          listen: false,
                                        ).sendNewUserData(
                                            email: _emailController.text,
                                            nome: _nomeController.text,
                                            idade: _idadeController.text,
                                            sexo: _sexoController.text,
                                            numPasta: _nomeDaPasta,
                                            numArquivos: _numeroArquivos,
                                            fluente: _fluente,
                                            estado: _estadoController.text);

                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                AudiosScreen(
                                              folderName: _nomeDaPasta,
                                              numeroArquivos: _numeroArquivos,
                                              fluente: _fluente,
                                            ),
                                          ),
                                        );
                                      }
                                      setState(
                                        () {
                                          _processing = false;
                                        },
                                      );
                                    } else {
                                      setState(() {
                                        _processing = false;
                                      });
                                      showGeneralDialog(
                                        context: context,
                                        barrierColor: Colors.black54,
                                        pageBuilder: (_, __, ___) =>
                                            const ErroConection(),
                                      );
                                    }
                                  },
                                );
                              }
                            },
                            child: const Text('GRAVAR ÁUDIOS'),
                          ),
                        ),
                      ),
                // SizedBox(
                //   height: 20,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
