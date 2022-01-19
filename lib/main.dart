import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modelo_app/models/vogais_map.dart';
import 'package:modelo_app/screens/form_screen.dart';
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
    'e': {
      'lock': true,
      'num': 0,
    },
    'ã': {
      'lock': true,
      'num': 0,
    },
    'a': {
      'lock': false,
      'num': 0,
    },
  };

  runApp(ChangeNotifierProvider(
    create: (context) => Vogais(map: mapVogais),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData();
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xFF0f0882),
        colorScheme:
            theme.colorScheme.copyWith(secondary: const Color(0xFF160bac)),
      ),
      home: const Formulario(),
    );
  }
}
