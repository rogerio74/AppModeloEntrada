import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modelo_app/models/vogais_map.dart';
import 'package:modelo_app/screens/form_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ChangeNotifierProvider(
    create: (context) => Vogais(map: {
      'a': false,
      'ã': true,
      'e': true,
      'ê': true,
      'i': true,
      'ô': true,
      'ó': true,
      'u': true,
    }),
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
        primaryColor: Colors.green.shade300,
        colorScheme:
            theme.colorScheme.copyWith(secondary: const Color(0xFF160bac)),
      ),
      home: const Formulario(),
    );
  }
}
