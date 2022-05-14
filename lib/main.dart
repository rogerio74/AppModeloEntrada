import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modelo_app/database/dados_bd.dart';
import 'package:modelo_app/database/firebase_dao.dart';
import 'package:modelo_app/models/vogais_map.dart';
import 'package:modelo_app/screens/termos_de_uso_screen.dart';
import 'package:modelo_app/theme/theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Map<String, Map<String, dynamic>> mapVogais = {
    'u': {
      'lock': true,
      'num': 0,
    },
    'ó': {
      'lock': true,
      'num': 0,
    },
    'ô': {
      'lock': true,
      'num': 0,
    },
    'i': {
      'lock': true,
      'num': 0,
    },
    'ê': {
      'lock': true,
      'num': 0,
    },
    'é': {
      'lock': true,
      'num': 0,
    },
    'a': {
      'lock': false,
      'num': 0,
    },
  };

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Vogais(
            map: mapVogais,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => FirebaseDao(),
        ),
        ChangeNotifierProvider(
          create: (context) => DadosBD(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData();
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppModeloEntradaTheme.theme,
      home: TermosScreen(),
    );
  }
}
