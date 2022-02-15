import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modelo_app/models/termos.dart';
import 'package:modelo_app/screens/form_screen.dart';

class TermosScreen extends StatefulWidget {
  const TermosScreen({Key? key}) : super(key: key);

  @override
  State<TermosScreen> createState() => _TermosScreenState();
}

class _TermosScreenState extends State<TermosScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isButtonDisabled = true;
  bool _isExiting = false;

  Future<void> _exit() async {
    setState(() {
      _isExiting = true;
    });
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    setState(() {
      _isExiting = false;
      _isButtonDisabled = true;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _isButtonDisabled = false;
        });
        print('Completado!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                Theme.of(context).primaryColor,
                const Color(0xFF00d4ff)
              ],
                  begin: Alignment.topCenter,
                  end: AlignmentDirectional.bottomCenter)),
          child: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      // padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: ListBody(children: termos),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _isButtonDisabled
                            ? null
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const Formulario(),
                                  ),
                                );
                                setState(() {
                                  _isButtonDisabled = true;
                                });
                              },
                        child: const Text(
                          'Aceitar',
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: _isButtonDisabled
                            ? null
                            : () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      child: AlertDialog(
                                        title: const Text(
                                          'Confirmar Rejeição',
                                        ),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: const [
                                              Text(
                                                'Você está rejeitando colaborar com a pesquisa. Tem certeza?',
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          _isExiting
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    CircularProgressIndicator(),
                                                  ],
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child: Text(
                                                        'NÃO',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .button,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        _exit();
                                                      },
                                                      child: Text(
                                                        'SIM',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .button,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                        child: const Text(
                          'Rejeitar',
                        ),
                      ),
                    ],
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
