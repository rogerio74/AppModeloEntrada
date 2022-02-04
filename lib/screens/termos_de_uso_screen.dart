import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modelo_app/models/termos.dart';
import 'package:modelo_app/screens/form_screen.dart';

String titulo = 'Termos e condições de uso do App';
String texto =
    'Seja bem-vindo ao nosso site. Leia com atenção todos os termos abaixo.\n\n  Este documento, e todo o conteúdo do site é oferecido por Projeto Comunicare Apraxia com o endereço , neste termo representado apenas por "EMPRESA", que regulamenta todos os direitos e obrigações com todos que acessam o site, denominado neste termo como "VISITANTE", reguardado todos os direitos previstos na legislação, trazem as cláusulas abaixo como requisito para acesso e visita do mesmo.\n\n A permanência no website implica-se automaticamente na leitura e aceitação tácita do presente termos de uso a seguir. Este termo foi atualizado pela última vez em 14 de setembro de 2021.\n\n1. DA FUNÇÃO DO SITE\nEste site foi criado e desenvolvido com a função de trazer conteúdo informativo de alta qualidade, a venda de produtos físicos, digitais e a divulgação de prestação de serviço. A EMPRESA busca através da criação de conteúdo de alta qualidade, desenvolvido por profissionais da área, trazer o conhecimento ao alcance de todos, assim como a divulgação dos próprios serviços.\n\nNesta plataforma, poderá ser realizado tanto a divulgação de material original de alta qualidade, assim como a divulgação de produtos de e-commerce.\n\nTodo o conteúdo presente neste site foi desenvolvido buscando fontes e materiais de confiabilidade, assim como são baseados em estudos sérios e respeitados, através de pesquisa de alta nível.\n\nTodo o conteúdo é atualizado periodicamente, porém, pode conter em algum artigo, vídeo ou imagem, alguma informação que não reflita a verdade atual, não podendo a EMPRESA ser responsabilizada de nenhuma forma ou meio por qualquer conteúdo que não esteja devidamente atualizado.\n É de responsabilidade do usuário de usar todas as informações presentes no site com senso crítico, utilizando apenas como fonte de informação, e sempre buscando especialistas da área para a solução concreta do seu conflito.';

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
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF0f0882), Color(0xFF00d4ff)],
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
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(20, 40),
                          primary: const Color(0xFF0f0882),
                        ),
                        child: const Text(
                          'Aceitar',
                          style: TextStyle(color: Colors.white),
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
                                          _isExiting
                                              ? const CircularProgressIndicator(
                                                  color: Color(0xFF0f0882),
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xFF0f0882),
                                                      ),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child: const Text(
                                                        'NÃO',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xFF0f0882),
                                                      ),
                                                      onPressed: () async {
                                                        _exit();
                                                      },
                                                      child: const Text(
                                                        'SIM',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
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
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(20, 40),
                          primary: const Color(0xFF0f0882),
                        ),
                        child: const Text(
                          'Rejeitar',
                          style: TextStyle(color: Colors.white),
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
