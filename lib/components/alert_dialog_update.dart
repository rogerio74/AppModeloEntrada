import 'package:flutter/material.dart';

class UpdateAlertDialog extends StatelessWidget {
  final String nome;
  final String idade;
  final String sexo;

  final bool fluente;
  UpdateAlertDialog({
    Key? key,
    required this.nome,
    required this.idade,
    required this.sexo,
    required this.fluente,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String isfluente = fluente ? 'Sim' : 'Não';
    return AlertDialog(
      title: const Text(
        'E-mail em uso',
      ),
      backgroundColor: Colors.grey.shade200,
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            const Text(
              'O e-mail inserido está em uso. \nComo deseja proseguir?',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Dados:\n-Nome: $nome\n-Idade: $idade\n-Sexo: $sexo\n-fluente: $isfluente',
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'OBS: ao prosseguir com este e-mail, os dados/áudios já gravados serão sobrescritos por novos dados/audios.',
              textAlign: TextAlign.justify,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(fontSize: 10, color: Colors.red),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 30,
                    child: AlertDialog(
                      title: const Text(
                        'Confirmar',
                      ),
                      backgroundColor: Colors.grey.shade200,
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const [
                            Text(
                              'Tem certeza?',
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                'NÃO',
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            ElevatedButton(
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFF0f0882),
                              ),
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text(
                                'SIM',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).then((result) => Navigator.pop(context, result));
          },
          child: const Text(
            'PROSSEGUIR COM ESTE E-MAIL',
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'INSERIR NOVO EMAIL',
          ),
        ),
      ],
    );
  }
}
