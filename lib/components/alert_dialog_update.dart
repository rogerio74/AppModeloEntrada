import 'package:flutter/material.dart';

class UpdateAlertDialog extends StatelessWidget {
  final String nome;
  final String idade;
  final String sexo;
  final Widget routePage;
  const UpdateAlertDialog({
    Key? key,
    required this.nome,
    required this.idade,
    required this.sexo,
    required this.routePage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              'Dados:\n-Nome: $nome\n-Idade: $idade\n-Sexo: $sexo',
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          routePage),
                                );
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
  }
}
