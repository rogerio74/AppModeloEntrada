import 'package:flutter/material.dart';
import 'package:modelo_app/screens/gravacao_screen.dart';

class WidgetAudio extends StatefulWidget {
  final String vogal;
  final String folderName;
  final bool isButtonDisabled;
  final String numeroArquivo;
  final bool apraxico;

  const WidgetAudio({
    Key? key,
    required this.vogal,
    required this.folderName,
    required this.isButtonDisabled,
    required this.numeroArquivo,
    required this.apraxico,
  }) : super(key: key);

  @override
  State<WidgetAudio> createState() => _WidgetAudioState();
}

class _WidgetAudioState extends State<WidgetAudio> {
  Icon lockIcon = const Icon(
    Icons.lock_open_outlined,
  );
  Icon unlockIcon = const Icon(
    Icons.lock_outline,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.isButtonDisabled
            ? null
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => GravacaoScreen(
                          numeroArquivo: widget.numeroArquivo,
                          vogal: widget.vogal,
                          folderName: widget.folderName,
                          apraxico: widget.apraxico,
                        )));
      },
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          margin: const EdgeInsets.all(10),
          child: Center(
              child: Text(
            widget.vogal.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(fontSize: 25, fontWeight: FontWeight.bold),
          )),
        ),
        Positioned(
            left: 15,
            top: 15,
            child: widget.isButtonDisabled ? unlockIcon : lockIcon),
      ]),
    );
  }
}
