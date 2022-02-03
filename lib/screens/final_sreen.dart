import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modelo_app/models/vogais_map.dart';
import 'package:modelo_app/screens/termos_de_uso_screen.dart';
import 'package:provider/provider.dart';

class FinalScreen extends StatefulWidget {
  const FinalScreen({Key? key}) : super(key: key);

  @override
  State<FinalScreen> createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  bool _isExiting = false;
  Future<void> exit() async {
    setState(() {
      _isExiting = true;
    });
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    setState(() {
      _isExiting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    const String finalMessage =
        'A equipe do projeto\nComuniCARE APRAXIA\nagradece a sua contribuição!';
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
              height: MediaQuery.of(context).size.height * 0.5,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            finalMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'MochiyPopOne',
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0f0882)),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Consumer<Vogais>(builder: (context, vogais, child) {
                            return ElevatedButton(
                              onPressed: () {
                                vogais.getNewMapVogais();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TermosScreen()),
                                    (Route<dynamic> route) => false);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0xFF0f0882),
                              ),
                              child: const Text(
                                'GRAVAR NOVOS ÁUDIOS',
                                style: TextStyle(
                                    fontFamily: 'MochiyPopOne',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          _isExiting
                              ? const CircularProgressIndicator(
                                  color: Color(0xFF0f0882),
                                )
                              : ElevatedButton(
                                  onPressed: () async {
                                    await exit();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFF0f0882),
                                  ),
                                  child: const Text(
                                    'SAIR',
                                    style: TextStyle(
                                        fontFamily: 'MochiyPopOne',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
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
